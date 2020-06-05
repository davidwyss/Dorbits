extends "res://SpaceObjects/SpaceObject.gd"
#Subsystems are connected through cabels and can be detached. 

#Subsystems
export(PackedScene) var SatelliteInfos
export(PackedScene) var PanelScene
export(PackedScene) var LaserScene
export(PackedScene) var SensorScene
export(PackedScene) var TelemetryScene
export(PackedScene) var ThrusterScene
export(PackedScene) var ShieldScene

var panels = []
var lasers = []
var sensors = []
var telemetry = []
var thrusters = []
var shields = []


#Storage
var total_storage_space = 1000
var material = load("res://SpaceObjects/Satellites/Materials/Material.gd")
var materials = [] 
var materialDB = load("res://SpaceObjects/Satellites/Materials/MaterialDB.gd")
signal material_array_changed

#Energy
var max_energy = 50000
puppet var energy = 12000 setget set_energy

func set_energy(_energy):
    energy = max(min(_energy,max_energy),0)

func _ready():
    spawn_subsystems()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    test_materials()
    
func _process(_delta):
    set_energy(energy - 5)
        
func test_materials():
    for m in materialDB.new().materials:
        m.amount = 10
        add_material(m)
    
#Subsystems
func spawn_subsystems():
        panels.append(PanelScene.instance())
        sensors.append(SensorScene.instance())
        telemetry.append(TelemetryScene.instance())
        shields.append(ShieldScene.instance())
        lasers.append(LaserScene.instance())
        thrusters.append(ThrusterScene.instance())
        var subsystems = get_subsystems() 
        for i in range(subsystems.size()):
            add_child(subsystems[i])
            var rotation =  float(i) / float(subsystems.size()) * 2.0 * PI
            subsystems[i].translation.z += 3
            subsystems[i].translation.y += 1
            rotateAround(subsystems[i],Vector3(0,0,0),Vector3(0,1,0),rotation)
        for panel in panels: 
            panel.connect("energy_received", self, "receive_solar_energy")
        
        
func get_subsystems():
    return panels + sensors + shields + thrusters + lasers + telemetry 

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
    set_energy(_energy + energy)
    
func get_info_panel():
    var p = SatelliteInfos.instance()
    p.set_satellite(self)
    return p 
    
func get_state():
    var save_dict = {
        "energy" : energy,
    }
    save_dict["materials"] = []
    for material in materials:
         save_dict["materials"].append(material.get_state())
    #Combine function
    var super = .get_state()
    for key in super:
        save_dict[key] = super[key]
    return save_dict

func set_state(data):
    .set_state(data)
    energy = data["energy"]
    for material_state in data["materials"]:
        var new_material = material.new()
        new_material.set_state(material_state)
