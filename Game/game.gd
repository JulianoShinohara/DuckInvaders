class_name Game
extends Node2D

var Enemy = preload("res://Enemies/Enemy_Atirador/enemy_atirador.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	game_controller.init($Player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


