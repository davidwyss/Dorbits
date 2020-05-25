extends Spatial

func _ready():
    pass # Replace with function body.

func _process(delta):
    rotate_around(self,Vector3(0,0,0),Vector3(0,1,0),delta)
    
func rotate_around(obj, point, axis, angle):
    var rot = angle + obj.rotation.y 
    var tStart = point
    obj.global_translate (-tStart)
    obj.transform = obj.transform.rotated(axis, -rot)
    obj.global_translate (tStart)
