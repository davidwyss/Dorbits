tool
extends Spatial

export(float) var speed = 100

func _process(delta):
    $Array.rotate_x(speed/100)
