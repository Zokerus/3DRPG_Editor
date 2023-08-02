extends HBoxContainer

var workbench_scene = preload("res://Editor/quest_workbench.tscn")

@onready var workbench = $Workbench
@onready var quest_list = $LeftMenu/VBoxContainer/PanelContainer2/MarginContainer/VBoxContainer/QuestList
@onready var file_dialog = $FileDialog
@onready var listbox_quest = $LeftMenu/VBoxContainer/PanelContainer2/MarginContainer/VBoxContainer/QuestList

func _ready():
	update_listbox_quest_list()

## clean up the working area
func _on_new_pressed():
	workbench.queue_free()
	workbench = workbench_scene.instantiate()
	add_child(workbench)
	workbench.request_quest_list.connect(_on_workbench_request_quest_list)
	workbench.relay_edit_dialogue.connect($"../Dialogue"._on_workbench_relay_edit_dialogue)

func _on_workbench_request_quest_list(callable):
	callable.call(quest_list)

func _on_save_pressed():
	file_dialog.file_mode = file_dialog.FILE_MODE_SAVE_FILE
	file_dialog.access = file_dialog.ACCESS_RESOURCES
	file_dialog.popup_centered()

func _on_load_pressed():
	file_dialog.file_mode = file_dialog.FILE_MODE_OPEN_FILE
	file_dialog.access = file_dialog.ACCESS_RESOURCES
	file_dialog.popup_centered()
	
func _on_file_dialog_file_selected(path):
	if file_dialog.file_mode == file_dialog.FILE_MODE_SAVE_FILE:	## Save a file
		workbench.save_data(path)
		update_listbox_quest_list()
	else:	## Load a file
		_on_new_pressed()
		if ResourceLoader.exists(path):	# check file validity
			var quest = ResourceLoader.load(path)
			if !DataManager.quest_list.has(quest.id):
				DataManager.quest_list[quest.id] = quest
			workbench.load_data(DataManager.quest_list[quest.id])

func update_listbox_quest_list():
	listbox_quest.clear()
	for quest in DataManager.quest_list:
		listbox_quest.add_item(DataManager.quest_list[quest].name)
	listbox_quest.sort_items_by_text()

func _on_quest_list_item_activated(index):
	var quest_name = quest_list.get_item_text(index)
	for quest in DataManager.quest_list:
		if DataManager.quest_list[quest].name == quest_name:
			_on_new_pressed()
			workbench.load_data(DataManager.quest_list[quest])
			return
