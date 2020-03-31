tool
extends "res://AstronomicalObjects/AstronomicalObject.gd"

    
func _process(delta):
    rotate_object_local(Vector3(0, 1, 0), PI * delta / 60)

