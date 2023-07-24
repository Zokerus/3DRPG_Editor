extends PanelContainer

@onready var rewards_container = $MarginContainer/VBoxContainer/RewardsContainer

var number_of_ends : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_number_of_ends(number : int):
	number_of_ends = number
	for node in rewards_container.get_children():
		node.set_number_of_ends(number_of_ends)
