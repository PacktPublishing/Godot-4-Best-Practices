extends CharacterBody2D
signal took_damage(amount)

var health: int = 50
var stamina: int = 50
var total_arrows: int = 0

func take_damage(amount: int) -> void:
	health -= amount
	emit_signal("took_damage",health)


func _physics_process(delta: float) -> void:
	const SPEED = 250.0
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("ui_accept"):
		group_attack()
		
	move_and_slide()
	
	
func group_attack() -> void:
	get_tree().call_group("enemies", "take_damage", 10)
	
	
func increase_arrows(amount: int):
	total_arrows += amount
	print("Total arrows: "+str(total_arrows))
