extends "res://AstronomicalObjects/AstronomicalObject.gd"

export(float) var mass = 1
var gravitational_constant = 0.0000000000667408

func get_grav_force_magnitude(pos,satellite):
        return gravitational_constant * satellite.mass * mass / sqrt(translation.distance_to(satellite.translation))#Applying Newton's Law of Gravitation