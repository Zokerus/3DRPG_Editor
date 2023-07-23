extends HBoxContainer

var workbench_scene = preload("res://Editor/quest_workbench.tscn")

@onready var workbench = $Workbench
@onready var quest_list = $LeftMenu/VBoxContainer/PanelContainer2/MarginContainer/VBoxContainer/QuestList


## clean up the working area
func _on_new_pressed():
	workbench.queue_free()
	workbench = workbench_scene.instantiate()
	add_child(workbench)


func _on_workbench_request_quest_list(callable):
	callable.call(quest_list)
