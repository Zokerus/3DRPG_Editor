extends Node

var npc_list: Dictionary = {}
var quest_list: Dictionary = {}
var quest_series_list: Dictionary = {}
var item_list: Dictionary = {}
var location_list: Dictionary = {}
var monster_list: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	directory_contents("res://Data/NPC/")
	directory_contents("res://Data/Quest/")
	directory_contents("res://Data/Items/")
	directory_contents("res://Data/Location/")
	directory_contents("res://Data/Monster/")

func directory_contents(path):
	var directory = DirAccess.open(path)
	if directory:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			if directory.current_is_dir():
				print("Found directory: " + file_name)
			else:
				var resource = load(path + file_name)
				if resource is NpcData:
					npc_list[resource.id] = resource
				elif resource is Quest:
					quest_list[resource.id] = resource
					quest_series_list[resource.quest_series] = resource.quest_series
				elif resource is QuestMonsterData:
					monster_list[resource.id] = resource
				elif resource is QuestLocation:
					location_list[resource.id] = resource
				elif resource is ItemData:
					item_list[resource.id] = resource
			file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the path.")
