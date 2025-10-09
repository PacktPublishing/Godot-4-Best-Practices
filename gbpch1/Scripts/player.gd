# Player class

extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
var health: int = 100


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction.normalized() * SPEED
	animate()
	move_and_slide()
	

func animate():
	if velocity.x > 0 or velocity.y < 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
	elif velocity.x < 0 or velocity.y > 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")
		


func _on_enemy_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("attack"):
			body.attack(self)
			print("Percentage health remaining: "
			+str(body.get_health() / 50 * 100)+"%")
		if body.has_method("get_max_health"):
			print("Maximum health of enemy: "+str(body.get_max_health()))
		
		
func take_damage(amount: int) -> void:
	health -= amount
	print("Player took %d damage, HP= %d" % [amount, health])
	if health <= 0:
		_die()
		
		
func _die() -> void:
	print("Player died")
	queue_free()
