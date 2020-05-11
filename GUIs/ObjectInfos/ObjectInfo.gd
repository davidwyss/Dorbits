extends Node2D
export(NodePath) var satellitePath

func _enter_tree():
    $SatelliteInfoList/EnergyBar.satellite = get_node(satellitePath)
    $SatelliteInfoList/MaterialPie.satellite = get_node(satellitePath)
    $SatelliteInfoList/GC.satellite = get_node(satellitePath)
