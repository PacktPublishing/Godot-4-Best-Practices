extends Node2D

func _ready() -> void:
	# Example: Instancing a modular sub-scene
	var enemy = preload("res://Scenes/Characters/Enemies/goblin.tscn").instantiate()
	add_child(enemy)
	enemy.position = Vector2(115,333)
