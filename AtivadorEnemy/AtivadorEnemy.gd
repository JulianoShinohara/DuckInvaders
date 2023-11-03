class_name AtivadorEnemy
extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:

	if body.is_in_group("enemy"):
		body.collision_layer = 5
		body.collision_mask = 5

