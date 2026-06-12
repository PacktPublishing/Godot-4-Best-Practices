class_name HealthComponent extends Node 

# Emitted when health drops to 0
signal died
# Emitted when health changes, useful for updating UI health bars
signal health_changed(new_health: float, max_health: float) 

@export var max_health: float = 100.0  

var current_health: float
 

func _ready() -> void:
	current_health = max_health
 

func take_damage(amount: float) -> void:
	current_health -= amount 
	health_changed.emit(current_health, max_health) 

	if current_health <= 0: 
		died.emit() 
 
