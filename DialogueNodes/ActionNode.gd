extends GNode

@onready var option_type = $BoxContainer/OptionType
@onready var option_name = $BoxContainer/OptionName
@onready var option_item = $BoxContainer/OptionItem
@onready var h_box_container = $BoxContainer/HBoxContainer
@onready var item_count = $BoxContainer/HBoxContainer/ItemCount

enum ACTIONTYPE{Signal, Quest}
enum SIGNALS{DoScript, HandItem, OpenShop, TrainSkill}
enum QUEST_ACTIONS{Accept, Decline}

func _ready():
	super()
	for item in ACTIONTYPE:
		option_type.add_item(item, ACTIONTYPE[item])
	change_option_name_items(0)
	for item in DataManager.item_list:
		option_item.add_item(DataManager.item_list[item].name, item)

func change_option_name_items(type_index):
	option_name.clear()
	if option_type.get_item_text(type_index) == "Signal":
		for item in SIGNALS:
			option_name.add_item(item, SIGNALS[item])
	elif option_type.get_item_text(type_index) == "Quest":
		for item in QUEST_ACTIONS:
			option_name.add_item(item, QUEST_ACTIONS[item])
func _on_option_type_item_selected(index):
	change_option_name_items(index)

func _on_option_name_item_selected(index):
	if option_name.get_item_text(index) == "HandItem":
		option_item.show()
		h_box_container.show()
	else:
		option_item.hide()
		h_box_container.hide()

func set_data(data: Dictionary):
	option_type.select(option_type.get_item_index(ACTIONTYPE[data["action_type"]]))
	option_type.item_selected.emit(option_type.selected)
	if data["action_type"] == ACTIONTYPE.keys()[ACTIONTYPE.Signal]:
		option_name.select(option_name.get_item_index(SIGNALS[data["action_name"]]))
	else:
		option_name.select(option_name.get_item_index(QUEST_ACTIONS[data["action_name"]]))
	if data["action_name"] == "HandItem" and data.has("item_id"):
		option_item.select(option_item.get_item_index(data["item_id"]))
		item_count.value = data["count"]

func get_data()-> Dictionary:
	var data = super()
	data["action_type"] = option_type.get_item_text(option_type.selected)
	data["action_name"] = option_name.get_item_text(option_name.selected)
	if option_name.get_item_text(option_name.selected) == "HandItem" and item_count.value > 0:
		option_item.get_selected_id()
		data["item_id"] = option_item.get_selected_id()
		data["count"] = item_count.value
	return data


