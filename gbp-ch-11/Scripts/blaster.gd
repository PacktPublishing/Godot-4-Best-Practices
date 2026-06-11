class_name Blaster extends Node2D 

  

# --- STRATEGY INJECTION --- 

# Instead of arrays of scenes and strings,  

# we just export slots for our strategy resources! 

@export var basic_weapon: WeaponStrategy 

@export var upgraded_weapon: WeaponStrategy 

  

@onready var muzzle: Marker2D = $Muzzle 

@onready var cooldown_timer: Timer = $CooldownTimer 

@onready var fire_sound: AudioStreamPlayer2D = $FireSound 

  

# The Blaster's brain. Holds whatever strategy is currently active. 

var current_strategy: WeaponStrategy 

var special_ammo: int = 0 

  

func _ready() -> void: 

	# Default to the basic weapon on startup 

	current_strategy = basic_weapon 

	EventBus.weapon_changed.emit("LASER CANNON", -1) 

  

  

func fire() -> void: 

	if not cooldown_timer.is_stopped(): 

		return 

 

	if not current_strategy: 

		push_error("Blaster has no strategy assigned!") 

		return 

  

	# DELEGATION: The Blaster doesn't calculate bullet math anymore.  

	# Where the muzzle is and which way we are facing. 

	current_strategy.fire(muzzle.global_position, 

	Vector2.UP.rotated(global_rotation)) 

 

	fire_sound.play() 

 

	# Pull the specific fire_rate from the strategy resource 

	cooldown_timer.start(current_strategy.fire_rate)  

 

	# --- AMMO TRACKING --- 

	if current_strategy == upgraded_weapon: 

		special_ammo -= 1 

		if special_ammo <= 0: 

			downgrade_weapon() 

		else: 

			EventBus.weapon_changed.emit("SPREAD SHOT", special_ammo) 

  

  

func upgrade_weapon() -> void: 

	# Swap the strategy resource seamlessly 

	current_strategy = upgraded_weapon 

	special_ammo = 5 

	EventBus.weapon_changed.emit("SPREAD SHOT", special_ammo) 

	print("Blaster strategy swapped to: Spread Shot") 

  

  

func downgrade_weapon() -> void: 

	current_strategy = basic_weapon 

	EventBus.weapon_changed.emit("LASER CANNON", -1) 

	print("Blaster strategy swapped to: Basic Laser")
