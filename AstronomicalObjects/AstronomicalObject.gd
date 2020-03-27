extends RigidBody

var gravitational_constant = 0.0000000000667408

func _ready():
    pass
    
func get_grav_force_magnitude(pos,satellite):
        return gravitational_constant * satellite.mass * mass / sqrt(translation.distance_to(satellite.translation))#Applying Newton's Law of Gravitation
