var materials = []
var material = load("res://AstronomicalObjects/Satellites/Materials/Material.gd")

    
func _init():
    materials.append(material.new("Aluminium","Al",1,"res://assets/Textures/Materials/1.png"))
    materials.append(material.new("Argon","Ar",2,"res://assets/Textures/Materials/2.png"))
    materials.append(material.new("Uran","Ur",3,"res://assets/Textures/Materials/3.png"))
    materials.append(material.new("Osmium","Os",4,"res://assets/Textures/Materials/4.png"))
    materials.append(material.new("Oxygen","O",5,"res://assets/Textures/Materials/5.png"))
    materials.append(material.new("Hydrogen","W",6,"res://assets/Textures/Materials/6.png"))
