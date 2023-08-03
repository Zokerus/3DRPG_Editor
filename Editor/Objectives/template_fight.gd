extends BoxContainer

@onready var target = $HBoxContainer/Target
@onready var target_type = $HBoxContainer2/TargetType

var kill : bool = false

func _ready():
	update_option_target(DataManager.npc_list)

func _on_option_button_item_selected(index):
	if index == 0:
		update_option_target(DataManager.npc_list)
		pass
	else:
		update_option_target(DataManager.monster_list)
		pass

func update_option_target(list: Dictionary):
	target.clear()
	for item in list:
		target.add_item(list[item].name, item)

func get_data() -> Dictionary:
	var data: Dictionary = {}
	data["target_type"] = target_type.get_item_text(target_type.selected)
	data["id"] = target.get_selected_id()
	data["kill"] = kill
	return data

func set_data(data: Dictionary):
	if data["target_type"] == "NPC":
		target_type.select(0)
		target_type.item_selected.emit(0)
	else :
		target_type.select(1)
		target_type.item_selected.emit(1)
	target.select(target.get_item_index(data["id"]))
	kill = data["kill"]
