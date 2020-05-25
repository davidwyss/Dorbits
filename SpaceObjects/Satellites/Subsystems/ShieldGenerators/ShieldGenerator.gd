extends Spatial

func _ready():
    $Wing/Bubble.translation.z -= $Wing/Bubble.mesh.radius
