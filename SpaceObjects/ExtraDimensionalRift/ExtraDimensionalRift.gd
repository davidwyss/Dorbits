extends Spatial

export(PackedScene) var SatelliteScene

func _input(_event):
    if Input.is_action_just_pressed("create_satellite"):
        spawn_satellite()
    
func spawn_satellite():
    var satellite = SatelliteScene.instance()
    satellite.translation = translation
    satellite.solar_mass = 0.0000001
    get_parent().add_child(satellite)
