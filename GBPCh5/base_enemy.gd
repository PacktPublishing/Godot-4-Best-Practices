class_name BaseEnemy extends Area2D

@export var health: int = 20
@export var speed: float = 150.0
@export var score_value: int = 100

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	
	
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
		
		
func die():
	EventBus.score_changed.emit(score_value)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Logic for hurting player here
		queue_free()
