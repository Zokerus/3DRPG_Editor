extends Node

var npc_list : Array[NPC_Data]
var quest_list : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	dir_contents("res://Data/NPC/")

func dir_contents(path):
	var count = 0
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				var res = load(path + file_name)
				if res is NPC_Data:
					npc_list.append(res)
					count = count + 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	print(path + " : " + str(count) + " file loaded")
