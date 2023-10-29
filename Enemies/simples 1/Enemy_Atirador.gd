extends CharacterBody2D

class_name Enemy_Atirador

# Enemy
var health: float = 10
var speed: float = 200.0
var target: Player

# Tiros
#var fireRate: float 0.4

func _physics_process(delta:float) -> void:
	
	if target == null:
		target = get_tree().get_nodes_in_group("player")[0]
	


