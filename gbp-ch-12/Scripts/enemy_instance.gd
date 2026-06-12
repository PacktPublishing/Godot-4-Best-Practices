# enemy_instance.gd 
class_name EnemyInstance extends CharacterBody2D 
 
# 1. We inject the Prototype data into the Instance 
@export var stats: EnemyPrototype  
 
# 2. We track ONLY the data unique to this specific Instance 
var current_health: int 
var player: Node2D
 
@onready var sprite: Sprite2D = $Sprite2D 
 
func _ready() -> void: 
	# Initialize our physical state using the shared Prototype data 
	current_health = stats.base_health 
	sprite.texture = stats.sprite_texture 
	
	# Find the active player in the Scene Tree using the Group
	player = get_tree().get_first_node_in_group("Player")
 
func take_damage(amount: int) -> void: 
	# Subtract from the Instance's health pool, NOT the Prototype! 
	current_health -= amount 
	if current_health <= 0: 
		queue_free()
		
		
func _physics_process(delta: float) -> void: 
	# Safely ensure a movement logic resource is equipped 
	if stats.movement_logic != null: 
			 
		# Pass physical state into Resource's logic function 
		var new_velocity = stats.movement_logic.calculate_velocity( 
		global_position,  
		player.global_position,  
		stats.base_speed 
		) 
				 
		velocity = new_velocity 
		move_and_slide() 
