extends PathFollow2D

var health = 25
var fire_delay = 0.4
var bullet_speed = 150
var speed = 60
#@onready var _enemy: Enemy_Atirador = $Enemy_Atirador

var _player: Player

func _ready():
	var _boss: Boss_fase_1 = get_child(0)
	_boss.health = health
	_boss.fire_delay = fire_delay
	_boss.bullet_speed = bullet_speed
	_boss.set_player(_player)

func set_player(player: Player):
	_player = player
	#_enemy.set_player(_player)
	
func _process(delta):
	set_progress(get_progress() + speed * delta)
