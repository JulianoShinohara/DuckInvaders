class_name Score
extends Label

var score: int = game_controller._score

func _ready():
	text = "Score:" + str(game_controller._score).pad_zeros(5) 

func update_score(enemy) -> void:
	if(enemy is Enemy_Rapido):
		game_controller._score += 15
	if(enemy is Enemy_Atirador): 
		game_controller._score += 10
	if(enemy is Enemy_Multiplo): 
		game_controller._score += 20
	if(enemy is Boss_fase_1):
		game_controller._score += 50
	if(enemy is Boss_fase_2): 
		game_controller._score += 75
	text = "Score:" + str(game_controller._score).pad_zeros(5) 
