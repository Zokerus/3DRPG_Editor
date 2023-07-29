extends VBoxContainer

@onready var title = $HBoxContainer/Title
@onready var text_edit = $TextEdit
@onready var button = $HBoxContainer/Button

func change_headline(number: int):
	title.text = "Option #" + str(number)
	
func set_data(text: String):
	text_edit.text = text 

func get_data()-> String:
	return text_edit.text

func _on_button_pressed():
	queue_free()
