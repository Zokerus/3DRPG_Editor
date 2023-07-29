extends GNode

var option_template = preload("res://DialogueNodes/option_container.tscn")

func _on_add_pressed(data: PackedStringArray = []):
	var option_Container = option_template.instantiate()
	add_child(option_Container)
	option_Container.tree_exited.connect(_on_option_container_tree_exited)
	set_slot(get_child_count() - 1, false, 0, Color.WHITE, true, 0, Color.WHITE)
	option_Container.change_headline(get_child_count() - 1)
	if !data.is_empty():
		option_Container.set_data(data)

func _on_option_container_tree_exited():
	var index: int = 1
	set_slot(get_child_count() + 1, false, 0, Color.WHITE, false, 0, Color.WHITE)
	for child in get_children():
		if child.has_method("change_headline"):
			child.change_headline(index)
			index += 1

func get_data()-> Dictionary:
	var data: Dictionary = super()
	data["options"] = []
	for child in get_children():
		if child is OptionContainer:
			data["options"].append(child.get_data())
	return data

func set_data(data: Dictionary):
	for option in data["options"]:
		_on_add_pressed(option)
