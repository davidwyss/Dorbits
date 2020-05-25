extends Node2D

func set_satellite(_satellite):
    $EnergyBar.satellite = _satellite
    $MaterialPie.set_satellite(_satellite)
    $GC.satellite = _satellite
