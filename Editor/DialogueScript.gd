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
var node_index : int

func _ready():
	for button in get_tree().get_nodes_in_group("NodeButtons"):
		button.connect("pressed",  Callable(self, "_on_node_buttons_pressed").bind(button.name))

func _on_node_buttons_pressed(button_name : String):
	add_node_to_graph(graph_nodes[button_name].instantiate(), Vector2(100,100))

func add_node_to_graph(node : GraphNode, offset : Vector2, name_overwrite : bool = true):
	node.position_offset = offset
	node.close_request.connect(_on_node_close_request.bind(node))
	if name_overwrite:
		node.name = node.name + str(node_index)
	graph_edit.add_child(node)
	node_index = node_index + 1

func _on_node_close_request(node : GraphNode):
	for connection in graph_edit.get_connection_list():
		if connection["from"] == node.name || connection["to"] == node.name:
			graph_edit.disconnect_node(connection["from"], connection["from_port"], connection["to"], connection["to_port"])
	node.queue_free()

func _on_graph_edit_delete_nodes_request(nodes):
	for node in nodes:
		_on_node_close_request(node)

func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	graph_edit.disconnect_node(from_node, from_port, to_node, to_port)

func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	graph_edit.connect_node(from_node, from_port, to_node, to_port)
