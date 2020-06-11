extends HBoxContainer
export(PackedScene) var SpaceObjectItemScene

func set_space_objects(scene):
    for spaceObject in scene.get_children():
        var spi = SpaceObjectItemScene.instance()        
        spi.set_space_object(spaceObject)
        add_child(spi)
    
