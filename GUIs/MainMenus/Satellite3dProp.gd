tool
extends Sprite

onready var viewport = $Viewport

func _ready():
#    get_viewport().connect("size_changed", self, "_root_viewport_size_changed")
    self.texture = viewport.get_texture()

func _root_viewport_size_changed():
    viewport.size = Vector2.ONE * get_viewport().size.y
