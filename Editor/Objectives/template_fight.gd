extends BoxContainer

@onready var target = $HBoxContainer/Target

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
