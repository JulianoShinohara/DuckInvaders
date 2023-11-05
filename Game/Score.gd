class_name Score
extends Label

var score: int = 0

func update_score(enemy) -> void:
	if(enemy is Enemy_Atirador): 
		score += 10
	if(enemy is Boss_fase_1):
		score += 50
	text = "Score:" + str(score).pad_zeros(5) 
