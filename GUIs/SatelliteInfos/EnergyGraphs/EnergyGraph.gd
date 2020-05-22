extends ColorRect

var x = 0    
var satellite 


func graph_point(energy, max_energy):
    var percent = float(energy)/float(max_energy)
    var point = Vector2(rect_size.x/1.25,rect_size.y*(1-percent))
    $EnergyLine.add_point(point)
    var out_of_bounds = false
    for i in range($EnergyLine.points.size()):
        $EnergyLine.set_point_position(i, $EnergyLine.points[i] - Vector2(2,0))
        if ($EnergyLine.points[i].x < 0):
            out_of_bounds = true
    if out_of_bounds:
        $EnergyLine.remove_point(0)
            
        
func _on_Timer_timeout():
    if satellite!=null:
        $EnergyInfo.set_text("%sWh/%sWh." % [int(satellite.max_energy/1000),int(satellite.energy/1000)])
        graph_point(satellite.energy,satellite.max_energy)
 
        
