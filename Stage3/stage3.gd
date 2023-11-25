class_name Stage3
extends Node2D

var _player: Player
var _all_enemies_killed = false
var _all_boss_killed = false
var _all_enemies_rapido_killed = false


@onready var game_over = $CanvasLayer/GameOverScreen
@onready var win_game = $CanvasLayer/WinScreen


var Enemy = preload("res://Enemies/Enemy_Atirador/enemy_atirador.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	_player = $Player
	var _atiradores = $PathAtirador2D
	var _boss = $PathBoss2D
	var _rapidos = $PathRapido2D
	
	game_controller.init(_player)
	_player.killed.connect(_on_player_killed)
	_atiradores.all_enemies_killed.connect(_enemies_killed)
	_rapidos.all_enemies_rapido_killed.connect(_enemies_rapido_killed)
	_boss.all_boss_killed.connect(_boss_killed)
	
func _enemies_killed():
	_all_enemies_killed = true
	victory()
	
func _boss_killed():
	_all_boss_killed = true
	victory()

func _enemies_rapido_killed():
	_all_enemies_rapido_killed = true
	victory()

func victory():
	if (_all_enemies_killed and _all_boss_killed and _all_enemies_rapido_killed):
		for bullets in get_tree().get_nodes_in_group("bullet"):
			bullets.queue_free()
		await get_tree().create_timer(0.1).timeout
		get_tree().paused = true
		win_game.set_score(game_controller._score)
		win_game.visible = true

func _on_player_killed():
	for bullets in get_tree().get_nodes_in_group("bullet"):
		bullets.queue_free()
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	game_over.set_score(game_controller._score)
	game_over.visible = true

