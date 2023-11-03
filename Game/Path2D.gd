extends Path2D


var timer = 0
@export var spawnTime = 3
@export var enemy_path = preload("res://path_follow_2d.tscn")
var _player: Player

func set_player(player: Player):
	_player = player

func _process(delta):
	timer = timer + delta
	
	if (timer > spawnTime):
	
		var newEnemy = enemy_path.instantiate()
		newEnemy.progress = randf_range(0, 30)
		newEnemy.set_player(_player)
		add_child(newEnemy)
		timer = 0
		
