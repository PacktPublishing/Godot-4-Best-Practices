class_name WeaponStrategy extends Resource  

@export var fire_rate: float = 0.2
@export var energy_cost: int = 5  

# The core strategy function
func fire(spawn_location: Vector2, direction: Vector2) -> void:
	push_error("WeaponStrategy must be overridden by a child class!") 
