extends PanelContainer

@onready var quest_id = $MarginContainer/VBoxContainer/HBoxContainer2/QuestID
@onready var quest_series = $MarginContainer/VBoxContainer/HBoxContainer3/QuestSeries
@onready var option_quest_series = $MarginContainer/VBoxContainer/HBoxContainer3/OptionQuestSeries
@onready var quest_name = $MarginContainer/VBoxContainer/HBoxContainer4/QuestName

func _on_option_quest_series_item_selected(index):
	quest_series.text = option_quest_series.get_item_text(index)

func get_quest_data(quest: Quest):
	quest.name = quest_name.text
	quest.quest_series = quest_series.text
	quest_id.text = quest_name.text.replacen(" ", "_").to_lower()
	quest.id = quest_id.text
