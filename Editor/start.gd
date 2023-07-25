extends PanelContainer

@onready var npc_trigger = $"MarginContainer/VBoxContainer/NPC Trigger"
@onready var item_trigger = $MarginContainer/VBoxContainer/HBoxContainer3
@onready var location_trigger = $MarginContainer/VBoxContainer/HBoxContainer4
@onready var check_box_npc = $MarginContainer/VBoxContainer/CheckBox_NPC
@onready var check_box_item = $MarginContainer/VBoxContainer/CheckBox_Item
@onready var check_box_location = $MarginContainer/VBoxContainer/CheckBox_Location

signal relay_edit_dialogue(node)

func _on_check_box_pressed():
	npc_trigger.visible = check_box_npc.is_pressed()
	item_trigger.visible = check_box_item.is_pressed()
	location_trigger.visible = check_box_location.is_pressed()

func _on_npc_trigger_press_edit_dialogue(node):
	relay_edit_dialogue.emit(node)
