class_name PlayerShip extends CharacterBody2D

# NODE REFERENCES
@onready var shield_sprite: Sprite2D = $ShieldSprite
@onready var shield_down_sound: AudioStreamPlayer2D = $ShieldDownSound
@onready var blaster: Node2D = $Blaster
@onready var shield_up_sound: AudioStreamPlayer2D = $ShieldUpSound

@export var max_lives: int = 3
@export var speed: float = 400.0
@export var base_speed: float = 400.0
@export var speed_boost_multiplier: float = 1.5
@export var shield_duration: float = 5.0
@export var rotation_speed: float = 20.0 

var current_lives: int
var current_health: int = 100
var has_shield: bool = false


func _ready() -> void:
	current_lives = max_lives
	EventBus.player_lives_changed.emit(current_lives)
	
	
func _physics_process(delta: float) -> void:
	# --- 1. MOVEMENT (Keyboard) ---  
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")  
	velocity = direction * speed 
	move_and_slide() 
	
	# --- 2. ROTATION (Mouse Aiming) --- 
	var mouse_pos = get_global_mouse_position() 
	var angle_to_mouse = (mouse_pos - global_position).angle() 
	var target_rotation = angle_to_mouse + PI/2 
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta) 


# --- COMMAND RECEIVER INTERFACES ---

func fire_weapon() -> void:
	# CALL DOWN: Safely command the child component
	blaster.fire()


func activate_shield() -> void:  
	if has_shield:
		return # Shield is already active
		
	has_shield = true  
	shield_sprite.visible = true 
	modulate = Color(0.5, 0.5, 1.0)  
	 
	if not shield_up_sound.playing: 
		shield_up_sound.play() 
	 
	await get_tree().create_timer(shield_duration).timeout 
	 
	if has_shield: 
		has_shield = false 
		shield_sprite.visible = false 
		modulate = Color.WHITE  
		shield_up_sound.stop() 
		shield_down_sound.play() 


# --- SYSTEM LOGIC ---

func take_damage(amount: int) -> void:
	if has_shield:
		has_shield = false
		shield_sprite.visible = false
		shield_down_sound.play()
		modulate = Color.WHITE
		return 
	current_health -= amount
	if current_health <= 0:
		lose_life()


func lose_life() -> void:
	current_lives -= 1
	EventBus.player_lives_changed.emit(current_lives)
	if current_lives <= 0:
		get_tree().call_deferred("reload_current_scene")
		
		
func upgrade_weapon() -> void:
	blaster.upgrade_weapon()
	
	
func activate_speed_boost() -> void:
	speed = base_speed * speed_boost_multiplier
	await get_tree().create_timer(5.0).timeout 
	speed = base_speed
