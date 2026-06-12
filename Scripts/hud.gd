extends Control   

# Container references for dynamic UI instantiation 

@onready var score_container: HBoxContainer = $MarginContainer/ScoreContainer
@onready var lives_container: HBoxContainer = $LivesContainer
@onready var weapon_label: Label = $WeaponContainer/WeaponLabel  

# Data-driven UI: Textures are injected via the Inspector rather than hardcoded.
# 'digit_textures' should map strictly from indices 0-9 to match  

@export var life_texture: Texture2D
@export var digit_textures: Array[Texture2D]  

var score: int = 0


func _ready() -> void:
	# 1. Subscribe to future updates (PUSH)
	EventBus.score_changed.connect(update_score)
	EventBus.player_lives_changed.connect(update_lives)
	EventBus.weapon_changed.connect(update_weapon_display)
	
	# 2. Fetch the initial state from a global authority (PULL)
	var initial_lives = EventBus.current_lives
	var initial_score = EventBus.current_score 

	# 3. Initialize the UI with that true data
	update_weapon_display("LASER CANNON", -1)
	update_score(initial_score)
	update_lives(initial_lives)
	
	
func update_weapon_display(weapon_name: String, ammo: int) -> void:
	# We use -1 as a sentinel value for infinite ammo weapons.
	if ammo < 0:
		weapon_label.text = weapon_name
	else:
		weapon_label.text = weapon_name + " (" + str(ammo) + ")" 
		
		
func update_score(amount: int):
	score += amount
	for child in score_container.get_children():
		child.queue_free() 

	var score_str = str(score)
	# Rebuild the score dynamically by mapping each character
	# to its corresponding texture in the exported array.
	for character in score_str:
		var digit_index = int(character)
		var texture_rect = TextureRect.new()
		texture_rect.texture = digit_textures[digit_index]
		score_container.add_child(texture_rect)
		
		
func update_lives(count: int) -> void:
	# Clear existing life icons
	for child in lives_container.get_children():
		child.queue_free()
		
	# Procedurally generate TextureRects for the current life count
	for i in range(count):
		var icon = TextureRect.new()
		icon.texture = life_texture
		# Programmatically configure sizing constraints
		icon.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.custom_minimum_size = Vector2(32, 32)
		lives_container.add_child(icon)  
