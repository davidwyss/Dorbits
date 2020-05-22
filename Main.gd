extends Spatial

export(PackedScene) var SatelliteInfos
export(PackedScene) var PlanetInfos
export(PackedScene) var StarInfos

var current_info_view = null

func _physics_process(_delta):
    for star in [$AstronomicalObjects/Star]:
        for sat in [$AstronomicalObjects/Satellite]:
            for panel in sat.panels:
                panel.receive_solar_energy(sat.translation.distance_to(star.translation),star.total_solar_luminosity())

func _process(_delta):
    if Input.is_action_just_pressed("select_celestial_object"):
        var collider = $Camera/RayCast.get_collider()
        if collider != null:
            var info
            if current_info_view != null:
                $CanvasLayer.remove_child(current_info_view)
            if collider == $AstronomicalObjects/Satellite:
                info = SatelliteInfos.instance()
                info.set_satellite($AstronomicalObjects/Satellite)
            elif collider == $AstronomicalObjects/Star:
                info = StarInfos.instance()
                info.set_star($AstronomicalObjects/Star)
            elif collider == $AstronomicalObjects/Planet:
                info = PlanetInfos.instance()
                info.set_planet($AstronomicalObjects/Planet)
            $CanvasLayer.add_child(info)
            current_info_view = info
            
            

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

func _on_player_disconnected(id):
    get_node(str(id)).queue_free()

func _on_server_disconnected():
# warning-ignore:return_value_discarded
    get_tree().change_scene('res://GUIs/MainMenus/MainMenu.tscn')
