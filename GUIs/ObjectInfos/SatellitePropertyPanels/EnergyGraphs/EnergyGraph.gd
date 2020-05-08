extends ColorRect

var x = 0    
onready var satellite = get_parent().satellite

func graph_point(point):
    point.y = rect_size.y-point.y
    $EnergyLine.add_point(point)

func _on_Timer_timeout():
    if satellite!=null:
        $EnergyLine/EnergyInfo.set_text("%skWh/%skWh." % [satellite.max_energy,int(satellite.energy)])
        graph_point(Vector2(x,float(satellite.energy)))
        x+=1
