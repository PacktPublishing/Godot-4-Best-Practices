class_name HUDManager extends CanvasLayer 
 
@onready var score_label: Label = $MarginContainer/ScoreLabel 
@onready var game_over_screen: Control = $GameOverScreen 
 
func update_score_display(new_score: int) -> void: 
	score_label.text = "SCORE: %d" % new_score 
 
func show_game_over() -> void: 
	game_over_screen.visible = true
