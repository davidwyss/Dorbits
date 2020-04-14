tool
extends "res://AstronomicalObjects/AstronomicalObject.gd"

var subsys = load('res://AstronomicalObjects/Satellites/Subsystems/SolarPanels/SolarPanel.tscn')

var subsystems = []

func _ready():
    spawn_subsystem(20)

func spawn_subsystem(amount):
    var count = amount

    while(amount > 0):
        var rotation =  float(amount) / count * 2.0 * PI
        subsystems.append(subsys.instance())
        add_child(subsystems[-1])
        subsystems[-1].translation.z += 3
        subsystems[-1].translation.y += 1
        rotateAround(subsystems[-1],Vector3(0,0,0),Vector3(0,1,0),rotation)
        amount -= 1
        
func rotateAround(obj, point, axis, angle):
    var rot = angle + obj.rotation.y 
    var tStart = point
    obj.global_translate (-tStart)
    obj.transform = obj.transform.rotated(axis, -rot)
    obj.global_translate (tStart)
