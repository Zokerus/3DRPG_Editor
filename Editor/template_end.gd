extends VBoxContainer

@onready var label = $HBoxContainer/Label

func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "End #" + str(number)
