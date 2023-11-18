class_name GameController
extends Node

var _player: Player
var _score: int = 0
var _camera: Camera2D
var _keys_ui: TextureRect
var _Keys: int  = 0
var _keys_height: float

var explosions = {
	"normal": preload("res://Explosion/explosion.tscn"),
	"small":  preload("res://Explosion/explosion_small.tscn"),
	"tiny":   preload("res://Explosion/explosion_tiny.tscn")
}

var powerups = {
	"rapid": preload("res://Explosion/explosion.tscn"),
	"damage":  preload("res://Explosion/explosion_small.tscn"),
	"multi":   preload("res://Explosion/explosion_tiny.tscn"),
	"heart":   preload("res://Explosion/explosion_tiny.tscn")
}

# PRIVATE METHODS
############################################

# PUBLIC METHODS
############################################
func init(player) -> void:
	_player = player
	get_tree().call_group("path" ,"set_player", _player)


func get_camera() -> Camera2D:
	return _camera
		
	
func create_explosion(type: String, pos: Vector2) -> void:
	var explosion = explosions[type].instantiate()
	explosion.global_position = pos
	get_tree().root.add_child(explosion)	
	
func enemy_eliminated(enemy):
	# Ao matar um inimigo fazer a lógica para spawnar um powerup na posição do inimigo morto e fazer com ele dessa até o fim do mapa
	get_tree().call_group("path" , "enemy_eliminated", enemy)
	get_tree().call_group("score", "update_score", enemy)
	
	
