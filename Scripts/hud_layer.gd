# 2. hud.gd (Presentation Layer - No math)  
extends CanvasLayer  
@onready var score_label = $ScoreLabel  
 
# The HUD is a translator that only updates when commanded  
func update_score_display(new_score: int) -> void:   
	score_label.text = "Score: " + str(new_score)
