extends PanelContainer

@onready var npc_trigger = $"MarginContainer/VBoxContainer/NPC Trigger"
@onready var item_trigger = $MarginContainer/VBoxContainer/HBoxContainer3
@onready var location_trigger = $MarginContainer/VBoxContainer/HBoxContainer4
@onready var check_box_npc = $MarginContainer/VBoxContainer/CheckBox_NPC
@onready var check_box_item = $MarginContainer/VBoxContainer/CheckBox_Item
@onready var check_box_location = $MarginContainer/VBoxContainer/CheckBox_Location
@onready var option_item = $MarginContainer/VBoxContainer/HBoxContainer3/OptionItem
@onready var option_location = $MarginContainer/VBoxContainer/HBoxContainer4/OptionLocation
@onready var description = $MarginContainer/VBoxContainer/Description

signal relay_edit_dialogue(node)

func _on_npc_trigger_press_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func get_quest_data(quest: Quest):
	if check_box_npc.is_pressed():
		quest.quest_start_trigger = "NPC"
		quest.start_npc = npc_trigger.get_data()
	elif check_box_item.is_pressed():
		quest.start_item = option_item.get_item_text(option_item.get_selected_id())
		quest.quest_start_trigger = "ITEM"
	else:
		quest.start_location = option_location.get_item_text(option_location.get_selected_id())
		quest.quest_start_trigger = "LOCATION"
	
	quest.start_description = description.text

func _on_check_box_npc_pressed():
	npc_trigger.visible = check_box_npc.is_pressed()
	item_trigger.hide()
	check_box_item.set_pressed_no_signal(false) 
	location_trigger.hide()
	check_box_location.set_pressed_no_signal(false)

func _on_check_box_item_pressed():
	item_trigger.visible = check_box_item.is_pressed()
	npc_trigger.hide()
	check_box_npc.set_pressed_no_signal(false) 
	location_trigger.hide()
	check_box_location.set_pressed_no_signal(false)

func _on_check_box_location_pressed():
	location_trigger.visible = check_box_location.is_pressed()
	npc_trigger.hide()
	check_box_npc.set_pressed_no_signal(false) 
	item_trigger.hide()
	check_box_item.set_pressed_no_signal(false)
