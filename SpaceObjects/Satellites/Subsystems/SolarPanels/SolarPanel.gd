extends Spatial

var solar_panel_extensions = []
export(float) var amount = 5
export(float) var solar_cell_efficiency = 0.333333
const ASTRONOMICAL_UNIT = 149597900000.0

signal energy_received(amount)

func _ready():
    var panel_extension = load("res://SpaceObjects/Satellites/Subsystems/SolarPanels/SolarPanelExtension.tscn") 
    for i in range(amount): 
        var panel_extension_instance = panel_extension.instance()
        solar_panel_extensions.append(panel_extension_instance)
        solar_panel_extensions[i].scale.x *= 0.25 + 1.5*i/amount
        solar_panel_extensions[i].scale.y *= 0.75*(1 + i/amount)
        add_child(panel_extension_instance)
    animation()
    
func solar_panel_area():
    return 4

func receive_solar_energy(solar_distance, total_solar_luminosity):
    if solar_panel_extensions.size() != 0:
        if  solar_panel_extensions.back().rotation.z > 0: # check if fully expanded
            var solar_sphere = pow(solar_distance * ASTRONOMICAL_UNIT,2) * 4 * PI
            var e = total_solar_luminosity * solar_panel_area() * solar_cell_efficiency / solar_sphere
            emit_signal("energy_received", e)


func animation():
    var ring_level = 0
    var animation_length= 10
    var delay_unit = animation_length / amount
    var expand = Animation.new()
    expand.set_length(animation_length+4* delay_unit)
    for panel in solar_panel_extensions:
        var track_idx = ring_level * 2
        var expansion_start = (panel.mesh.size.z + $WingCase.mesh.size.z)/2
        var expansion = expansion_start + ring_level * panel.mesh.size.z
        var delay = delay_unit * ring_level
        # The animation is to move the sprite to the right for 1 second
        expand.add_track(Animation.TYPE_VALUE)
        expand.track_set_path(track_idx, "../" + panel.name + ":translation")
        expand.track_insert_key(track_idx, 0, Vector3(0,0,0))
        expand.track_insert_key(track_idx, delay + delay_unit, Vector3(0, 0,expansion))
        track_idx += 1
        expand.add_track(Animation.TYPE_VALUE)
        expand.track_set_path(track_idx, "../" + panel.name + ":rotation_degrees")
        expand.track_insert_key(track_idx,delay + 2*delay_unit, Vector3(0,0,0))
        expand.track_insert_key(track_idx, delay + 4*delay_unit, Vector3(0,0,90))
        track_idx += 1
        ring_level += 1
    $WingCase/AnimationPlayer.add_animation("Expand", expand)
    $WingCase/AnimationPlayer.play("Expand")
