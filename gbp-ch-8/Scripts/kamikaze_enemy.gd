class_name KamikazeEnemy extends BaseEnemy

# We add a NEW variable specific to this enemy type
@export var rotation_speed: float = 5.0

func _physics_process(delta: float) -> void: 
	# 1. Find the target safely using Groups 
	var player = get_tree().get_first_node_in_group("Player") 
	if player: 
		# 2. Calculate the Direction Vector towards the player 
		var direction = (player.global_position -
		global_position).normalized() 
		# 3. Rotate smoothly to face the player 
		var target_rotation = direction.angle() + PI / 2.0 
		rotation = lerp_angle(rotation, target_rotation, rotation_speed *
		delta) 
		# 4. Move relative to where the nose of the ship is pointing 
		var velocity = Vector2.UP.rotated(rotation) * speed 
		global_position += velocity * delta 

	else: 
		# If the player is dead/missing, revert to flying straight 
		var velocity = Vector2.UP.rotated(rotation) * speed 
		global_position += velocity * delta
		
		
func _on_body_entered(body: Node2D) -> void: 
	# Ensure we only hit the player, ignoring asteroids or other enemies 
	if body.is_in_group("Player"): 
		if body.has_method("take_damage"): 
			body.take_damage(50) 
			# Call the generic cleanup function inherited from BaseEnemy 
			die()
