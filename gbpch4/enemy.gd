class_name Enemy extends CharacterBody2D

@export var attack_pattern: AttackPattern
# The target could also be an Area2D (aggro zone)
@export var target: Node2D

func _on_attack_timer_timeout() -> void:
	if target:
		# Polymorphic call - the resource handles the logic
		attack_pattern.execute(self, target)
