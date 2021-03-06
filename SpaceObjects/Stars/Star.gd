extends "res://SpaceObjects/SpaceObject.gd"
export(PackedScene) var StarInfos

var solar_surface_kelvin = 5700
var solar_radius = 696342000
const stefan_boltzmann_constant = 0.00000005670374419#σ = 5.670374419...×10−8 W⋅m−2⋅K−4.


func _process(delta):
    rotate_object_local(Vector3(0, 1, 0), PI * delta / 60)

func total_solar_luminosity():
    return stefan_boltzmann_constant * pow(solar_surface_kelvin,4) * 4 * PI * pow(solar_radius,2)

func get_info_panel():
    var p = StarInfos.instance()
    p.set_star(self)
    return p 
    
func get_state():
    var save_dict = {
        "solar_surface_kelvin" : solar_surface_kelvin,
        "solar_radius" : solar_radius
    }
    var super = .get_state()
    for key in super:
        save_dict[key] = super[key]
    return save_dict

func set_state(data):
    .set_state(data)
    solar_radius = data["solar_radius"]
    solar_surface_kelvin = data["solar_surface_kelvin"]
    
