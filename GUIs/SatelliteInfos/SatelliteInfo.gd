extends Node2D

func set_satellite(_satellite):
    $SatelliteInfoList/EnergyBar.satellite = _satellite
    $SatelliteInfoList/MaterialPie.set_satellite(_satellite)
    $SatelliteInfoList/GC.satellite = _satellite
