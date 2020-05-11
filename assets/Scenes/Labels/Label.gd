tool
extends Label

func _on_Label_resized(): 
    $FontShader.rect_size = rect_size
    $FontShader.rect_position = rect_position


func _on_Label_item_rect_changed():
    $FontShader.rect_size = rect_size
    $FontShader.rect_position = rect_position
