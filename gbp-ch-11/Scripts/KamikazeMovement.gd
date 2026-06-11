# kamikaze_movement.gd 
class_name KamikazeMovement extends MovementPrototype 
 
func calculate_velocity(current_pos: Vector2, target_pos: Vector2, speed: float) -> Vector2: 
	# Logic: Calculate direction toward the target and multiply by speed 
	var direction: Vector2 = (target_pos - current_pos).normalized() 
	return direction * speed 
 
