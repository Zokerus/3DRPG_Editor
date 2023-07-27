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
		var item = item_list.get_item_metadata(index)
		if rewards.items.has(item):
			rewards.items[item] = rewards.items[item] + 1
		else:
			rewards.items[item] = 1
	return rewards

func set_data(reward_data: Reward):
	option_ends.select(option_ends.get_item_index(reward_data.end_id))
	experience.text = str(reward_data.experience_points)
	gold.text = str(reward_data.gold)
	for item in reward_data.items:
		for count in reward_data.items[item]:	## TODO Display the item count 
			var index = item_list.add_item(item)	##TODO: for now. the ItemID is displayed, this must be changed to ItemName
			item_list.set_item_metadata(index, item)	## Put the ItemID as metadata
