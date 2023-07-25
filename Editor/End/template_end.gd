extends VBoxContainer

@onready var label = $HBoxContainer/Label
@onready var npc_trigger = $"NPC Trigger"

signal relay_edit_dialogue(node)

func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "End #" + str(number)

func _on_npc_trigger_press_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func get_data() -> TaskDialogue:
	return npc_trigger.get_data()
