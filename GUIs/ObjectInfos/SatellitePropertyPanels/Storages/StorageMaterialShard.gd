tool
extends Node2D

var center = Vector2(0, 0)
var displacement = Vector2(0,0)
var radius = 100
var angle_start = 0
var angle_end = 1

func _ready():
    displace(10)

func _draw():
    draw_circle_arc_poly(center+displacement, radius, angle_start, angle_end)

func displace(displacement_strength):
    var angle = angle_start + (angle_end-angle_start)/2 + 180
    displacement = Vector2(cos(angle), sin(angle))*displacement_strength;
    
func set_material(tex):
    material = material.duplicate()
    material.set_shader_param("material",tex)
    
func draw_circle_arc_poly(center, radius, angle_from, angle_to):
    var nb_points = 32
    var points_arc = PoolVector2Array()
    points_arc.push_back(center)
    for i in range(nb_points + 1):
        var angle_point = angle_from + i * (angle_to - angle_from) / nb_points - 90
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc,PoolColorArray([Color(1,1,1,1)]))

