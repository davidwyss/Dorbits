extends Spatial

export(PackedScene) var PlanetInfos

func get_info_panel():
    var p = PlanetInfos.instance()
    p.set_planet(self)
    return p 
