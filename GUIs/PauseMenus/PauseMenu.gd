extends VBoxContainer

func _input(_event):
    if Input.is_action_just_pressed("pause"):
        toggle_pause()
        
func toggle_pause():
    visible = !visible
    if visible:
        get_tree().paused = true
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    else:
        get_tree().paused = false 
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
