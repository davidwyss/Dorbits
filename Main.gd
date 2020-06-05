extends Spatial

export(PackedScene) var DefaultScenario
export(PackedScene) var Scenario
export(PackedScene) var PlayerScene
export(String) var SavePath = "res://save.json"
var current_info_view = null
var scenario 
var frames = 0
var scenario_loaded = false

func _process(_delta):
    $Camera/RayCast.collide_with_areas = true
    if frames % 60 == 0 && is_network_master():
        synchronize_motion()
        for sobject in scenario.get_children():
            if "energy" in sobject:
                sobject.rset("energy", sobject.energy)
    frames+=1
    
func _input(_event):
    if Input.is_action_just_pressed("select_celestial_object"):
        var collider = $Camera/RayCast.get_collider()
        if current_info_view != null:
            $HUD.remove_child(current_info_view)
            current_info_view = null
        if collider != null && collider.has_method("get_info_panel"):
            current_info_view = collider.get_info_panel()
            $HUD.add_child(current_info_view)
            
func _ready():
    connect_pause_menu()
    load_scenario(DefaultScenario.instance())
    $HUD/PauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS
    # warning-ignore:return_value_discarded
    get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
    # warning-ignore:return_value_discarded
    get_tree().connect('server_disconnected', self, '_on_server_disconnected')
    # warning-ignore:return_value_discarded
    #    Network.connect('player_ready', self, '_on_player_ready')
    var new_player = Node.new()
    new_player.name = str(get_tree().get_network_unique_id())
    new_player.set_network_master(get_tree().get_network_unique_id())
    add_child(new_player)
    # var info = Network.self_data

func _physics_process(_delta):
    if scenario_loaded:
        for star in scenario.get_children():
            if "solar_surface_kelvin" in star:
                for sat in scenario.get_children():
                    if sat.has_method("receive_solar_energy"):
                        for panel in sat.panels:
                            panel.receive_solar_energy(sat.translation.distance_to(star.translation),star.total_solar_luminosity())

#func _on_player_ready(_id,_name):
#    if get_tree().is_network_server():
#        var player = PlayerScene.instance()
#        player.id = _id
#        player.name = _name
#        $Scenario.spawn_player_rift(player)
#        $HUD.add_child(player)
    
func _on_player_disconnected(id):
    get_node(str(id)).queue_free()

func _on_server_disconnected():
    # warning-ignore:return_value_discarded 
    get_tree().change_scene('res://GUIs/MainMenus/MainMenu.tscn')

func connect_pause_menu():
    # warning-ignore:return_value_discarded
    $HUD/PauseMenu/LoadDefaultSceneButton.connect("pressed",self,"load_scenario",[DefaultScenario.instance()])
    # warning-ignore:return_value_discarded
    $HUD/PauseMenu/QuickSaveButton.connect("pressed",self,"save_game",[SavePath])
    # warning-ignore:return_value_discarded
    $HUD/PauseMenu/QuickLoadButton.connect("pressed",self,"load_game",[SavePath])
    # warning-ignore:return_value_discarded
    $HUD/PauseMenu/LoadDefaultSceneButton.connect("pressed",$HUD/PauseMenu,"toggle_pause")
    # warning-ignore:return_value_discarded 
    $HUD/PauseMenu/QuickSaveButton.connect("pressed",$HUD/PauseMenu,"toggle_pause")
    # warning-ignore:return_value_discarded 
    $HUD/PauseMenu/QuickLoadButton.connect("pressed",$HUD/PauseMenu,"toggle_pause")

func load_scenario(_scenario):
    scenario_loaded = false
    if is_network_master():
        if scenario != null:
            scenario.queue_free()
    scenario = _scenario
    add_child(scenario) 
    scenario_loaded = true

master func synchronize_motion():
    for child in scenario.get_children():
        if "translation" in child:
            child.rset("translation",child.translation)
        if "direction" in child: 
            child.rset("direction", child.direction)
        if "solar_mass" in child: 
            child.rset("solar_mass", child.solar_mass)

func save_game(save_path):
    var save_file = File.new()
    save_file.open(save_path, File.WRITE)
    var save_dict = {}
    var nodes_to_save = get_tree().get_nodes_in_group("Persist")
    for node in nodes_to_save:
        save_dict[node.get_path()] = node.get_state()
    save_file.store_line(to_json(save_dict))
    save_file.close()                 

func load_game(load_path):
    var save_file = File.new()
    if not save_file.file_exists(load_path):
        print("The save file does not exist.")
        return
    save_file.open(load_path, File.READ)
    var data = parse_json(save_file.get_as_text())
    var _scenario = Scenario.instance()
    for node_path in data.keys():
        var node_data = data[node_path]
        var node = load(node_data["filename"]).instance()
        print(node_data["filename"])
        node.set_state(node_data)
        _scenario.add_child(node)
    load_scenario(_scenario)
