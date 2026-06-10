class_name EnemySpawner extends Marker2D 

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0 

# We relay the death of our spawned units up
signal enemy_defeated(score_value: int)
 

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_enemy)
	add_child(timer)
	timer.start()
 

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	var health = new_enemy.get_node("HealthComponent") 
	if health: 
		health.died.connect(_on_spawned_enemy_died) 
	 
	# Now we can safely add it to the level 
	get_parent().add_child(new_enemy) 
	new_enemy.global_position = global_position 
  

func _on_spawned_enemy_died() -> void:
	# Relay the event upward
	enemy_defeated.emit(100) 
