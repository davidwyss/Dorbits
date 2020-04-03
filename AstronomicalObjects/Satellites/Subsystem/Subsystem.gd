tool
extends MeshInstance

var solar_panels = []
export(float) var amount = 5

#TODO make panels triangular
func _ready():
    var solar_panel = load("res://AstronomicalObjects/Satellites/Subsystem/SolarPanelExtension.tscn") 
    for i in range(amount): 
        var panel = solar_panel.instance()
        solar_panels.append(panel)
        solar_panels[i].scale.x *= 0.25 + 1.5*i/amount
        solar_panels[i].scale.y *= 0.75*(1 + i/amount)
        add_child(panel)
    animation()

func animation():
    var ring_level = 0
    var animation_length= 10
    var delay_unit = animation_length / amount
    var expand = Animation.new()
    expand.set_length(animation_length+4* delay_unit)
    for panel in solar_panels:
        var track_idx = ring_level * 2
        var expansion_start = (panel.mesh.size.z + self.mesh.size.z)/2
        var expansion = expansion_start + ring_level * panel.mesh.size.z
        var delay = delay_unit * ring_level
        # The animation is to move the sprite to the right for 1 second
        expand.add_track(Animation.TYPE_VALUE)
        expand.track_set_path(track_idx, "./" + panel.name + ":translation")
        expand.track_insert_key(track_idx, 0, Vector3(0,0,0))
        expand.track_insert_key(track_idx, delay + delay_unit, Vector3(0, 0,expansion))
        track_idx += 1
        expand.add_track(Animation.TYPE_VALUE)
        expand.track_set_path(track_idx, "./" + panel.name + ":rotation_degrees")
        expand.track_insert_key(track_idx,delay + 2*delay_unit, Vector3(0,0,0))
        expand.track_insert_key(track_idx, delay + 4*delay_unit, Vector3(0,0,90))
        track_idx += 1
        ring_level += 1
    $AnimationPlayer.add_animation("Expand", expand)
    $AnimationPlayer.play("Expand")
