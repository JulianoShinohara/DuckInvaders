class_name Game
extends Node2D

var Enemy = preload("res://Enemies/Enemy_Atirador/enemy_atirador.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_controller.init($Player)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_spawn_timer_timeout():
	
	#Gerar os inimigos no spawner
	var enemy = Enemy.instantiate()
	add_child(enemy)
	enemy.position = $EnemySpawner.position
	
	var nodes = get_tree().get_nodes_in_group("spawn")
	var node = nodes[randi_range(0, 3)]

	var position = node.position
	$EnemySpawner.position = position

