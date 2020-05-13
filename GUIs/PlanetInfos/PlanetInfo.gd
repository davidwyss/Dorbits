extends Node2D

var planet


func set_planet(_planet):
    planet = _planet
    var nameProp = Label.new()
    nameProp.text = "Name: %s" % planet.name
    $PlanetInfoList.add_child(nameProp)
