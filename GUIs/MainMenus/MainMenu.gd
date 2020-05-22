extends Node2D

var selected_label_index = 0
var labelcount = 3

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    select_menu_option(0)

func _process(_delta):
        if Input.is_action_just_pressed("ui_down"):
            select_menu_option(selected_label_index + 1 if  selected_label_index + 1 < labelcount else 0)
        if Input.is_action_just_pressed("ui_up"):
            select_menu_option(selected_label_index - 1 if  selected_label_index - 1 >= 0 else labelcount -1)
        if Input.is_action_just_pressed("ui_right") || Input.is_action_pressed("enter"):
            if selected_label_index == 0:
                if $NameEdit.text != "":
                    Network.create_server($NameEdit.text)
                    load_game()
            elif selected_label_index == 1:
                if $NameEdit.text != "":
                    Network.connect_to_server($NameEdit.text)
                    load_game()
            elif selected_label_index == 2:    
                # warning-ignore:return_value_discarded
                get_tree().change_scene("res://GUIs/Settings/Settings.tscn")
            

func select_menu_option(index):
    $LeftContainer/MenuOptions.get_child(selected_label_index).add_color_override("font_color", Color(1,1,1))
    selected_label_index = index
    $LeftContainer/MenuOptions.get_child(selected_label_index).add_color_override("font_color", Color(0,1,1))

#
#func _on_PlayerNameInput_text_changed(new_text):
#    player_name = new_text

func load_game():
    # warning-ignore:return_value_discarded
    get_tree().change_scene('res://Main.tscn')
