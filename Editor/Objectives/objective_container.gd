extends VBoxContainer

enum OBJECTIVE_TYPES {Dialogue, Kill, Fight, Escort, Delivery, Travel, Trigger}

var objective_templates : Dictionary = {
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Dialogue]: preload("res://Editor/Start/npc_trigger.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Fight]: preload("res://Editor/Objectives/template_fight.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Kill]: preload("res://Editor/Objectives/template_fight.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Escort]: preload("res://Editor/Objectives/template_escort.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Delivery]: preload("res://Editor/Objectives/template_delivery.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Travel]: preload("res://Editor/Objectives/template_travel.tscn")
	}

@onready var option_button = $ObjectiveType/OptionButton
@onready var label = $HBoxContainer/Label
@onready var v_box_container = $VBoxContainer

signal relay_edit_dialogue(node)

var template = null

func _ready():
	option_button.clear()
	for type in OBJECTIVE_TYPES:	## Add all values/keys of object_types enum to the optionbutton
		option_button.add_item(type, OBJECTIVE_TYPES[type])
	_on_option_button_item_selected(option_button.get_selected_id())	## set the standard selection and load matching template

func _on_option_button_item_selected(index):
	if template != null:
		template.queue_free()	## delete old template, when new option ist selected
		
	if objective_templates.has(option_button.get_item_text(index)):	## Match optionbutton selection to enum
		template = objective_templates[option_button.get_item_text(index)].instantiate()	## load and instantiate matching template
		v_box_container.add_child(template)	## add template to tree
		if template.has_signal("press_edit_dialogue"):
			template.press_edit_dialogue.connect(_on_press_edit_dialogue)
		if option_button.get_item_text(index) == OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Fight]:	## in case of kill quest, use fight template and set the "kill" boolean to true
			template.kill = true

func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "Objective #" + str(number)

func _on_press_edit_dialogue(node):
	relay_edit_dialogue.emit(node)

func get_objective_data() -> Dictionary:
	var data = template.get_data()
	return {"type":option_button.get_item_text(option_button.get_selected_id()), "data":data}

func set_quest_data(objective_data):
	option_button.select(option_button.get_item_index(OBJECTIVE_TYPES[objective_data["type"]]))
	option_button.item_selected.emit(option_button.get_item_index(OBJECTIVE_TYPES[objective_data["type"]]))
	template.set_data(objective_data["data"])
