extends PanelContainer

@onready var v_box_container = $MarginContainer/VBoxContainer/VBoxContainer
@onready var description = $MarginContainer/VBoxContainer/Description

signal change_number_of_ends(number)
signal relay_edit_dialogue(node)

var template_end = preload("res://Editor/End/template_end.tscn")

func _on_add_pressed(end_data: TaskDialogue = null):
	var template = template_end.instantiate()
	v_box_container.add_child(template)
	template.tree_exited.connect(_on_template_extied_tree)
	template.relay_edit_dialogue.connect(_on_npc_trigger_press_edit_dialogue)
	template.change_headline(v_box_container.get_child_count())
	change_number_of_ends.emit(v_box_container.get_child_count())
	if end_data != null:
		template.set_data(end_data)

func _on_template_extied_tree():
	var index = 1
	for template in v_box_container.get_children():
		if template.has_method("change_headline"):
			template.change_headline(index)
		index = index + 1
	change_number_of_ends.emit(v_box_container.get_child_count())

func _on_npc_trigger_press_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func get_quest_data(quest: Quest):
	quest.end_npc.clear()
	for end in v_box_container.get_children():
		quest.end_npc.append(end.get_data())
	
	quest.end_description = description.text

func set_quest_data(quest: Quest):
	for end in quest.end_npc:
		_on_add_pressed(end)
	description.text = quest.end_description
