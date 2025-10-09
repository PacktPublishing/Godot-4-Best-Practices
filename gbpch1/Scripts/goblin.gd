extends Enemy

@export var burn_damage: int = 2
@export var burn_duration: float = 3.0

var max_health: int = 100

func attack(target: Node) -> void:
	# Goblin's melee attack
	if target and target.has_method("take_damage"):
		target.take_damage(damage)
		_ignite_target(target)
	print("%s slashes %s" % [name, target.name])

func _ignite_target(target: Node) -> void:
	# simple immediate burn — could be improved to DOT
	if target and target.has_method("take_damage"):
		target.take_damage(burn_damage)
	print("%s set %s on fire for %ds" % [name, target.name, burn_duration])


func get_health():
	return health
	
func get_max_health() -> int:
	return max_health
