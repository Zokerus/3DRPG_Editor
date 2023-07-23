extends MarginContainer

signal request_quest_list(callable)

func _on_requirements_request(callable):
	request_quest_list.emit(callable)
