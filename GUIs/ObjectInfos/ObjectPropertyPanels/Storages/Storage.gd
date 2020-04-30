tool
extends Node2D

var storage = []
var shards = load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/StorageMaterialShard.tscn")
var materials = [load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/1.png")
                ,load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/2.png")
                ,load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/3.png")
                ,load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/4.png")
                ,load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/5.png")
                ,load("res://GUIs/ObjectInfos/ObjectPropertyPanels/Storages/6.png")]

func _ready():
    var amount = materials.size()
    for i in amount:
        var shard = shards.instance()
        shard.set_material(materials[i])
        shard.angle_start = PI/4 * i
        shard.angle_end = PI/4 * (i+1)
        storage.append(shard)
        add_child(shard)
