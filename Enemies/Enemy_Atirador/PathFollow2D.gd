extends PathFollow2D


var health = 8
var fire_delay = 0.6
var bullet_speed = 150
var speed = 100



var _player: Player

func _ready():
	var _enemy: Enemy_Atirador = get_child(0)
	_enemy.health = health
	_enemy.fire_delay = fire_delay
	_enemy.bullet_speed = bullet_speed
	#var instance = _enemy.instantiate()
	#instance.position = get_global_position()
	_enemy.set_player(_player)

func set_player(player: Player):
	_player = player
	#_enemy.set_player(_player)
	
func _process(delta):
	set_progress(get_progress() + speed * delta)

func _on_atirador_health_depleted():
	queue_free()
