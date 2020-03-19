
extends Spatial
var Satellites = []

func _ready():
    var amount = 20
    var Satellite = load("res://AstronomicalObjects/Satellites/Satellite.tscn") 
    for i in range(amount): 
        print(i)
        Satellites.append(Satellite.instance())
        add_child(Satellites[i])
        #rotate_around(Satellites[i],Vector3(0,3,0),Vector3(1.5,0.5,1).normalized(),i * PI /10)
        Satellites[i].translation.y += 3
        print(2 * PI * i / amount)


func _process(delta):
    for i in range(Satellites.size()):
        rotate_around(Satellites[i],Vector3(0,0,0),Vector3(1.5,0.5,1).normalized(),i * PI * delta / 1000)
                
#    $Camera.environment.background_sky_rotation += delta
    pass

func rotate_around(obj,point, axis, angle):
    var trans = obj.transform # Get transform
    var rotated_basis = trans.basis.rotated(axis, angle)    # Rotate its basis
    var rotated_origin = point + (trans.origin - point).rotated(axis, angle)# Rotate its origin
    obj.transform = Transform(rotated_basis, rotated_origin)# Set the result back
    #Note: if you want it to work in global space regardless of parenting, use global_transform instead of transform.
