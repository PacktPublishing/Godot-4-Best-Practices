extends CharacterBody2D

var health: int = 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.take_damage(10)
		
		
func take_damage(amount: int) -> void:
	health -= amount
	print("Goblin took: "+str(amount)+" damage")
