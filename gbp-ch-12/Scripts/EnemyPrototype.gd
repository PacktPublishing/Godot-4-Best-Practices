# enemy_prototype.gd 
class_name EnemyPrototype extends Resource 
 
@export var prototype_id: String 
@export var display_name: String 
@export var base_health: int 
@export var movement_speed: float 
@export var sprite_texture: Texture2D

# Mix and Match Sub-Prototypes! 
@export var movement_logic: MovementPrototype 
