class_name Chase extends State 

@export var actor: CharacterBody2D
@export var speed: float = 150.0
@export var attack_range: float = 200.0
# Variable to control how fast the heavy cruiser can turn
@export var rotation_speed: float = 3.0 

var target: Node2D
  

func enter() -> void:
	target = get_tree().get_first_node_in_group("Player") 

  

func physics_update(delta: float) -> void:
	if not target:
		transitioned.emit(self, "Patrol")
		return 

	var distance = actor.global_position.distance_to(target.global_position)
	if distance <= attack_range:
		transitioned.emit(self, "Attack")
		return

	# 1. Calculate the ideal direction to the target
	var direction = (target.global_position - actor.global_position).normalized() 

	# 2. Smoothly rotate the actor to face that direction
	# We add PI/2 (90 degrees) because sprites face UP by default
	var target_rotation = direction.angle() + PI/2
	actor.rotation = lerp_angle(actor.rotation, target_rotation, rotation_speed * delta) 

	# 3. Move the actor "Forward"
	# The ship moves wherever its nose is pointing
	var forward_direction = Vector2.UP.rotated(actor.rotation)
	actor.velocity = forward_direction * speed
	actor.move_and_slide()
