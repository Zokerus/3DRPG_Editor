extends GraphNode
class_name GNode

var graph_edit = null

func _ready():
	graph_edit = get_parent()

func _on_resize_request(new_minsize):
	size = new_minsize

func get_data()-> Dictionary:
	var data: Dictionary = {}
	data["id"] = name
	data["type"] = title
	
	#Visual Offset, only for GraphEdit
	data["offset_x"] = position_offset.x
	data["offset_y"] = position_offset.y
	
	#Connections
	data["go_to"] = [] # Placeholder, connections will be scaned on the main class
	
	return data

func set_data(_data: Dictionary):
	pass
