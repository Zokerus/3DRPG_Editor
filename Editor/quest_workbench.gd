extends MarginContainer

signal request_quest_list(callable)
signal relay_edit_dialogue(node)

func _on_requirements_request(callable):
	request_quest_list.emit(callable)

func _on_panel_relay_edit_dialogue(node):
	relay_edit_dialogue.emit(node)
