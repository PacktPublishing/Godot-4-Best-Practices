class_name BasePowerup extends Area2D 
 
@export var speed: float = 100.0
 
# Grab a reference to the notifier node so we can connect its signal
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
 
func _ready() -> void: 
	# Connect both signals consistently via code
	body_entered.connect(_on_body_entered) 
	screen_notifier.screen_exited.connect(_on_screen_exited)
 
func _physics_process(delta: float) -> void: 
	position.y += speed * delta 
 
func _on_screen_exited() -> void: 
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Instead of checking a string group, we check the actual Class Type
	if body is PlayerShip: 
		apply_powerup(body as PlayerShip) 
		queue_free()	 
 
# We enforce that this function will ONLY accept a PlayerShip object
func apply_powerup(player: PlayerShip) -> void: 
	pass
