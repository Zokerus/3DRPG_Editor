extends BoxContainer

@onready var label = $HBoxContainer3/Label
@onready var quest_id = $HBoxContainer2/QuestID
@onready var end_id = $HBoxContainer/EndID


func _ready():
	pass # Replace with function body.

func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "Quest #" + str(number)

func get_quest_data(quest_data: Quest):
	quest_data.precompleted_quest[quest_id.text] = end_id.get_item_text(end_id.get_selected_id())
