extends VBoxContainer

var selected_label_index = 0
var labelcount = 3

func _ready():
    select_menu_option(0)
    pass

func _process(_delta):
        if Input.is_action_just_pressed("ui_down"):
            select_menu_option(selected_label_index + 1 if  selected_label_index + 1 < labelcount else 0)
        if Input.is_action_just_pressed("ui_up"):
            select_menu_option(selected_label_index - 1 if  selected_label_index - 1 >= 0 else labelcount -1)
        if Input.is_action_just_pressed("ui_right") || Input.is_action_pressed("enter"):
            if selected_label_index == 0:
                # warning-ignore:return_value_discarded
                get_tree().change_scene("res://Main.tscn")
            elif selected_label_index == 1:
                # warning-ignore:return_value_discarded
                get_tree().change_scene("res://GUIs/SatelliteInfos/SatelliteInfo.tscn")
            elif selected_label_index == 2:    
                # warning-ignore:return_value_discarded
                get_tree().change_scene("res://GUIs/other/IWANTTOFREEYOURSKIN.tscn")
            

func select_menu_option(index):
    get_child(selected_label_index).add_color_override("font_color", Color(1,1,1))
    selected_label_index = index
    get_child(selected_label_index).add_color_override("font_color", Color(0,1,1))

