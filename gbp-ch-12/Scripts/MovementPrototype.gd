# movement_prototype.gd 
class_name MovementPrototype extends Resource 
 
# Virtual function expects to be overridden by specific movement types 
func calculate_velocity(current_pos: Vector2, target_pos: Vector2, speed: float) -> Vector2: 
	return Vector2.ZERO 
