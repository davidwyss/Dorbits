extends Control

export(NodePath) var SatellitePath
var satellite 

func _enter_tree():
    satellite = get_node(SatellitePath)
