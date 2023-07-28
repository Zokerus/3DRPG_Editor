extends HBoxContainer
class_name TableItem

@onready var column_1 = $Column_1
@onready var column_2 = $Column_2

signal item_selected(item: TableItem)

var id: int = -1

func _ready():
	column_1["theme_override_styles/normal"] = StyleBoxFlat.new()
	column_1["theme_override_styles/normal"].bg_color = Color("4c4c4c")
	column_1["theme_override_styles/normal"].border_color = Color("4c4c4c")
	column_1["theme_override_styles/normal"].border_width_left = 2
	column_1["theme_override_styles/normal"].border_width_top = 2
	column_1["theme_override_styles/normal"].border_width_right = 2
	column_1["theme_override_styles/normal"].border_width_bottom = 2
	column_1["theme_override_styles/normal"].corner_radius_top_left = 3
	column_1["theme_override_styles/normal"].corner_radius_top_right = 3
	column_1["theme_override_styles/normal"].corner_radius_bottom_left = 3
	column_1["theme_override_styles/normal"].corner_radius_bottom_right = 3

func set_column_minimum_width(width: int, parent_width: int = 0):
	column_1.custom_minimum_size.x = width
	column_2.custom_minimum_size.x = width
	if parent_width > 2 * width:
		column_1.size.x = parent_width - width

func set_trim_state(overrun_state: TextServer.OverrunBehavior):
	column_1.text_overrun_behavior = overrun_state

func set_item_id(_id: int):
	id = _id

func set_item_name(_name: String):
	column_1.text = _name
	column_1.tooltip_text = _name

func set_item_count(count: int):
	column_2.value = count

func get_item_id()-> int:
	return id

func get_item_name()-> String:
	return column_1.text

func get_item_count()-> int:
	return column_2.value

func item_select():
	column_1["theme_override_styles/normal"].border_color = Color("cccccc")

func item_deselect():
	column_1["theme_override_styles/normal"].border_color = Color("4c4c4c")

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if !event.pressed and event.button_index == 1:
			item_selected.emit(self)

func _on_column_2_gui_input(event):
	if event is InputEventMouseButton:
		if !event.pressed and event.button_index == 1:
			item_selected.emit(self)

