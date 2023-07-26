extends Resource
class_name ItemData

@export var id: int
@export var name: String = ""
@export_multiline var description: String = ""
@export var texture: AtlasTexture
@export var value: int
@export var quest_id: int ## Trigger to start a quest
