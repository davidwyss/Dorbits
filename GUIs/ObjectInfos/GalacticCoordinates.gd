extends Label
var satellite

func _process(delta):
    text = "X=%s\nY=%s\nZ=%s" % [ int(satellite.translation.x),
                                  int(satellite.translation.y),
                                  int(satellite.translation.z),]
