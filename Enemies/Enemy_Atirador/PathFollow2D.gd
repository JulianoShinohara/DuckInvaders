extends PathFollow2D

@export var enemy_speed = 100

#@onready var _enemy: Enemy_Atirador = $Enemy_Atirador

var _player: Player

func _ready():
	var _enemy: Enemy_Atirador = get_child(0)
	_enemy.set_player(_player)

func set_player(player: Player):
	_player = player
	#_enemy.set_player(_player)
	
func _process(delta):
	set_progress(get_progress() + enemy_speed * delta)

func _on_atirador_health_depleted():
	queue_free()
