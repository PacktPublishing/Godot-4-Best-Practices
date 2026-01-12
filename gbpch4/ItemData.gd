# ItemData.gd
class_name ItemData
extends Resource

@export var name: String = "Item"
@export_multiline var description: String = ""
@export var icon: Texture2D
@export var stackable: bool = false
@export var value: int = 10
