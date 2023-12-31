extends PanelContainer

var objective_container = preload("res://Editor/Objectives/objective_container.tscn")

@onready var line_edit = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var v_box_container = $MarginContainer/VBoxContainer/VBoxContainer
@onready var check_box_linear = $MarginContainer/VBoxContainer/CheckBoxLinear

signal relay_edit_dialogue(node)

func _on_button_pressed(objective_data = null):
	var objective = objective_container.instantiate()
	v_box_container.add_child(objective)
	objective.tree_exited.connect(_on_objective_extied_tree)
	objective.relay_edit_dialogue.connect(_on_template_relay_edit_dialogue)
	objective.change_headline(v_box_container.get_child_count())
	line_edit.text = str(v_box_container.get_child_count())
	if objective_data != null:
		objective.set_quest_data(objective_data)
	
func _on_objective_extied_tree():
	var index = 1
	line_edit.text = str(v_box_container.get_child_count())
	for objective in v_box_container.get_children():
		objective.change_headline(index)
		index = index + 1

func _on_template_relay_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func get_quest_data(quest: Quest):
	quest.objective_linear = check_box_linear.is_pressed()
	quest.objectives.clear()
	for objective in v_box_container.get_children():
		quest.objectives.append(objective.get_objective_data()) ##TODO: forthe time being only npc dialogue is prepared

func set_quest_data(quest: Quest):
	check_box_linear.set_pressed_no_signal(quest.objective_linear)
	for objective in quest.objectives:
		_on_button_pressed(objective)
