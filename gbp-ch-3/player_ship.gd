extends CharacterBody2D

# NODE REFERENCES
@onready var shield_sprite: Sprite2D = $ShieldSprite
@onready var shield_down_sound: AudioStreamPlayer2D = $ShieldDownSound
@onready var blaster: Node2D = $Blaster

@export var max_lives: int = 3
@export var speed: float = 400.0
@export var rotation_speed: float = 20.0 # High value = snappy mouse
var current_lives: int
var current_health: int = 100
var has_shield: bool = false


func _ready() -> void:
	current_lives = max_lives
	# SIGNAL UP: Broadcast state to the UI via our EventBus Autoload
	EventBus.player_lives_changed.emit(current_lives)
	
	
func _physics_process(delta: float) -> void:
	# --- 1. MOVEMENT (Keyboard) ---  
	# get_vector automatically handles 8-way directional input and normalizes # the vector so diagonal movement isn't faster than moving straight.  
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")  
	velocity = direction * speed 
	# move_and_slide applies the velocity and handles all collision physics 
	move_and_slide() 
	 # --- 2. ROTATION (Mouse Aiming) --- 
	var mouse_pos = get_global_mouse_position() 
	 # Calculate angle from current position to the mouse cursor 
	var angle_to_mouse = (mouse_pos - global_position).angle() 
	 # Math Correction:  
	# In Godot, 0 degrees points strictly RIGHT (Vector2.RIGHT).  
	# However, our ship sprite's natural "forward" is UP.  
	# We add PI/2 radians (90 degrees) to offset this so the nose points  
	# at the mouse. 
	var target_rotation = angle_to_mouse + PI/2 
	 # lerp_angle smoothly rotates the ship from its current  
	# angle to the target angle over time 
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta) 

 
	if Input.is_action_pressed("fire_weapon"):
		# CALL DOWN: Safely command the child component
		blaster.fire()
		
		
func take_damage(amount: int) -> void:
	if has_shield:
		has_shield = false
		shield_sprite.visible = false
		shield_down_sound.play()
		return # Shield absorbed the hit
	current_health -= amount
	if current_health <= 0:
		lose_life()


func lose_life() -> void:
	current_lives -= 1
	EventBus.player_lives_changed.emit(current_lives)
	if current_lives <= 0:
		get_tree().call_deferred("reload_current_scene")
