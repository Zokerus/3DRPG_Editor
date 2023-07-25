extends Resource
class_name Quest

# * BASE
@export var id: String
@export var name: String
@export var quest_series: String
# * REQUIREMENTS
@export var precompleted_quest: Dictionary = {} ## List of completed quests key: QuestID, Value: EndID
@export var faction: String
# * START
@export_enum("NPC", "ITEM", "LOCATION") var quest_start_trigger: String = "NPC"
@export var start_npc:  TaskDialogue
@export var start_item: int
@export var start_location: String
@export var start_description: String
# * OBJECTIVES
@export var objectives: Array
# * END
@export var end_npc: Array
@export var end_description: String
# * REWARDS
@export var rewards: Dictionary	## Dictionary of rewards, Key: EndID, Value: Reward
