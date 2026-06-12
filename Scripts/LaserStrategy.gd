class_name LaserStrategy extends WeaponStrategy  

@export var laser_scene: PackedScene  

func fire(spawn_location: Vector2, direction: Vector2) -> void:
	var laser = laser_scene.instantiate()
	laser.global_position = spawn_location
	laser.rotation = direction.angle() + PI/2 

	# We spawn it safely in the world
	Engine.get_main_loop().current_scene.add_child(laser)
