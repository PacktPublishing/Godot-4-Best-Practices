class_name MainLevel extends Node2D

@export var enemy_spawner: Timer
@export var powerup_spawner: Timer
@export var enemy_scenes: Array[PackedScene] # Access to enemy types
@export var powerup_scenes: Array[PackedScene]

func _ready() -> void:
	enemy_spawner.timeout.connect(_on_spawn_timer)
	enemy_spawner.start()
	
	powerup_spawner.timeout.connect(_on_powerup_timer_timeout) 
	powerup_spawner.start() 
	
func _on_spawn_timer() -> void:
	# 1. Pick a random enemy from the list
	var random_enemy_scene = enemy_scenes.pick_random()
	var enemy = random_enemy_scene.instantiate()
	add_child(enemy)
	# Random x position
	var screen_width = get_viewport_rect().size.x
	enemy.position = Vector2(randf_range(50, screen_width - 50), -50)
	
	
func _on_powerup_timer_timeout() -> void: 
	# Pick a random powerup from the list 
	var random_powerup_scene: PackedScene = powerup_scenes.pick_random() 
	var powerup: Node2D = random_powerup_scene.instantiate() 
	add_child(powerup) 
	# Assign a random X position just off the top of the screen
	var screen_width: float = get_viewport_rect().size.x 
	powerup.global_position = Vector2(randf_range(50.0, screen_width - 50.0), -50.0)
