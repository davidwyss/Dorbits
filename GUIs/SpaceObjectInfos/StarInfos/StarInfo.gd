extends Node2D

var star

func set_star(_star):
    star = _star
    for prop in ["Name: %s" % star.name,
                "Surface Kelvin: %s" %  star.solar_surface_kelvin,
                "Radius: %s" % star.solar_radius,
                "Solar Mass %s" % star.solar_mass]:
        var nameProp = Label.new()
        nameProp.text = prop
        $StarInfoList.add_child(nameProp)
