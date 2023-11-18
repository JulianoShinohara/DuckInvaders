extends Path2D

@export var enemy_path = preload("res://Enemies/Boss/path_boss_follow_2d.tscn")
@export var quantityEnemy = 1

signal all_boss_killed

var _player: Player
var enemiesEliminated = 19

func set_player(player: Player):
	_player = player

func enemy_eliminated(enemy):
	if (enemy is Enemy_Atirador):
		enemiesEliminated -= 1
	if (enemiesEliminated == 0):
		var newEnemy = enemy_path.instantiate()
		newEnemy.set_player(_player)
		add_child(newEnemy)
	if (enemy is Boss_fase_1):
		emit_signal("all_boss_killed")


		
		
