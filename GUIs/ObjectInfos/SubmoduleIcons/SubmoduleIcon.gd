tool
extends Sprite

func _ready():
    var size = texture.get_size()
    $HPSprite.rect_size = size
    $HPSprite.rect_position = -size/2
