extends Control

func set_space_object(spaceObject):
    if spaceObject.has_method("get_camera"):
        var cam = spaceObject.get_camera()
        var viewport = Viewport.new()
        $Sprite.add_child(viewport)
        viewport.add_child(cam)
        viewport.size = Vector2(100,100)
        var viewportTexture = ViewportTexture.new()        
        viewportTexture.set_viewport_path_in_scene(cam.get_path())
        $Sprite.texture = viewportTexture
    $Name.text = spaceObject.name
    
