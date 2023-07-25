extends Resource
class_name Quest

# * BASE
@export var name: String
@export var description: String
@export var state: String
# * REQUEREMENT
@export var precompleted_quest = ""
@export var requerements: Array
# * DIALOGUE TRIGGER
@export var quest_trigger: String = ""
@export var quest_start_dialogue: String = ""
@export var quest_running_dialogue: String = ""
# * TASKS
@export var linear: bool = false
@export var tasks: Array
# * DELIVERY
@export var delivery: bool = false
@export var delivery_done: bool = false
@export var delivery_trigger: String = ""
@export var delivery_dialogue: String = ""
# * TASKS
@export var rewards: Array
