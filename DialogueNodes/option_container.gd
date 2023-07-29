extends VBoxContainer
class_name OptionContainer

@onready var title = $HBoxContainer/Title
@onready var text_edit = $TextEdit
@onready var button = $HBoxContainer/Button

func change_headline(number: int):
	title.text = "Option #" + str(number)

func _on_button_pressed():
	queue_free()

func set_data(text: PackedStringArray):
	text_edit.text = "\n".join(text)

func get_data()-> PackedStringArray:
	return text_edit.text.split("\n")
