class_name Blaster extends Node2D

@export var projectile_scenes: Array[PackedScene]
@export var weapon_names: Array[String] = ["LASER CANNON", "PLASMA BLASTER"]

@onready var muzzle: Marker2D = $Muzzle
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var fire_sound: AudioStreamPlayer2D = $FireSound

# TRACKER: This variable remembers which gun we are using.
# 0 = Normal Laser (Index 0), 1 = Laser Level 2 (Index 1)
var current_weapon_index: int = 0 
var special_ammo: int = 0

func fire() -> void:
	if not cooldown_timer.is_stopped():
		return
	# Safety Check: prevent crashing if the list is empty
	if projectile_scenes.is_empty():
		return
	# 3. SELECT SCENE: Pick the laser based on our current index
	var current_scene = projectile_scenes[current_weapon_index]
	var shot = current_scene.instantiate()
	get_tree().root.add_child(shot)
	shot.global_position = muzzle.global_position
	shot.rotation = global_rotation
	fire_sound.play()
	cooldown_timer.start()
	if current_weapon_index > 0:
		special_ammo -= 1
		if special_ammo <= 0:
			current_weapon_index = 0
			EventBus.weapon_changed.emit(weapon_names[current_weapon_index], -1)
		else: 
			EventBus.weapon_changed.emit(weapon_names[current_weapon_index], special_ammo)
# 4. UPGRADE: This function switches us to the next laser in the list
func upgrade_weapon() -> void:
	# If we are at Index 0 (Level 1), this moves us to Index 1 (Level 2)
	if current_weapon_index < projectile_scenes.size() - 1:
		current_weapon_index += 1
		special_ammo = 5
		var new_weapon_name = weapon_names[current_weapon_index]
		EventBus.weapon_changed.emit(new_weapon_name, special_ammo)
		print("Blaster switched to weapon index: ", current_weapon_index)
