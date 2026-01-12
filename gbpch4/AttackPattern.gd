class_name AttackPattern extends Resource

@export var damage: int = 10
@export var cooldown: float = 1.0

# Virtual function to be overridden
func execute(user: Node2D, target: Node2D) -> void:
	pass
