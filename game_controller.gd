class_name GameController
extends Node

var _player: Player
var _camera: Camera2D
var _keys_ui: TextureRect
var _Keys: int  = 0
var _keys_height: float

var explosions = {
	"normal": preload("res://Explosion/explosion.tscn"),
	"small":  preload("res://Explosion/explosion_small.tscn"),
	"tiny":   preload("res://Explosion/explosion_tiny.tscn")
}

# PRIVATE METHODS
############################################

# PUBLIC METHODS
############################################
func init(player) -> void:
	_player = player
	#get_tree().call_group("set_player", _player)


func get_camera() -> Camera2D:
	return _camera
	
	
func create_explosion(type: String, pos: Vector2) -> void:
	var explosion = explosions[type].instantiate()
	explosion.global_position = pos
	get_tree().root.add_child(explosion)	
