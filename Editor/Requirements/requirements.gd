extends PanelContainer

@onready var v_box_container = $MarginContainer/VBoxContainer/VBoxContainer
@onready var option_faction = $MarginContainer/VBoxContainer/HBoxContainer2/OptionFaction

signal request_quest_list(callable)

var quest_list = null
var template_required_quest = preload("res://Editor/Requirements/template_required_quest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var callable = Callable(self, "set_quest_list")
	request_quest_list.emit(callable)

func set_quest_list(list):
	quest_list = list

func _on_add_pressed(quest_id: int = -1, end_id: int = -1):
	## TODO: Check for selected quest in quest list
	var template = template_required_quest.instantiate()
	v_box_container.add_child(template)
	template.tree_exited.connect(_on_template_extied_tree)
	template.change_headline(v_box_container.get_child_count())
	if quest_id >= 0 and end_id >= 0:
		template.set_quest_data(quest_id, end_id)

func _on_template_extied_tree():
	var index = 1
	for template in v_box_container.get_children():
		template.change_headline(index)
		index = index + 1

func get_quest_data(quest: Quest):
	quest.faction = option_faction.get_item_text(option_faction.get_selected_id())
	for required_quest in v_box_container.get_children():
		required_quest.get_quest_data(quest)

func set_quest_data(quest: Quest):
	for index in option_faction.item_count - 1:
		if option_faction.get_item_text(index):
			option_faction.select(index)
			break
	
	for key in quest.precompleted_quest:
		_on_add_pressed(key, quest.precompleted_quest[key])
