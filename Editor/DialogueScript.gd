extends HBoxContainer

##Workspace & file dialog to save and load files
@onready var file_dialog = $FileDialog
@onready var graph_edit = $GraphEdit

##Graphnodes, to be used on the graph editor (visual scripting)
var graph_nodes : Dictionary = {
"Dialogue" : preload("res://DialogueNodes/DialogueNode.tscn"),
"End":  preload("res://DialogueNodes/EndNode.tscn"),
"Jump" : preload("res://DialogueNodes/JumpNode.tscn"),
"Mark" : preload("res://DialogueNodes/MarkNode.tscn"),
"Options" : preload("res://DialogueNodes/OptionsNode.tscn"),
"Quest" : preload("res://DialogueNodes/QuestNode.tscn"),
"Start" : preload("res://DialogueNodes/StartNode.tscn") }

var dialogue : Dialogue

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
	_on_graph_edit_delete_nodes_request(graph_edit.get_children())

## save the created graph/dialogue
func _on_save_pressed():
	file_dialog.file_mode = file_dialog.FILE_MODE_SAVE_FILE
	file_dialog.access = file_dialog.ACCESS_RESOURCES
	file_dialog.popup_centered()

func _on_file_dialog_file_selected(path):
	if file_dialog.file_mode == file_dialog.FILE_MODE_SAVE_FILE:	## Save a file
		save_data(path)
	else:	## Load a file
		pass

func save_data(file_path : String):
	if !dialogue:
		dialogue = Dialogue.new()
	dialogue.data.clear()
	
	for node in graph_edit.get_children():
		#Node Creation
		var dialog_node = {}
		dialog_node["id"] = node.name
		dialog_node["type"] = node.title
		
		#Node Text
		dialog_node["text"] = (node.find_child("TextEdit").text).split("\n")
		
		#Visual Offset, only for GraphEdit
		dialog_node["offset_x"] = node.position_offset.x
		dialog_node["offset_y"] = node.position_offset.y
		
		#Connections
		dialog_node["go_to"] = []
		for connection in graph_edit.get_connection_list():
			if connection["from"] == node.name:
				dialog_node["go_to"].append([connection["from_port"], connection["to"], connection["to_port"]])
		
		## Character, that is speaking that part (NPC or Player(hero))
		if node.title == "Dialogue" || node.title == "Option" || node.title == "Quest":
			dialog_node["character"] = node.find_child("OptionButton").get_selected_id()
		
		## Mark for jumping points
		if node.title == "Mark":
			dialog_node["id"] = node.title + "Node" + str(node.find_child("TextEdit").text)
		
		## Pointer towards a quest, TODO: needs need adaption to quest system
		if node.title == "Quest":
			dialog_node["quest_id"] = node.find_child("QuestID").text
		
	# store data in dialogue resource
		dialogue.data[dialog_node["id"]] = dialog_node
	
	if file_path != "":
		ResourceSaver.save(dialogue, file_path) ## save data on disk
