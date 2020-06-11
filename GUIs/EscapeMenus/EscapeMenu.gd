extends VBoxContainer

func _input(_event):
    if Input.is_action_just_pressed("escape_menu"):
        toggle_pause_menu()
    
func _ready():
    if is_network_master():
        # warning-ignore:return_value_discarded
        $LoadDefaultSceneButton.connect("pressed",self,"toggle_pause_menu")
        # warning-ignore:return_value_discarded 
        $QuickSaveButton.connect("pressed",self,"toggle_pause_menu")
        # warning-ignore:return_value_discarded 
        $QuickLoadButton.connect("pressed",self,"toggle_pause_menu")
    

func toggle_pause_menu():
    if get_tree().is_paused() == visible:
        get_tree().set_pause(!get_tree().is_paused())
    visible = !visible
    if visible:
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    else:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
