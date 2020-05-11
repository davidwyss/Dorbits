extends "res://AstronomicalObjects/AstronomicalObject.gd"
#Subsystems
var subsystems = []
export(PackedScene) var panel
export(PackedScene) var laser
export(PackedScene) var sensor
export(PackedScene) var telemetry

#Storage
var total_storage_space = 1000
var material = load("res://AstronomicalObjects/Satellites/Materials/Material.gd")
var materials = [] 
var materialDB = load("res://AstronomicalObjects/Satellites/Materials/MaterialDB.gd")
signal material_array_changed

#Energy
var max_energy = 200
var energy = 20

#TODO DELETE
var TEMP = 1

func _process(delta):
    energy = sin(TEMP)*max_energy/5 + max_energy/2
    TEMP += .1

func _ready():
    spawn_subsystem(10)
        
func test_materials():
    for m in materialDB.new().materials:
        m.amount = 10
        add_material(m)
    
#Subsystems
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
    
#Materials
func add_material(material_added):
    var alreadyExists = false
    for m in materials:
        if material_added.name == m.name:      
            m.amount += material_added.amount
            print(String(m.name) + String(m.amount))  
            alreadyExists = true
    if !alreadyExists:
        materials.append(material_added)
        emit_signal("material_array_changed")
    
func remove_material(material_removed):
     for m in materials:
        if material_removed.name == m.name:
            m.amount -= material_removed.amount
            if 0 >= m.amount:
                materials.erase(m)
                emit_signal("material_array_changed")
