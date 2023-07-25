extends BoxContainer

signal press_edit_dialogue(node)

func _on_npc_trigger_press_edit_dialogue(node):
	press_edit_dialogue.emit(node)
