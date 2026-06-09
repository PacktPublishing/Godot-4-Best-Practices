class_name BaseEnemy extends Area2D

@export var speed: float = 200.0 
@export var health: int = 50

func _physics_process(delta: float) -> void: 
	# Default behavior: fly straight down the screen 
	global_position += Vector2.DOWN * speed * delta
	
	
func die() -> void: 
	queue_free()
