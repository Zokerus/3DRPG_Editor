extends MarginContainer

@onready var quest_header = $VBoxContainer/QuestHeader
@onready var requirements = $VBoxContainer/ScrollContainer/HBoxContainer/VBoxContainer/Requirements
@onready var start = $VBoxContainer/ScrollContainer/HBoxContainer/VBoxContainer4/Start
@onready var objectives = $VBoxContainer/ScrollContainer/HBoxContainer/VBoxContainer3/Objectives
@onready var end = $VBoxContainer/ScrollContainer/HBoxContainer/VBoxContainer2/End
@onready var rewards = $VBoxContainer/ScrollContainer/HBoxContainer/VBoxContainer5/Rewards


signal request_quest_list(callable)
signal relay_edit_dialogue(node)

var quest_data: Quest

func _ready():
	quest_data = Quest.new()

func _on_requirements_request(callable):
	request_quest_list.emit(callable)

func _on_panel_relay_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func save_data(file_path: String):
	if quest_data == null:
		quest_data = Quest.new()
	
	quest_header.get_quest_data(quest_data)
	requirements.get_quest_data(quest_data)
	start.get_quest_data(quest_data)
	objectives.get_quest_data(quest_data)
	end.get_quest_data(quest_data)
	rewards.get_quest_data(quest_data)
	
	if file_path != "":
		ResourceSaver.save(quest_data, file_path) ## save data on disk
