extends PanelContainer

@onready var v_box_container = $MarginContainer/VBoxContainer/VBoxContainer

signal request_quest_list(callable)

var quest_list = null
var template_required_quest = preload("res://Editor/template_required_quest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var callable = Callable(self, "set_quest_list")
	request_quest_list.emit(callable)

func set_quest_list(list):
	quest_list = list

func _on_add_pressed():
	## TODO: Check for selected quest in quest list
	var template = template_required_quest.instantiate()
	v_box_container.add_child(template)
	template.tree_exited.connect(_on_template_extied_tree)
	template.change_headline(v_box_container.get_child_count())

func _on_template_extied_tree():
	var index = 1
	for template in v_box_container.get_children():
		template.change_headline(index)
		index = index + 1
