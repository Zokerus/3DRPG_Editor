extends BoxContainer

@onready var label = $HBoxContainer3/Label


func _ready():
	pass # Replace with function body.

func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "Quest #" + str(number)
