tool
extends Spatial

export(float) var speed = 100

func _process(_delta):
    $Array.rotate_x(speed/100)
