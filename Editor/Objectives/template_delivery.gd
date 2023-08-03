extends BoxContainer

@onready var option_item = $HBoxContainer2/OptionItem
@onready var option_npc = $HBoxContainer/OptionNPC

# Called when the node enters the scene tree for the first time.
func _ready():
	update_option_button(option_item, DataManager.item_list)
	update_option_button(option_npc, DataManager.npc_list)
	
func update_option_button(button: OptionButton, list: Dictionary):
	button.clear()
	for item in list:
		button.add_item(list[item].name, item)

func get_data() -> Dictionary:
	var data: Dictionary = {}
	data["item_id"] = option_item.get_selected_id()
	data["npc_id"] = option_npc.get_selected_id()
	return data

func set_data(data: Dictionary):
	option_item.select(option_item.get_item_index(data["item_id"]))
	option_npc.select(option_npc.get_item_index(data["npc_id"]))
