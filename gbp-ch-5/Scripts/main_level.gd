class_name MainLevel extends Node2D

@onready var enemy_spawner: Timer = $EnemySpawner # Timer reference

@export var enemy_scenes: Array[PackedScene] # Access to enemy types

func _ready() -> void:
	enemy_spawner.timeout.connect(_on_spawn_timer)
	enemy_spawner.start()
	
	
func _on_spawn_timer() -> void:
	# 1. Pick a random enemy from the list
	var random_enemy_scene = enemy_scenes.pick_random()
	var enemy = random_enemy_scene.instantiate()
	add_child(enemy)
	# Random x position
	var screen_width = get_viewport_rect().size.x
	enemy.position = Vector2(randf_range(50, screen_width - 50), -50)
