extends BoxContainer

@onready var target = $HBoxContainer/Target

# Called when the node enters the scene tree for the first time.
func _ready():
	target.clear()
	for location in DataManager.location_list:
		target.add_item(DataManager.location_list[location].name, location)

func get_data()-> Dictionary:
	var data: Dictionary = {}
	data["target_location_id"] = target.get_selected_id()
	return data

func set_data(data: Dictionary):
	target.select(target.get_item_index(data["target_location_id"]))
