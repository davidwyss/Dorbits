var name
var chem_name
var amount
var texture_path

func _init(_name=null,_chem_name=null,_amount=null,_texture_path=null):
    if name != null: name = _name
    if chem_name != null: chem_name = _chem_name
    if amount != null: amount = _amount
    if texture_path != null: texture_path = _texture_path

func get_state():
    var save_dict = {
        "name" : name,
        "chem_name" : chem_name,
        "amount" : amount,
        "texture_path" : texture_path,
    }
    return save_dict
    
func set_state(data):
    name = data["name"]
    chem_name = data["chem_name"]
    amount = data["amount"]
    texture_path = data["texture_path"]
