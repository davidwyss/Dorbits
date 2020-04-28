tool
extends "res://AstronomicalObjects/AstronomicalObject.gd"

#Subsystems
var subsystems = []
var panel = load('res://AstronomicalObjects/Satellites/Subsystems/SolarPanels/SolarPanel.tscn')
var laser = load('res://AstronomicalObjects/Satellites/Subsystems/Lasers/Laser.tscn')
var sensor = load('res://AstronomicalObjects/Satellites/Subsystems/SensorArrays/SensorArray.tscn')
var telemetry = load('res://AstronomicalObjects/Satellites/Subsystems/Telemetry/Telemetry.tscn')

#Energy
var energy_history = []
var energy = 10

func _ready():
    spawn_subsystem(10)

func spawn_subsystem(amount):
    var count = amount

    while(amount > 0):
        var rotation =  float(amount) / count * 2.0 * PI
        if amount%5 == 0 || amount%5 == 3:
            subsystems.append(panel.instance())
        elif amount%5 == 1:
            subsystems.append(sensor.instance())
        elif amount%5 == 2:
            subsystems.append(telemetry.instance())
        else:
            subsystems.append(laser.instance())

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

