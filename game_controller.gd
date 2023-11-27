class_name GameController
extends Node

var _player: Player
var _score: int = 0
var _stage: int = 1

var explosions = {
	"normal": preload("res://Explosion/explosion.tscn"),
	"small":  preload("res://Explosion/explosion_small.tscn"),
	"tiny":   preload("res://Explosion/explosion_tiny.tscn")
}

var powerups = {
	"heart":   preload("res://PowerUp/Heart/Heart.tscn"),
	"rapid": preload("res://PowerUp/Rapid/Rapid.tscn"),
	"damage":  preload("res://PowerUp/Damage/Damage.tscn"),
	"spread":   preload("res://PowerUp/Spread/Spread.tscn")
}

# PRIVATE METHODS
############################################

# PUBLIC METHODS
############################################
func init(player) -> void:
	_player = player
	get_tree().call_group("path" ,"set_player", _player)

	
func create_explosion(type: String, pos: Vector2) -> void:
	var explosion = explosions[type].instantiate()
	explosion.global_position = pos
	get_tree().root.add_child(explosion)	
	
func enemy_eliminated(enemy):
	# Ao matar um inimigo fazer a lógica para spawnar um powerup na posição do inimigo morto e fazer com ele dessa até o fim do mapa
	#var powerup = powerups["ra"]
	var keyPowerUp
	if(randi_range(1,100) > 90):
		if(_player.health < 3):
			keyPowerUp = powerups.keys()[randi_range(0,3)]
		else:
			keyPowerUp = powerups.keys()[randi_range(1,3)]
		var powerup = powerups[keyPowerUp].instantiate()
		powerup.global_position = enemy.get_global_position()
		get_tree().root.call_deferred("add_child", powerup)
	get_tree().call_group("path" , "enemy_eliminated", enemy)
	get_tree().call_group("score", "update_score", enemy)
	
	
