extends RigidBody2D


func _on_area_2d_body_entered(body):
	if body is Player:
		if(body.health < 3):
			body.set_player_health(body.health + 1)
		queue_free()

