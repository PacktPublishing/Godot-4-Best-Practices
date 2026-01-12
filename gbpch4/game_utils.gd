class_name GameUtils

# Define the margin here. 
# 50 is safer than 20 if you have big asteroids!
const SCREEN_MARGIN: float = 50.0 

enum size {BIG, MEDIUM, SMALL}

static func get_screen_bounds(context_node: Node) -> Vector2:
	var viewport_rect = context_node.get_viewport().get_visible_rect()
	var world_size = viewport_rect.size
	
	var camera = context_node.get_viewport().get_camera_2d()
	if camera:
		world_size = world_size / camera.zoom
		
	# We use the constant internally now
	var x_limit = (world_size.x / 2) + SCREEN_MARGIN
	var y_limit = (world_size.y / 2) + SCREEN_MARGIN
	
	return Vector2(x_limit, y_limit)
