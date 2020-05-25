extends Spatial


export(PackedScene) var Scenario

var current_info_view = null
var frames = 0

func _process(_delta):
    if frames % 60 == 0 && get_tree().is_network_server():    
        send_motion_synchronization()
        
    if Input.is_action_just_pressed("select_celestial_object"):
        var collider = $Camera/RayCast.get_collider()
        if current_info_view != null:
            $CanvasLayer.remove_child(current_info_view)
            current_info_view = null
        if collider != null && collider.has_method("get_info_panel"):
            current_info_view = collider.get_info_panel()
            $CanvasLayer.add_child(current_info_view)
    frames+=1

func _ready():    
# warning-ignore:return_value_discarded
    get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
# warning-ignore:return_value_discarded
    get_tree().connect('server_disconnected', self, '_on_server_disconnected')
    var new_player = Node.new()
    new_player.name = str(get_tree().get_network_unique_id())
    new_player.set_network_master(get_tree().get_network_unique_id())
    add_child(new_player)
#    var info = Network.self_data
    load_scenario(Scenario.instance())

func _physics_process(_delta):
    for star in $Scenario.get_children():
        if "solar_surface_kelvin" in star:
            for sat in $Scenario.get_children():
                if sat.has_method("receive_solar_energy"):
                    for panel in sat.panels:
                        panel.receive_solar_energy(sat.translation.distance_to(star.translation),star.total_solar_luminosity())

func _on_player_disconnected(id):
    get_node(str(id)).queue_free()

func _on_server_disconnected():
    # warning-ignore:return_value_discarded 
    get_tree().change_scene('res://GUIs/MainMenus/MainMenu.tscn')
    
func load_scenario(scenario):
    $Scenario.replace_by(scenario)
    
master func send_motion_synchronization():
    for child in $Scenario.get_children() + [$Camera]:
        if "transform" in child && "direction" in child && child.has_method("get_path"): 
            rpc("synchronize_motion", child.get_path(), child.transform, child.direction)

puppet func synchronize_motion(_path,_transform,_direction):
    get_node(_path).transform = _transform
    get_node(_path).direction = _direction
