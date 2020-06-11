extends Node

func _input(_event):
    if Input.is_action_just_pressed("pause") && is_network_master():
        rpc("pause",!get_tree().is_paused())
        
remotesync func pause(b):
    get_tree().set_pause(b)
