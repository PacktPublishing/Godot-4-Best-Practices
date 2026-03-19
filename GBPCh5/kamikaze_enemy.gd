class_name KamikazeEnemy extends BaseEnemy

# We can add new variables specific to this enemy
@export var rotation_speed: float = 5.0

func _physics_process(delta):
	# 1. Find the target
	# Since we are using Groups, this is safe and easy
	var player = get_tree().get_first_node_in_group("Player")
	
	if player:
		# 2. Calculate the Direction
		# (Target Position - My Position) gives the vector pointing to the target
		var direction = (player.global_position - global_position).normalized()
		
		# 3. Rotate to face the player
		# We use lerp_angle for a smooth turn, adding PI/2 because sprites face UP
		var target_rotation = direction.angle() + PI/2
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
		
		# 4. Move "Forward" (relative to where we are facing)
		# This makes the ship fly like a rocket, having to turn to change course
		var velocity = Vector2.UP.rotated(rotation) * speed
		global_position += velocity * delta

	else:
		# If player is dead, just fly straight
		var velocity = Vector2.UP.rotated(rotation) * speed
		global_position += velocity * delta
		
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(50)
			die()
