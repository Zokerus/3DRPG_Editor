extends BoxContainer

@onready var option_item = $HBoxContainer2/OptionItem
@onready var option_npc = $HBoxContainer/OptionNPC

# Called when the node enters the scene tree for the first time.
func _ready():
	update_option_button(option_item, DataManager.quest_item_list)
	update_option_button(option_npc, DataManager.npc_list)
	
func update_option_button(button: OptionButton, list: Dictionary):
	button.clear()
	for item in list:
		button.add_item(list[item].name, item)
