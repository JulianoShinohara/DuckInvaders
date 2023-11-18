extends Path2D


var timer = 0
@export var spawnTime = 3
@export var enemy_path = preload("res://Enemies/Enemy_Atirador/path_follow_2d.tscn")
@export var quantityEnemy = 22
@export var quantityEnemiesOnScreen = 5
@export var health = 8
@export var fire_delay = 0.6
@export var bullet_speed = 150
@export var speed = 100

signal all_enemies_killed
var _enemiesInLife = 0
var _enemiesEliminated = 0
var _player: Player

func set_player(player: Player):
	_player = player

func _process(delta):
	timer = timer + delta
	
	if (timer > spawnTime and _enemiesInLife <= quantityEnemiesOnScreen and quantityEnemy > 0):
		
		var newEnemy = enemy_path.instantiate()
		newEnemy.progress = randf_range(0, 300)
		newEnemy.set_player(_player)
		newEnemy.health = health
		newEnemy.fire_delay = fire_delay
		newEnemy.bullet_speed = bullet_speed
		add_child(newEnemy)
		timer = 0
		_enemiesInLife += 1
		quantityEnemy -= 1

func enemy_eliminated(enemy):
	if (enemy is Enemy_Atirador):
		_enemiesInLife -= 1
		_enemiesEliminated += 1
		if (_enemiesEliminated == 22):
			emit_signal("all_enemies_killed")
		
