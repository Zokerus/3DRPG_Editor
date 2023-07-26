extends BoxContainer

@onready var target = $HBoxContainer/Target

# Called when the node enters the scene tree for the first time.
func _ready():
	target.clear()
	for location in DataManager.location_list:
		target.add_item(DataManager.location_list[location].name, location)
