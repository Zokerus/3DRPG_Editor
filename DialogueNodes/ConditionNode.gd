extends GNode

@onready var condition = $BoxContainer/Condition
@onready var addition = $BoxContainer/Addition
@onready var h_box_container = $BoxContainer/HBoxContainer
@onready var compare = $BoxContainer/HBoxContainer/Compare
@onready var spin_box = $BoxContainer/HBoxContainer/SpinBox

func _on_condition_item_selected(index):
	addition.clear()
	match condition.get_item_text(index):
		"Quest":
			addition.show()
			for quest in DataManager.quest_list:
				addition.add_item(DataManager.quest_list[quest].name, quest)
		"Skill":
			addition.show()
		"Knowledge":
			addition.hide() 
		"Introduction":
			addition.hide()
		"Faction":
			addition.show()
		"Level":
			addition.hide()
			h_box_container.show()

func get_data()-> Dictionary:
	var data: Dictionary = super()
	data["condition_type"] = condition.get_item_text(condition.selected)
	match condition.get_item_text(condition.selected):
		"Quest":
			data["quest_id"] = addition.get_selected_id()
		"Level":
			data["value"] = spin_box.value
			data["comparing_sign"] = compare.get_item_text(compare.selected)
	
	
	return data

func set_data(data: Dictionary):
	for index in condition.item_count - 1:
		if condition.get_item_text(index) == data["condition_type"]:
			condition.select(index)
			break
	match data["condition_type"]:
		"Quest":
			addition.select(addition.get_item_index(data["quest_id"]))
		"Level":
			spin_box.value = data["value"]
			for index in compare.item_count -1:
				if data["comparing_sign"] == compare.get_item_text(index):
					compare.select(index)
					break
