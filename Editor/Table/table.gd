extends ScrollContainer
class_name Table

@onready var rows = $Rows

@export var minimum_column_width : int = 100
@export var overrun_state: TextServer.OverrunBehavior = TextServer.OverrunBehavior.OVERRUN_NO_TRIMMING

var old_column_width: int = 100
var old_trim_state: TextServer.OverrunBehavior = TextServer.OverrunBehavior.OVERRUN_NO_TRIMMING
var items: Dictionary
var item_template = preload("res://Editor/Table/table_item.tscn")
var focus_item: TableItem

func add_item(item_name: String, id: int = -1)-> int:
	var template: TableItem = item_template.instantiate()
	rows.add_child(template)
	template.set_item_name(item_name)
	template.set_column_minimum_width(minimum_column_width, int(size.x))
	template.set_trim_state(overrun_state)
	template.item_selected.connect(_on_item_select)
	template.tree_exited.connect(on_table_item_tree_exited)
	if id > -1:
		items[id] = rows.get_child_count() - 1
		template.set_item_id(id)
	else:
		items[rows.get_child_count() - 1] = rows.get_child_count() - 1
		template.set_item_id(rows.get_child_count() - 1)
	return rows.get_child_count() - 1

func remove_selected_item():
	var id = focus_item.id
	rows.get_child(items[focus_item.id]).queue_free()
	items.erase(id)

func on_table_item_tree_exited():
	var index = 0
	for item in rows.get_children():
		items[item.id] = index
		index += 1

func get_item_name(index: int)-> String:
	var item = rows.get_child(index)
	return item.item_name

func get_item_id(index: int)-> int:
	var item = rows.get_child(index)
	return item.id
	
func get_item(index: int)-> TableItem:
	return rows.get_child(index)

func get_selected_index()->int:
	return items[focus_item.id]

func get_items()-> Array:
	return rows.get_children()

func _on_item_select(item: TableItem):
	if focus_item != null:
		focus_item.item_deselect()
	focus_item = item
	focus_item.item_select()
