extends BoxContainer

@onready var label = $HBoxContainer5/Label
@onready var option_button = $HBoxContainer2/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_headline(number : int):
	label.text = "Quest #" + str(number)

func _on_close_pressed():
	queue_free()

func set_number_of_ends(number : int):
	var selected_index = 0
	var selected_item = option_button.get_item_text(option_button.get_selected_id())
	
	option_button.clear()
	option_button.add_item("All Ends")
	for index in number:
		option_button.add_item("End #" + str(index + 1))
		if selected_item == "End #" + str(index + 1):
			selected_index = index + 1
	option_button.select(selected_index)
