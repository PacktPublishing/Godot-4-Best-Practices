extends AttackPattern

@export var fire_speed: float = 500.0
@export var projectile_scene: PackedScene

func execute(user: Node2D, target: Node2D) -> void:
	var ball = projectile_scene.instantiate()
	ball.position = user.position
	ball.direction = (target.position - user.position).normalized()
	user.get_parent().add_child(ball)
