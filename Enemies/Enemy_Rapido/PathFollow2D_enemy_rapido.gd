extends PathFollow2D


var health = 7
var fire_delay = 0.4
var bullet_speed = 150
var speed = 100

var _player: Player

func _ready():
	var _enemy: Enemy_Rapido = get_child(0)
	_enemy.health = health
	_enemy.fire_delay = fire_delay
	_enemy.bullet_speed = bullet_speed
	_enemy.set_player(_player)

func set_player(player: Player):
	_player = player
	#_enemy.set_player(_player)
	
func _process(delta):
	set_progress(get_progress() + speed * delta)

func _on_atirador_health_depleted():
	queue_free()
