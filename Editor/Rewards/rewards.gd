extends PanelContainer

@onready var rewards_container = $MarginContainer/VBoxContainer/RewardsContainer

var number_of_ends : int = 1
var reward_template = preload("res://Editor/Rewards/template_reward.tscn")

func set_number_of_ends(number : int):
	number_of_ends = number
	for node in rewards_container.get_children():
		node.set_number_of_ends(number_of_ends)

func _on_add_pressed():
	var template = reward_template.instantiate()
	template.tree_exited.connect(_on_template_rewards_tree_exited)
	rewards_container.add_child(template)
	template.change_headline(rewards_container.get_child_count())
	template.set_number_of_ends(number_of_ends)

func _on_template_rewards_tree_exited():
	var index = 1
	for template in rewards_container.get_children():
		template.change_headline(index)
		index = index + 1

func get_quest_data(quest: Quest):
	quest.rewards.clear()
	for reward in rewards_container.get_children():
		var data: Reward = reward.get_data()
		quest.rewards[data.end_id] = data
