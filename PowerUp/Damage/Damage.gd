extends RigidBody2D


func _on_area_2d_body_entered(body):
	if body is Player:
		body.set_damage()
		queue_free()

