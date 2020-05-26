extends Spatial


export(PackedScene) var Scenario
export(PackedScene) var PlayerScene
var players

var current_info_view = null
var frames = 0

func _process(_delta):
    $Camera/RayCast.collide_with_areas = true
    if frames % 60 == 0 :        
        synchronize_motion()
        for sobject in $Scenario.get_children():
            if "energy" in sobject:
                sobject.rset("energy", sobject.energy)

        
    if Input.is_action_just_pressed("select_celestial_object"):
        var collider = $Camera/RayCast.get_collider()
        if current_info_view != null:
            $HUD.remove_child(current_info_view)
            current_info_view = null
        if collider != null && collider.has_method("get_info_panel"):
            current_info_view = collider.get_info_panel()
            $HUD.add_child(current_info_view)
    frames+=1

func _ready():    
    # warning-ignore:return_value_discarded
    get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
    # warning-ignore:return_value_discarded
    get_tree().connect('network_peer_connected', self, '_on_player_connected')
    # warning-ignore:return_value_discarded
    get_tree().connect('server_disconnected', self, '_on_server_disconnected')
    var new_player = Node.new()
    new_player.name = str(get_tree().get_network_unique_id())
    new_player.set_network_master(get_tree().get_network_unique_id())
    add_child(new_player)
    # var info = Network.self_data
    load_scenario(Scenario.instance())

func _physics_process(_delta):
    for star in $Scenario.get_children():
        if "solar_surface_kelvin" in star:
            for sat in $Scenario.get_children():
                if sat.has_method("receive_solar_energy"):
                    for panel in sat.panels:
                        panel.receive_solar_energy(sat.translation.distance_to(star.translation),star.total_solar_luminosity())

func _on_player_connected(player_id):
    var player = PlayerScene.instance()
    $Scenario.spawn_player_rift(player)
    $HUD.add_child(player)
    
func _on_player_disconnected(id):
    get_node(str(id)).queue_free()

func _on_server_disconnected():
    # warning-ignore:return_value_discarded 
    get_tree().change_scene('res://GUIs/MainMenus/MainMenu.tscn')
    
func load_scenario(scenario):
    $Scenario.replace_by(scenario)
    
master func synchronize_motion():
    for child in $Scenario.get_children():
        if "translation" in child:
            child.rset("translation",child.translation)
        if "direction" in child: 
            child.rset("direction", child.direction)
        if "solar_mass" in child: 
            child.rset("solar_mass", child.solar_mass)
