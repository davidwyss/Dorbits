extends Node2D

func _process(_delta):
        if Input.is_action_just_pressed("move_left"):
            get_tree().change_scene("res://GUIs/MainMenus/MainMenu.tscn")
                  
