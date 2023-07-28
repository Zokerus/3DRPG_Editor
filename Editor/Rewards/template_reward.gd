extends BoxContainer

@onready var label = $HBoxContainer5/Label
@onready var option_ends = $HBoxContainer2/OptionEnds
@onready var experience = $HBoxContainer/Experience
@onready var gold = $HBoxContainer3/Gold
@onready var table = $Table

var dialog_window = preload("res://Editor/Window/window.tscn")

func change_headline(number : int):
	label.text = "Reward #" + str(number)

func _on_close_pressed():
	queue_free()

func set_number_of_ends(number : int):
	var selected_index = 0
	var selected_item = option_ends.get_item_text(option_ends.get_selected_id())
	
	option_ends.clear()
	option_ends.add_item("All Ends")
	for index in number:
		option_ends.add_item("End #" + str(index + 1))
		if selected_item == "End #" + str(index + 1):
			selected_index = index + 1
	option_ends.select(selected_index)

func get_data() -> Reward:
	var rewards: Reward = Reward.new()
	rewards.end_id = option_ends.get_selected_id()
	rewards.experience_points = int(experience.text)
	rewards.gold = int(gold.text)
	for item in table.get_items():
		rewards.items[item.get_id()] = item.get_item_count()
	return rewards

func set_data(reward_data: Reward):
	option_ends.select(option_ends.get_item_index(reward_data.end_id))
	experience.text = str(reward_data.experience_points)
	gold.text = str(reward_data.gold)
	for item_id in reward_data.items:
			var index = table.add_item(DataManager.item_list[item_id].name, item_id)	##TODO: for now. the ItemID is displayed, this must be changed to ItemName
			table.get_item(index).set_item_count(reward_data.items[item_id])

func _on_add_pressed():
	var dialog = dialog_window.instantiate()
	add_child(dialog)
	dialog.title = "Select items"
	dialog.position = Vector2(1250,get_global_mouse_position().y - 100)
	dialog.load_data(DataManager.item_list)
	dialog.items_selected.connect(_on_add_items)

func _on_add_items(item_ids: Array[int]):
	for id in item_ids:
		table.add_item(DataManager.item_list[id].name, id)

func _on_del_pressed():
	table.remove_selected_item()
