tool
extends "res://AstronomicalObjects/AstronomicalObject.gd"

var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
func _process(delta):
    rotate_object_local(Vector3(0, 1, 0), PI * delta * speed / 60)
