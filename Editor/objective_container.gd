extends VBoxContainer

enum OBJECTIVE_TYPES {Dialogue, Kill, Fight, Escort, Delivery, Travel, Trigger}

var objective_templates : Dictionary = {
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Dialogue]: preload("res://Editor/npc_trigger.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Fight]: preload("res://Editor/template_fight.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Kill]: preload("res://Editor/template_fight.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Escort]: preload("res://Editor/template_escort.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Delivery]: preload("res://Editor/template_delivery.tscn"),
	OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Travel]: preload("res://Editor/template_travel.tscn")
	}

@onready var option_button = $ObjectiveType/OptionButton
@onready var label = $HBoxContainer/Label

var template = null

func _ready():
	option_button.clear()
	for types in OBJECTIVE_TYPES:	## Add all values/keys of object_types enum to the optionbutton
		option_button.add_item(types)
	_on_option_button_item_selected(option_button.get_selected_id())	## set the standard selection and load matching template

func _on_option_button_item_selected(index):
	if template != null:
		template.queue_free()	## delete old template, when new option ist selected
		
	if objective_templates.has(option_button.get_item_text(index)):	## Match optionbutton selection to enum
		template = objective_templates[option_button.get_item_text(index)].instantiate()	## load and instantiate matching template
		if option_button.get_item_text(index) == OBJECTIVE_TYPES.keys()[OBJECTIVE_TYPES.Fight]:	## in case of kill quest, use fight template and set the "kill" boolean to true
			template.kill = true
		add_child(template)	## add template to tree

func _on_button_pressed():	## close the objective 
	queue_free()

func change_headline(number : int):
	label.text = "Objective #" + str(number)
