extends PathFollow2D

@export var enemy_speed = 60

#@onready var _enemy: Enemy_Atirador = $Enemy_Atirador

var _player: Player

func _ready():
	var _boss: Boss_fase_1 = get_child(0)
	print("Boss", _boss)
	_boss.set_player(_player)

func set_player(player: Player):
	_player = player
	#_enemy.set_player(_player)
	
func _process(delta):
	set_progress(get_progress() + enemy_speed * delta)
