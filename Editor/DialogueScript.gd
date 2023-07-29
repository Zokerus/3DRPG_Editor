extends HBoxContainer

##Workspace & file dialog to save and load files
@onready var file_dialog = $FileDialog
@onready var graph_edit = $GraphEdit
@onready var tab_container = $".."

##Graphnodes, to be used on the graph editor (visual scripting)
var graph_nodes : Dictionary = {
"Action": preload("res://DialogueNodes/ActionNode.tscn"),
"Dialogue": preload("res://DialogueNodes/DialogueNode.tscn"),
"End":  preload("res://DialogueNodes/EndNode.tscn"),
"Jump": preload("res://DialogueNodes/JumpNode.tscn"),
"Mark": preload("res://DialogueNodes/MarkNode.tscn"),
"Options": preload("res://DialogueNodes/OptionsNode.tscn"),
"Quest": preload("res://DialogueNodes/QuestNode.tscn"),
"Start": preload("res://DialogueNodes/StartNode.tscn"),
"Condition":  preload("res://DialogueNodes/ConditionNode.tscn")}

var dialogue : Dialogue
var quest_node = null

## GraphNodes pressed event connected to one generic method with one parameter (button name)
func _ready():
	for button in get_tree().get_nodes_in_group("NodeButtons"):
		button.connect("pressed",  Callable(self, "_on_node_buttons_pressed").bind(button.name))

##Add graph node to the editor based on the button name
func _on_node_buttons_pressed(button_name : String):
	add_node_to_graph(graph_nodes[button_name].instantiate(), graph_edit.scroll_offset + Vector2(100,100))

func add_node_to_graph(node : GraphNode, offset : Vector2, name_overwrite : bool = true):
	node.position_offset = offset	## position offset of the initialize position, so the nodes is not create in the left upper corner
	node.close_request.connect(_on_node_close_request.bind(node))	##
	if name_overwrite:
		node.name = node.name + str(get_tree().get_nodes_in_group(node.get_groups()[0]).size()) ##rename the graph node based on the former node name and the number of existing nodes of that type, to create unique names
	graph_edit.add_child(node)

## delete/close the given node
func _on_node_close_request(node : GraphNode):
	##delete all connections the node has
	for connection in graph_edit.get_connection_list():
		if connection["from"] == node.name || connection["to"] == node.name:
			graph_edit.disconnect_node(connection["from"], connection["from_port"], connection["to"], connection["to_port"])
	node.queue_free()

## delete alle node in the given array
func _on_graph_edit_delete_nodes_request(nodes):
	for node in nodes:
		_on_node_close_request(node)

## connect the nodes based on the parameter
func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	graph_edit.disconnect_node(from_node, from_port, to_node, to_port)

## disconnect the nodes based on the parameter
func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	graph_edit.connect_node(from_node, from_port, to_node, to_port)

## delete all nodes and clear the dialogue for clean working area
func _on_new_pressed():
	dialogue = Dialogue.new()
	quest_node = null
	_on_graph_edit_delete_nodes_request(graph_edit.get_children())

## save the created graph/dialogue
func _on_save_pressed():
	if quest_node == null:
		file_dialog.file_mode = file_dialog.FILE_MODE_SAVE_FILE
		file_dialog.access = file_dialog.ACCESS_RESOURCES
		file_dialog.popup_centered()
	else:
		save_data("")
	
func _on_load_pressed():
	file_dialog.file_mode = file_dialog.FILE_MODE_OPEN_FILE
	file_dialog.access = file_dialog.ACCESS_RESOURCES
	file_dialog.popup_centered()

func _on_workbench_relay_edit_dialogue(node):
	_on_new_pressed()
	quest_node = node
	dialogue = node.dialogue
	tab_container.current_tab = 0
	load_data()

func _on_file_dialog_file_selected(path):
	if file_dialog.file_mode == file_dialog.FILE_MODE_SAVE_FILE:	## Save a file
		save_data(path)
	else:	## Load a file
		quest_node = null
		if ResourceLoader.exists(path):	# check file validity
			dialogue = ResourceLoader.load(path)
			load_data()

func save_data(file_path : String):
	if !dialogue:
		dialogue = Dialogue.new()
	dialogue.data.clear()
	
	for node in graph_edit.get_children():
	# store data in dialogue resource
		dialogue.data[node.name] = node.get_data()
	
	#Connections
	for connection in graph_edit.get_connection_list():
		dialogue.data[connection["from"]]["go_to"].append([connection["from_port"], connection["to"], connection["to_port"]])
	
	if file_path != "":
		ResourceSaver.save(dialogue, file_path) ## save data on disk
	elif quest_node != null:
		quest_node.dialogue = dialogue

func load_data():
	if dialogue == null:	## check data in resource
		dialogue = Dialogue.new()	##if not valid, create new dialogue resource
		return	## leave method
	
	## loop all graph nodes and initiate them
	for key in dialogue.data.keys():
		load_node(graph_nodes[dialogue.data[key]["type"]].instantiate(), dialogue.data[key])
	
	## after init graph nodes, connect them
	for key in dialogue.data.keys():
		var connections = dialogue.data[key]["go_to"]
		for connection in connections:
			if connection.size() == 3:
				_on_graph_edit_connection_request(dialogue.data[key]["id"], connection[0], connection[1], connection[2])

## load graph node detail data
func load_node(node : GraphNode, data : Dictionary):
	node.name = data["id"]
	## set global position ind graph_edit, only needed in editor
	add_node_to_graph(node, Vector2(data["offset_x"],data["offset_y"]), false)
	node.set_data(data)
#
