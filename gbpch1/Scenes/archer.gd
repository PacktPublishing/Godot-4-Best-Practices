# Sub (child) class

extends Enemy # Alternative is class location: "res://Scripts/Enemy.gd"

@export var attack_cooldown: float = 1.0


func attack(target: Node) -> void:
	if target and target.has_method("take_damage"):
		target.take_damage(damage)
	print("%s shoots an arrow at %s" 
		   % [name, target.name])
