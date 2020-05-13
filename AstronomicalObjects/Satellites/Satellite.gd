extends "res://AstronomicalObjects/AstronomicalObject.gd"

#Subsystems are connected through cabels and can be detached. 

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
var max_energy = 200000
var energy = 120000

func _ready():
    spawn_subsystem(10)
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    
func _process(delta):
    energy -= 20
        
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
            var p =  panel.instance()
            p.connect("energy_received", self, "receive_solar_energy")
            subsystems.append(p)
#            print(subsystems.back().amount)
            print(p.amount)
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

func receive_solar_energy(_energy):
    energy +=_energy
    
