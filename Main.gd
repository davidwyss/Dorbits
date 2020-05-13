extends Spatial

export(PackedScene) var SatelliteInfos
export(PackedScene) var PlanetInfos
export(PackedScene) var StarInfos

var current_info_view = null

func _physics_process(_delta):
    for star in [$AstronomicalObjects/Star]:
        for sat in [$AstronomicalObjects/Satellite]:
            for subsys in sat.subsystems:
                if subsys.get_filename() == sat.panel.get_path():
                    subsys.receive_solar_energy(sat.translation.distance_to(star.translation),star.total_solar_luminosity())

func _process(delta):
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
            
            
            
