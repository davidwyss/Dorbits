extends Area

var G = 6.67*pow(10,-11)
export(Vector3) puppet var direction = Vector3(0,0 ,0)
export var active = true
export(float) var solar_mass = 1 setget set_solar_mass
#var solar_mass_to_kg = 20000000 #2×10³⁰ would be more realistic, 
var solar_mass_to_kg = 1.989 * pow(10,30)
var lightyears_to_meter = 9.461 * pow(10,16)
#for now I prefer to substitute my own reality

func _enter_tree():
    active = true

func _ready():
    $TrackballCamera.pause_mode = Node.PAUSE_MODE_PROCESS   
    add_to_group("Persist")    
    rset_config("translation", get_tree().multiplayer.RPC_MODE_PUPPET)
    active = true

remotesync func set_solar_mass(value):
    solar_mass = value
    scale = Vector3(value,value,value) * 10

func get_pulled_towards_object(object, delta):
    if "solar_mass" in object and "translation" in object:
        var ly_distance_to_object = translation.distance_to(object.translation)
        if object.solar_mass>0 and ly_distance_to_object>0:
            var gravitationalPull = sqrt(G*((object.solar_mass*solar_mass_to_kg)/
                                            (ly_distance_to_object * lightyears_to_meter)))
            var gravityDirection = (object.translation-translation).normalized()
            direction+=gravityDirection*gravitationalPull
            translation += direction*delta
                    
    for obj in object.get_children():
        get_pulled_towards_object(obj, delta)

func _physics_process(delta):
    if active:
        get_pulled_towards_object(get_parent(), delta)
        
func _on_AstroObj_area_entered(area):
    inelastic_collision(area)
    
        
func inelastic_collision(area):
    if solar_mass < area.solar_mass:
        var combined_mass = solar_mass + area.solar_mass
        #m1*v1 + m2*v2 = (m1 + m2) * v
        var final_velocity = (direction * solar_mass + area.direction * area.solar_mass) / combined_mass
        area.solar_mass = combined_mass
        area.direction = final_velocity
        self.queue_free()
        
func get_state():
    var save_dict = {
        "name" : name,
        "filename" : filename,
        "direction" : [direction.x,direction.y,direction.z],
        "translation" : [translation.x,translation.y,translation.z],
        "solar_mass" : solar_mass}
    return save_dict
    
func set_state(data):
    var d = data["direction"]
    var t = data["translation"]
    direction = Vector3(d[0],d[1],d[2])
    translation = Vector3(t[0],t[1],t[2])
    set_solar_mass(data["solar_mass"])

func get_camera():
    return $TrackballCamera
