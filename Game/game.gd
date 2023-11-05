class_name Game
extends Node2D

var _player: Player

@onready var game_over = $CanvasLayer/GameOverScreen
@onready var score = $CanvasLayer/Score

var Enemy = preload("res://Enemies/Enemy_Atirador/enemy_atirador.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	_player = $Player
	game_controller.init(_player)
	_player.killed.connect(_on_player_killed)

func _on_player_killed():
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	game_over.set_score(score.score)
	game_over.visible = true


