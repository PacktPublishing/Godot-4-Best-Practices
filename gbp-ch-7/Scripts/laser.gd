# We use Area2D for projectiles because we only need to detect
# overlap (hitboxes)
extends Area2D
# @export exposes these variables to the Godot Inspector
@export var speed: float = 1000.0
@export var damage: int = 10 
# Grab a reference to our child node as soon as the scene loads
@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
func _ready() -> void: 
	# Connect the signals in code so the logic is completely transparent 
	area_entered.connect(_on_area_entered) 
	visible_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
# _physics_process runs at a fixed, consistent rate
func _physics_process(delta: float) -> void: 
	# Vector2.UP (X: 0, Y: -1) is the default "forward" direction.
	# Rotating this vector by the current rotation means the
	# projectile will always fly straight out of the cannon
	var direction = Vector2.UP.rotated(rotation) 
	# Move the laser forward. 
	position += direction * speed * delta 
# This function acts as our automatic garbage collector.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# queue_free() safely deletes the laser at end of frame.
	queue_free() 
# Function triggers when another Area2D's collision shape overlaps
func _on_area_entered(area: Area2D) -> void:
	# Classic example of "Duck Typing" and Loose Coupling. 
	# Ask the engine: "Does it have a take_damage function?" 
	if area.has_method("take_damage"):
		# If it does, we pass our damage value to it.
		area.take_damage(damage) 
		# Finally, the laser destroys itself upon impact 
		queue_free()
