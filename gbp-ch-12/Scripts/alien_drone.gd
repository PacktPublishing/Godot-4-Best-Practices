class_name AlienDrone extends CharacterBody2D 

@onready var health_component: HealthComponent = $HealthComponent
 

func _ready() -> void:
	# Health component signals and the drone destroys itself
	health_component.died.connect(on_death)
 

func on_death() -> void:
	# We can spawn explosions, drop scrap metal, and free the node.
	print("Alien Drone destroyed!")
	queue_free() 
