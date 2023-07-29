extends GNode

@onready var speaker = $BoxContainer/Speaker
@onready var text_edit = $BoxContainer/TextEdit


func get_data()-> Dictionary:
	var data: Dictionary = super()
	data["character"] = speaker.get_selected_id()
	data["text"] = text_edit.text.split("\n")
	return data

func set_data(data: Dictionary):
	speaker.select(data["character"])
	text_edit.text = "/n".join(data["text"])
