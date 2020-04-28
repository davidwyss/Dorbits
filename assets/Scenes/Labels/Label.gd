tool
extends Label

func _on_Label_resized(): 
    $FontShader.rect_size = rect_size
    $FontShader.rect_position = rect_position
