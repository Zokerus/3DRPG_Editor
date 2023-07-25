extends BoxContainer

@onready var label = $HBoxContainer5/Label
@onready var option_ends = $HBoxContainer2/OptionEnds
@onready var experience = $HBoxContainer/Experience
@onready var gold = $HBoxContainer3/Gold
@onready var item_list = $ItemList

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
	for index in item_list.item_count - 1:
		var item = item_list.get_item_text(index)
		if rewards.items.has(item):
			rewards.items[item] = rewards.items[item] + 1
		else:
			rewards.items[item] = 1
	return rewards
