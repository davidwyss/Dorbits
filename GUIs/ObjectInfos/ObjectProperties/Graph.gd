extends Line2D

var p = Vector2(0,0)
var size 

func _ready():
    size = get_node("../").rect_size
    
func graph_point(point):
    point.y = size.y-point.y
    add_point(point)

func _on_Timer_timeout():
    p.x+=1
    p.y=p.x
    graph_point(p)
