tool
extends Spatial

var telemetry_extensions = []
export(int) var amount = 10

func _ready():
    var extension = load("res://AstronomicalObjects/Satellites/Subsystems/Telemetry/TelemetryExtension.tscn") 
    for _i in range(amount): 
        var extension_instance = extension.instance()
        telemetry_extensions.append(extension_instance)
        add_child(extension_instance)
    animation()

func animation():
    var i = 0
    var animation_length= 2
    var delay_unit = animation_length / amount
    var expand = Animation.new()
    expand.set_length(100)
    for extension in telemetry_extensions:
        var delay = delay_unit * i
        # The animation is to move the sprite to the right for 1 second
        expand.add_track(Animation.TYPE_VALUE)
        expand.track_set_path(i, "./" + extension.name + ":translation")
        expand.track_insert_key(i, 0, Vector3(0,0,0))
#        float y =  $Wing.mesh.size.y * -.5 +  (0.5+i-extension.mesh.bottom_radius*2)*$Wing.mesh.size.y/amount + extension.mesh.bottom_radius
        var whole = $Wing.mesh.size.y
        var starting_point = -$Wing.mesh.size.y/2
        var part = whole/(float(amount)*2)
        var point = part*(2*i)+part
        var y = starting_point + point
        expand.track_insert_key(i, delay + delay_unit, Vector3(0,y,$Wing.mesh.size.y*0.9))
        i += 1
    $AnimationPlayer.add_animation("Expand", expand)
    $AnimationPlayer.play("Expand")
