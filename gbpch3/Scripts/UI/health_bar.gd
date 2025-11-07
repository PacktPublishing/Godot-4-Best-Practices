extends ColorRect

@onready var color_rect: ColorRect = $ColorRect
@export var player: CharacterBody2D


func _on_player_took_damage(new_health: int):
	color_rect.size.x = new_health
