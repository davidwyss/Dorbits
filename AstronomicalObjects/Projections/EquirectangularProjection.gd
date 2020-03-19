tool
extends Viewport

export(ShaderMaterial) var surface_script

func _ready():
    $ColorRect.material.set_script(surface_script)
