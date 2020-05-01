tool
extends Control

export(Array, Texture) var materials 
export(PackedScene) var shards

var storage = []

func _ready():
    var amount = materials.size()
    for i in amount:
        var shard = shards.instance()
        shard.set_material(materials[i])
        shard.angle_start = PI/4 * i
        shard.angle_end = PI/4 * (i+1)
        shard.radius = min(rect_size.x,rect_size.y)/2
        shard.center = rect_size / 2 
        storage.append(shard)
        add_child(shard)
