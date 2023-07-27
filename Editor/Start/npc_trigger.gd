extends BoxContainer

@onready var option_npc = $HBoxContainer2/OptionNPC
@onready var dialogue_name = $HBoxContainer/Dialoguename

signal press_edit_dialogue(node)

var dialogue : Dialogue = null

# Called when the node enters the scene tree for the first time.
func _ready():
	option_npc.clear()
	for npc in DataManager.npc_list:
		option_npc.add_item(DataManager.npc_list[npc].name, npc)
	dialogue = Dialogue.new()

func _process(_delta):
	if !dialogue.data.is_empty():
		dialogue_name.text = "Set"

func _on_edit_pressed():
	press_edit_dialogue.emit(self)

func get_data() -> TaskDialogue:
	var data : TaskDialogue = TaskDialogue.new()
	data.npc_id = option_npc.get_selected_id()
	data.dialogue = dialogue
	return data

func set_data(start_npc: TaskDialogue):
	option_npc.select(option_npc.get_item_index(start_npc.npc_id))
	dialogue = start_npc.dialogue
