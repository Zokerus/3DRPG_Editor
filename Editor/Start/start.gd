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

func _ready():
	update_option_buttons()
	
func update_option_buttons():
	option_item.clear()
	for item in DataManager.quest_item_list:
		option_item.add_item(DataManager.quest_item_list[item].name, item)
	
	option_location.clear()
	for location in DataManager.location_list:
		option_location.add_item(DataManager.location_list[location].name, location)

func _on_npc_trigger_press_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func get_quest_data(quest: Quest):
	if check_box_location.is_pressed():
		quest.start_location_id = option_location.get_selected_id()
		quest.start_trigger = "LOCATION"
	elif check_box_item.is_pressed():
		quest.start_item_id = option_item.get_selected_id()
		quest.start_trigger = "ITEM"
	else:
		quest.start_trigger = "NPC"
		quest.start_npc = npc_trigger.get_data()
	
	quest.start_description = description.text

func set_quest_data(quest: Quest):
	match quest.start_trigger:
		"NPC":
			check_box_npc.set_pressed(true)
			npc_trigger.set_data(quest.start_npc)
		"Item":
			check_box_item.set_pressed(true)
			option_item.select(option_item.get_item_index(quest.start_item_id))
		"Location":
			check_box_location.set_pressed(true)
			option_item.select(option_item.get_item_index(quest.start_item_id))
	description.text = quest.start_description

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
