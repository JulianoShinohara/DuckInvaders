extends CharacterBody2D

class_name Enemy_Atirador

# Enemy
var health: float = 10
var speed: float = 4.0
var target: Player

# Tiros
#var fireRate: float 0.4

func _ready():
	print("Layer", collision_layer)
	print("Mask", collision_mask)
	pass

func _process(delta):
	velocity.y = 300
	
	move_and_slide()
	


