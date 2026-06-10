class_name HitboxComponent extends Area2D
# Export reference to HealthComponent so Hitbox knows where to send
# damage
@export var health_component: HealthComponent
 

func damage(attack_damage: float) -> void:
	if health_component:
		health_component.take_damage(attack_damage)
	else:
		push_warning("Hitbox took damage, but has no HealthComponent linked!") 
