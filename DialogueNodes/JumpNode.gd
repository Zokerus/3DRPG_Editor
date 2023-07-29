extends GNode

@onready var text_edit = $BoxContainer/TextEdit

func get_data()-> Dictionary:
	var data: Dictionary = super()
	data["mark"] = text_edit.text
	return data

func set_data(data: Dictionary):
	text_edit.text = data["mark"]
