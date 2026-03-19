# We use Area2D for projectiles because we only need to detect overlap (hitboxes),
# not physical pushing or bouncing (which would require CharacterBody2D or RigidBody2D).
extends Area2D

# @export exposes these variables to the Godot Inspector, allowing us to easily 
# tweak the speed and damage of different laser types (like our inherited 
# LaserLevel2 scene) without needing to change the underlying code.
@export var speed: float = 1000.0
@export var damage: int = 10

# _physics_process runs at a fixed, consistent rate (default 60 times per second).
# We use it for movement to ensure the laser travels smoothly and fairly, 
# regardless of the player's computer performance.
func _physics_process(delta: float) -> void:
	# In Godot 2D, Vector2.UP (X: 0, Y: -1) is the default "forward" direction. 
	# By rotating this vector by the laser's current rotation, the projectile will 
	# always fly straight out of the cannon, regardless of which way the ship is facing.
	var direction = Vector2.UP.rotated(rotation)
	
	# Move the laser forward. Multiplying by 'delta' (the fraction of a second 
	# since the last frame) ensures the movement is frame-rate independent.
	position += direction * speed * delta


# This function is connected to the 'screen_exited' signal of a 
# VisibleOnScreenNotifier2D child node. It acts as our automatic garbage collector.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# If the laser flies off the screen and we don't delete it, it will travel 
	# through empty space forever, silently eating up RAM until the game crashes.
	# queue_free() safely deletes the laser from memory at the end of the frame.
	queue_free()


# This function triggers when another Area2D's collision shape overlaps with 
# this laser's shape. (Note: Collision Masks dictate exactly *what* can overlap).
func _on_area_entered(area: Area2D) -> void:
	# This is a classic example of "Duck Typing" and Loose Coupling. 
	# Instead of checking if the area is specifically an "EnemyDrone" or an "Asteroid", 
	# we simply ask the engine: "Does the thing we just hit have a take_damage function?"
	if area.has_method("take_damage"):
		
		# If it does, we pass our damage value to it. 
		area.take_damage(damage)
		
		# Finally, the laser destroys itself upon impact so it doesn't pierce 
		# through multiple targets like a railgun (unless that is the intended design!).
		queue_free()
