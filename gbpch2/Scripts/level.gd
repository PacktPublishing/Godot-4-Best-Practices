extends Node2D

@onready var label: Label = $Label
var _player_health: int = 100

var player_health: int = 100:
	set(value):
		_player_health = value
		label.text = "Player Health: " + str(_player_health)
	get():
		return _player_health

func _ready() -> void:
	player_health = _player_health

func take_damage(amount: int = 10) -> void:
	player_health = max(0, player_health - amount)

func _on_damage_button_pressed() -> void:
	take_damage()

func _on_save_button_pressed() -> void:
	SaverLoader.save_game(player_health)

func _on_load_button_pressed() -> void:
	player_health = SaverLoader.load_game()

func _on_reset_button_pressed() -> void:
	player_health = 100
