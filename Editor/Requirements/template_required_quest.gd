extends BoxContainer

@onready var label = $HBoxContainer3/Label
@onready var quest_id = $HBoxContainer2/QuestID
@onready var quest_name = $HBoxContainer2/QuestName
@onready var end_id = $HBoxContainer/EndID


func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "Quest #" + str(number)

func get_quest_data(quest_data: Quest):
	quest_data.precompleted_quest[quest_id.text] = end_id.get_item_text(end_id.get_selected_id())

func set_quest_data(_quest_id: int, _end_id: int = 0):
	quest_id.text = str(_quest_id)
	quest_name.text = DataManager.quest_list[_quest_id].name
	set_number_of_ends(DataManager.quest_list[_quest_id].end_npc.size())
	end_id.select(end_id.get_item_index(_end_id))

func set_number_of_ends(number : int):
	end_id.clear()
	end_id.add_item("All Ends", 0)
	for index in number:
		end_id.add_item("End #" + str(index + 1), index + 1 )
	end_id.select(0)
