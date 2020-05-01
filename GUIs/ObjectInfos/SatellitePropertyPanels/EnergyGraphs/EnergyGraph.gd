extends Line2D

var p = Vector2(0,0)
var energy = 11
var max_energy = 1000
var size 

func _ready():
    size = get_node("../").rect_size
    
func graph_point(point):
    point.y = size.y-point.y
    add_point(point)

func _on_Timer_timeout():
    p.x+=1
    energy+=1
    p.y = energy*size.y/max_energy
    $EnergyInfo.set_text("%skWh/%skWh." % [max_energy,energy]);
    graph_point(p)
