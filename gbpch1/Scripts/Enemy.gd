# Enemy Super (Parent) Class
extends CharacterBody2D
class_name Enemy

@export var damage: int = 10

var health: int = 50


# Shared behaviour only
func take_damage(amount: int) -> void:
	health -= amount
	print("%s took %d damage (HP=%d)" % [name, amount, health])
	if health <= 0:
		_die()

func _die() -> void:
	print("%s died" % name)
	queue_free()	


func get_health() -> int:
	return health


func _ready() -> void:
	add_to_group("enemies")


func attack(target: Node) -> void:
	print("Default (abstract) attack behavior")
