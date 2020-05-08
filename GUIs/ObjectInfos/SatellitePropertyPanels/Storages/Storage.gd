extends Control

export(PackedScene) var shardClass
export(float) var radius_modifier
onready var satellite = get_parent().satellite


func _ready():
    satellite.connect("material_array_changed", self, "set_shards")
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()
    satellite.test_materials()

func set_shards():
    if satellite != null:
        anakin()
        for m in satellite.materials:
            var shard = shardClass.instance() 
            shard.set_material(load(m.texture_path))
            shard.radius = min(rect_size.x,rect_size.y)/2 * radius_modifier
            shard.center = rect_size / 2 
            shard.stored_material = m;
            add_child(shard)
        set_shard_shape()

func anakin():
    #Master Skywalker, there are too many of them! What are we going to do?
    for n in get_children():
        #light saber go brrrrrr
        remove_child(n)
        #dew it
        n.queue_free()
    
func set_shard_shape():    
    var space_left = 0 
    for shard in get_children():
        shard.angle_start = 2 * PI * space_left
        print(shard.stored_material.amount)
        space_left += float(shard.stored_material.amount) / float(satellite.total_storage_space)
        shard.angle_end = 2 * PI * space_left

#Todo signal is better
func _draw():
    set_shard_shape()
