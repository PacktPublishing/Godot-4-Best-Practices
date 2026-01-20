extends RigidBody2D

@export var speed = 500

func _physics_process(delta):
	var movement = Vector2.ZERO
	
	if Input.is_action_pressed("paddle_1_down"):
		movement = Vector2.DOWN
	elif Input.is_action_pressed("paddle_1_up"):
		movement = Vector2.UP
		
	linear_velocity = movement * speed
