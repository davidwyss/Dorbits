extends Spatial

export(PackedScene) var DefaultScenario
export(PackedScene) var ScenarioScene
export(Script) var Player
export(String) var SavePath = "res://save.json"
var players = []
var current_info_view = null
var scenario 

#Camera
var cameras = [] 
onready var current_camera = $Camera


var frames = 0
var scenario_loaded = false

func _ready():
    network_connections()
    camera_connections()
    $Camera.pause_mode = Node.PAUSE_MODE_PROCESS           
    if is_network_master():
        setup_escape_menu()
        load_scenario(DefaultScenario.instance())
        
func _input(_event):
    if Input.is_action_just_pressed("select_next_camera"):
        select_next_camera()       
        
func _process(_delta):
    $Camera/RayCast.collide_with_areas = true
    if frames % 60 == 0 && is_network_master():
        synchronize_motion()
        for sobject in scenario.get_children():
            if "energy" in sobject:
                sobject.rset("energy", sobject.energy)
            if "solar_mass" in sobject: 
                sobject.rpc("set_solar_mass", sobject.solar_mass)
    frames+=1

func _physics_process(_delta):
    if scenario_loaded :
        var children = scenario.get_children()
        var stars = []
        for star in children:
            if "solar_surface_kelvin" in star:
                stars.append(star)
        for sat in children:
            if sat.has_method("receive_solar_energy"):
                for panel in sat.panels:
                    for star in stars:
                        panel.receive_solar_energy(sat.translation.distance_to(star.translation),star.total_solar_luminosity())
    
#Menues
func setup_escape_menu():
    $HUD/EscapeMenu.pause_mode = Node.PAUSE_MODE_PROCESS   
    $HUD/EscapeMenu.visible = false   
    escape_menu_connections($HUD/EscapeMenu) 

#Camera
func on_space_object_selected(space_object):
    if current_camera != $Camera:
        current_camera = $Camera
        current_camera.current = true #free floating
    if current_info_view != null:
        $HUD.remove_child(current_info_view)
        current_info_view = null
    elif space_object != null:
        if space_object.has_method("get_info_panel"):
            current_info_view = space_object.get_info_panel()
            $HUD.add_child(current_info_view)
        if space_object.has_method("get_camera"):
            current_camera = space_object.get_camera()
            current_camera.current = true            


func get_cameras():
    var _cameras = [$Camera]
    for sp in $Scenario.get_children():
        if sp.has_method("get_camera"):
            _cameras.append(sp.get_camera())
    print(_cameras.size())
    return _cameras

func set_cameras():
    cameras = get_cameras()

func select_next_camera():
    set_cameras()
    current_camera = cameras[(cameras.find(current_camera) +1) % cameras.size()]
    current_camera.current = true

#general networking stuff
#func _on_player_disconnected(id): ???
#    get_node(str(id)).queue_free() ???

func _on_server_disconnected():
    # warning-ignore:return_value_discarded 
    get_tree().change_scene('res://GUIs/MainMenus/MainMenu.tscn')

func _on_player_ready(_id,_name):
    var player = Player.new(_id,_name)
    players.append(player)
    if is_network_master():
        send_save_file(_id)
        scenario.spawn_player_rift(player)


master func synchronize_motion():
    for child in scenario.get_children():
        if "translation" in child:
            child.rset("translation",child.translation)
        if "direction" in child: 
            child.rset("direction", child.direction)
            

#save, load and create scenario/game
func load_scenario(_scenario):
    scenario_loaded = false
#    #so all scenarios have the same  path
#    _scenario.name = "Scenario" 
    scenario = _scenario
    add_child(scenario) 
    scenario_loaded = true
    
    
func create_scenario(data):
    var _scenario = ScenarioScene.instance()
    for node_path in data.keys():
        var node_data = data[node_path]
        var node = load(node_data["filename"]).instance()
        node.name = node_data["name"]
        node.set_state(node_data)
        _scenario.add_child(node)
    return(_scenario)


func get_save_json():
    var save_dict = {}
    var nodes_to_save = get_tree().get_nodes_in_group("Persist")
    for node in nodes_to_save:
        save_dict[node.get_path()] = node.get_state()
    return to_json(save_dict)
    
func save_game(save_path):
    var save_file = File.new()
    save_file.open(save_path, File.WRITE)
    save_file.store_line(get_save_json())
    save_file.close()                 
    
func get_save_data(load_path):
    var save_file = File.new()
    if not save_file.file_exists(load_path):
        print("The save file does not exist.")
        return
    save_file.open(load_path, File.READ)
    var data = parse_json(save_file.get_as_text())
    save_file.close()  
    return data  

        
master func load_game(load_path):
    var data = get_save_data(load_path)
    load_scenario(create_scenario(data))
          
puppet func receive_save_json(json):
    var data = parse_json(json)
    load_scenario(create_scenario(data))
    rpc_id(1,"confirm_scene_loaded_json")
    
master func send_save_file(id):
    get_tree().paused = true         
    #TODO MAKE MULTIPLE SIMULATNEOUS CONNECTIONS POSSIBLE AND MAKE THE PROGRAM WAIT
    rpc_id(id,"receive_save_json", get_save_json())

master func confirm_scene_loaded_json():
    get_tree().paused = false 

#connectiions
func camera_connections():
    # warning-ignore:return_value_discarded     
    $Camera.connect('space_object_selected', self, 'on_space_object_selected')
    
func network_connections():
     # warning-ignore:return_value_discarded
    get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
    # warning-ignore:return_value_discarded
    get_tree().connect('server_disconnected', self, '_on_server_disconnected')
    # warning-ignore:return_value_discarded
    Network.connect('player_ready', self,  '_on_player_ready')
    #    var info = Network.self_data

master func escape_menu_connections(escape_menu):
    # warning-ignore:return_value_discarded
    escape_menu.get_node("LoadDefaultSceneButton").connect("pressed",self,"load_scenario",[DefaultScenario.instance()])
    # warning-ignore:return_value_discarded
    escape_menu.get_node("QuickSaveButton").connect("pressed",self,"save_game",[SavePath])
    # warning-ignore:return_value_discarded
    escape_menu.get_node("QuickLoadButton").connect("pressed",self,"load_game",[SavePath])


