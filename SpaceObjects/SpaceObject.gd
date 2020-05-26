extends Area

var G = 6.67*pow(10,-11)
export(Vector3) puppet var direction = Vector3(0,0 ,0)
export var active = true
export(float) var solar_mass = 1 setget set_solar_mass
var solar_mass_to_kg = 200000 #2×10³⁰ would be more realistic, 
#for now I prefer to substitute my own reality

func _enter_tree():
    active = true

func _ready():
    rset_config("translation", get_tree().multiplayer.RPC_MODE_PUPPET)
    active = true

puppet func set_solar_mass(value):
    solar_mass = value
    scale = Vector3(value,value,value)

func get_pulled_towards_object(object, delta):
    if "solar_mass" in object and "translation" in object:
        var distanceToObject = translation.distance_to(object.translation)
        if object.solar_mass>0 and distanceToObject>0:
            var gravitationalPull = sqrt(G*(object.solar_mass*solar_mass_to_kg/distanceToObject))
            var gravityDirection = (object.translation-translation).normalized()
            direction+=gravityDirection*gravitationalPull
            translation += direction*delta
                    
    for obj in object.get_children():
        get_pulled_towards_object(obj, delta)

func _physics_process(delta):
    if active:
        get_pulled_towards_object(get_parent(), delta)
        



func _on_AstroObj_area_entered(area):
    #inelastic collision
    if solar_mass < area.solar_mass:
        var combined_mass = solar_mass + area.solar_mass
        #m1*v1 + m2*v2 = (m1 + m2) * vf
        var final_velocity = direction * solar_mass + area.direction * area.solar_mass / combined_mass
        area.solar_mass = combined_mass
        area.direction = final_velocity
        self.queue_free()
        
    
