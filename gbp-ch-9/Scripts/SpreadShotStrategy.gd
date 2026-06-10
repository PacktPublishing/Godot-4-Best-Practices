class_name SpreadShotStrategy extends WeaponStrategy  

@export var laser_scene: PackedScene
@export var spread_angle: float = 15.0  

func fire(spawn_location: Vector2, direction: Vector2) -> void:
	# Fire 3 lasers at different angles
	var angles = [-spread_angle, 0, spread_angle]
	for angle in angles:
		var laser = laser_scene.instantiate()
		laser.global_position = spawn_location
		var rotated_dir = direction.rotated(deg_to_rad(angle))
		laser.rotation = rotated_dir.angle() + PI/2
		Engine.get_main_loop().current_scene.add_child(laser)
