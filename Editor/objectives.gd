extends PanelContainer

var objective_container = preload("res://Editor/objective_container.tscn")

@onready var line_edit = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var v_box_container = $MarginContainer/VBoxContainer/VBoxContainer

func _on_button_pressed():
	var objective = objective_container.instantiate()
	v_box_container.add_child(objective)
	objective.tree_exited.connect(_on_objective_extied_tree)
	objective.change_headline(v_box_container.get_child_count())
	line_edit.text = str(v_box_container.get_child_count())
	
func _on_objective_extied_tree():
	var index = 1
	line_edit.text = str(v_box_container.get_child_count())
	for objective in v_box_container.get_children():
		objective.change_headline(index)
		index = index + 1
