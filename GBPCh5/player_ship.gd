# CharacterBody2D for physics-based collision detection 
extends CharacterBody2D 

# --- NODE REFERENCES --- 

@onready var shield_sprite: Sprite2D = $ShieldSprite 
@onready var shield_up_sound: AudioStreamPlayer2D = $ShieldUpSound 
@onready var shield_down_sound: AudioStreamPlayer2D = $ShieldDownSound 
@onready var blaster = $Blaster 

 

# --- EXPORTED VARIABLES --- 

@export var speed: float = 400.0
@export var base_speed: float = 400.0
@export var speed_boost_multiplier: float = 1.5
@export var shield_duration: float = 5.0
@export var rotation_speed: float = 20.0 # High value = snappy mouse 
@export var max_lives: int = 3 

 

# --- STATE VARIABLES --- 

var current_lives: int 
var current_health: int = 100 
var has_shield: bool = false 
var weapon_level: int = 1 

 

func _ready() -> void:
	# Initialize the player's lives when the ship first spawns  
	current_lives = max_lives 

	# SIGNAL UP: We tell the EventBus that our lives have changed. 
	# The HUD listens for this and updates the UI automatically,  
	# keeping the Player entirely decoupled from the UI. 
	EventBus.player_lives_changed.emit(current_lives) 
  

func _physics_process(delta):  
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
	# --- 3. SHOOTING & VISUALS --- 
	if Input.is_action_pressed("fire_weapon"): 
		  # CALL DOWN: The Player safely commands its child to fire           
		blaster.fire() 
		# Add a visual spin to the shield if it is currently active 
		if has_shield: 
			rotate_shield(delta) 

	 
  

func take_damage(amount: int) -> void: 

	# Check for defensive powerups first  

	if has_shield:  

		# The shield absorbs the entire hit, then breaks.  

		has_shield = false  

		shield_sprite.visible = false  

		modulate = Color.WHITE  

		shield_down_sound.play()  

		return # Exit the function early so no health is lost 

 

	# Apply standard damage 
	current_health -= amount 
	if current_health <= 0: 
		lose_life() 
	 
	 
  

func lose_life() -> void:  

	current_lives -= 1 

	# SIGNAL UP: Broadcast the lost life to the UI 
	EventBus.player_lives_changed.emit(current_lives) 
	 
	if current_lives <= 0: 
		game_over() 
	else: 
		respawn() 
	 
	 
  

func game_over() -> void:  

# call_deferred is a safety mechanism. It tells Godot to wait until the 

# current physics frame is completely finished before reloading the scene. # Trying to reload while physics calculations are actively running causes # crashes.  

	get_tree().call_deferred("reload_current_scene") 

 

func respawn() -> void:  

	# Reset the player to a safe starting coordinate and restore health 
	position = Vector2(200, 500) 
	current_health = 100 

	 

	# ========================================= 

	# POWERUP FUNCTIONS 

	# These are called externally when the ship collides with a Powerup  

	# ========================================= 

	 

func activate_shield():  

	has_shield = true  

	shield_sprite.visible = true 

	# Modulate tints the entire ship sprite (optional visual feedback) 
	modulate = Color(0.5, 0.5, 1.0)  
	 
	# Only play the sound if it isn't already playing to prevent audio  

	# stacking 
	if not shield_up_sound.playing: 
		shield_up_sound.play() 
	 
	# This creates a simple coroutine. The code pauses here for  

	# 'shield_duration'seconds, while the rest of the game continues running  
	await get_tree().create_timer(shield_duration).timeout 
	 
	# Verify we STILL have the shield before turning it off. 
	if has_shield: 
		has_shield = false 
		shield_sprite.visible = false 
		modulate = Color.WHITE  
		shield_up_sound.stop() 
		shield_down_sound.play() 
  

func activate_speed_boost():  

	speed = base_speed * speed_boost_multiplier 

	# Await a 5-second timer, then reset to normal 
	await get_tree().create_timer(5.0).timeout 
	speed = base_speed 
  

func upgrade_weapon():  

	# CALL DOWN: Pass the upgrade command to the dedicated blaster component 
	blaster.upgrade_weapon() 

func rotate_shield(delta: float) -> void:  

	# Rotate the shield graphic independently of the ship  
	shield_sprite.rotation += 2.0 * delta 
