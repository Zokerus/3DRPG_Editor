extends BoxContainer

@onready var target = $HBoxContainer/Target

signal press_edit_dialogue(node)

func _ready():
	target.clear()
	for location in DataManager.location_list:
		target.add_item(DataManager.location_list[location].name, location)

func _on_npc_trigger_press_edit_dialogue(node):
	press_edit_dialogue.emit(node)
