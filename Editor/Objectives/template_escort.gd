extends BoxContainer

@onready var npc_trigger = $"NPC Trigger"
@onready var target = $HBoxContainer/Target

signal press_edit_dialogue(node)

func _ready():
	target.clear()
	for location in DataManager.location_list:
		target.add_item(DataManager.location_list[location].name, location)

func _on_npc_trigger_press_edit_dialogue(node):
	press_edit_dialogue.emit(node)

func get_data()-> Dictionary:
	var data: Dictionary = {}
	data["npc_data"] = npc_trigger.get_data()
	data["target_location_id"] = target.get_selected_id()
	return data

func set_data(data: Dictionary):
	npc_trigger.set_data(data["npc_data"])
	target.select(target.get_item_index(data["target_location_id"]))
