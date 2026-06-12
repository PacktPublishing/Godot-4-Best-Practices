class_name Spawner extends Node2D 

# The Product: What are we building?
@export var product_scene: PackedScene 

# The Container: Where should it live in the Scene Tree?
@export var parent_container: Node 

signal product_created(product: Node)


func spawn() -> Node:
	if not product_scene:
		push_error("No product_scene assigned!")
		return null
	var product = product_scene.instantiate()
	
	# 1. Determine the parent 
	var container = Node
	if parent_container:
		container = parent_container
	else:
		container = get_tree().current_scene
		 
	# 2. Add to tree safely (Call Deferred prevents physics errors) 
	container.call_deferred("add_child", product)
	
	# 3. Position the product at the Spawner's exact location 
	if product is Node2D: 
		product.global_position = global_position 
		product.global_rotation = global_rotation 
	 
	# 4. Announce the creation 
	product_created.emit(product) 
 
	return product 
