extends PanelContainer

@onready var v_box_container = $MarginContainer/VBoxContainer/VBoxContainer

var template_end = preload("res://Editor/template_end.tscn")

func _on_add_pressed():
	var template = template_end.instantiate()
	v_box_container.add_child(template)
	template.tree_exited.connect(_on_template_extied_tree)
	template.change_headline(v_box_container.get_child_count())

func _on_template_extied_tree():
	var index = 1
	for template in v_box_container.get_children():
		if template.has_method("change_headline"):
			template.change_headline(index)
		index = index + 1
