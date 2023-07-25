extends BoxContainer

@onready var option_button = $HBoxContainer2/OptionButton
@onready var dialogue_name = $HBoxContainer/Dialoguename

signal press_edit_dialogue(node)

var dialogue : Dialogue = null

# Called when the node enters the scene tree for the first time.
func _ready():
	option_button.clear()
	for npc in DataManager.npc_list:
		option_button.add_item(npc.name)
	dialogue = Dialogue.new()

func _process(_delta):
	if !dialogue.data.is_empty():
		dialogue_name.text = "Set"

func _on_edit_pressed():
	press_edit_dialogue.emit(self)
