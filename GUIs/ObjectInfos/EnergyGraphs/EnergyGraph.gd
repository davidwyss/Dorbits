extends ColorRect

var x = 0    
var satellite 

func graph_point(energy, max_energy):
    var percent = energy/max_energy
    var point = Vector2(rect_size.x/1.25,rect_size.y*(1-percent))
    $EnergyLine.add_point(point)
    var out_of_bounds = false
    for i in range($EnergyLine.points.size()):
        $EnergyLine.set_point_position(i, $EnergyLine.points[i] - Vector2(2,0))
        if ($EnergyLine.points[i].x < rect_position.x):
            out_of_bounds = true
    if out_of_bounds:
        $EnergyLine.remove_point(0)
            
        
func _on_Timer_timeout():
    if satellite!=null:
        $EnergyLine/EnergyInfo.set_text("%skWh/%skWh." % [satellite.max_energy,int(satellite.energy)])
        graph_point(satellite.energy,satellite.max_energy)
 
        
