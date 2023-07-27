extends PanelContainer

@onready var quest_id = $MarginContainer/VBoxContainer/HBoxContainer2/QuestID
@onready var quest_series = $MarginContainer/VBoxContainer/HBoxContainer3/QuestSeries
@onready var option_quest_series = $MarginContainer/VBoxContainer/HBoxContainer3/OptionQuestSeries
@onready var quest_name = $MarginContainer/VBoxContainer/HBoxContainer4/QuestName

func _ready():
	update_option_quest_series()

func _on_option_quest_series_item_selected(index):
	quest_series.text = option_quest_series.get_item_text(index)

func get_quest_data(quest: Quest):
	quest.name = quest_name.text
	quest.quest_series = quest_series.text
#	quest_id.text = quest_name.text.replacen(" ", "_").to_lower()
	quest.id = quest_id.text

func set_quest_data(quest: Quest):
	quest_name.text = quest.name
	quest_series.text = quest.quest_series
	quest_id.text = str(quest.id)
	
func update_option_quest_series():
	option_quest_series.clear()
	option_quest_series.add_item("None")
	for list_entry in DataManager.quest_series_list:
		if list_entry != "" or !list_entry.is_empty() or list_entry != "None":
			option_quest_series.add_item(list_entry)
