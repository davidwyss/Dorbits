tool
extends MeshInstance

var solar_panels = []
var panel_expansion_progress = 0
var panel_rotation_progress = 0
export(float) var amount = 5
export(float) var expansion_speed = 4


func _ready():
    var solar_panel = load("res://AstronomicalObjects/Satellites/Subsystem/SolarPanelExtension.tscn") 
    for i in range(amount): 
        solar_panels.append(solar_panel.instance())
        add_child(solar_panels[i])
        #rotate_around(Satellites[i],Vector3(0,3,0),Vector3(1.5,0.5,1).normalized(),i * PI /10)
        solar_panels[i].scale.y *= 1 + 2*i/amount
        solar_panels[i].scale.x *= 1 + 2*i/amount
        
        
    
    
func module_activation_animation(delta,expand):
    var velocity = 1 if expand else -1
    velocity *= expansion_speed * delta
    for i in range(amount): 
        if panel_expansion_progress <= 1 && panel_expansion_progress >= 0 :
            solar_panels[i].translation.z += (i+1)* solar_panels[i].mesh.size.z * velocity*5
            panel_expansion_progress += velocity
        elif panel_rotation_progress <= 1 && panel_rotation_progress >= 0 :
            solar_panels[i].rotation.z += 8 * velocity
            panel_rotation_progress += velocity
    
func _physics_process(delta):
    module_activation_animation(delta,true)