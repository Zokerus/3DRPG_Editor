extends Window

@onready var item_list = $MarginContainer/VBoxContainer/ItemList

signal items_selected(items: Array[int])

func _on_close_requested():
	queue_free()

func _on_add_pressed():
	var keys: Array[int] = []
	for index in item_list.get_selected_items():
		keys.append(item_list.get_item_metadata(index))
	items_selected.emit(keys)
	queue_free()

func load_data(data: Dictionary):
	var index: int = 0
	item_list.clear()
	for key in data:
		index = item_list.add_item(data[key].name)
		item_list.set_item_metadata(index, key)
	item_list.sort_items_by_text()

func _on_item_list_item_activated(index):
	var keys: Array[int] = []
	keys.append(item_list.get_item_metadata(index))
	items_selected.emit(keys)
	queue_free()
