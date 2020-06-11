extends Spatial

export(PackedScene) var rift_scene
export (Vector3) var rift_spawn_bounds_box = Vector3(20,20,20)

func spawn_player_rift(player):
    var rift = rift_scene.instance()
    rift.translation = rift_spawn_bounds_box * (-.5 + randf())
    add_child(rift)
    player.rift = rift
