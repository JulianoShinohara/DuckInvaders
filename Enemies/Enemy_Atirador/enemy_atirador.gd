extends CharacterBody2D

class_name Enemy_Atirador

# Enemy
@export var health: float = 10
@export var speed: float = 4.0
var _player: Player


@export var bullet_speed: float = 150
@export var fire_delay: float = 0.5
@export var fire_error: float = 0.08

var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")

var _can_fire: bool = true

# Tiros
#var fireRate: float 0.4
func set_player(player: Player):
	_player = player

func _process(delta):
	#velocity.y = 300
	
	#move_and_slide()
	
	_fire_bullet()
	

func _fire_bullet():
	if not _can_fire:
		return
	var bullet: RigidBody2D = _bullet_res.instantiate()
	bullet.not_target = "enemy"
	bullet.position = $BulletPoint.get_global_position()
	#bullet.velocity.rotate()
	#bullet.look_at(_player.position)
	#bullet.move_towards(_player.position);
	var dir = (_player.global_position - global_position).normalized()
	bullet.global_rotation = dir.angle() + PI / 2.0
	bullet.apply_impulse(Vector2(0, -bullet_speed).rotated(bullet.global_rotation), Vector2())
	get_tree().get_root().add_child(bullet)
	
	_can_fire = false
	await get_tree().create_timer(fire_delay).timeout
	_can_fire = true	

func _hit(bullet: Bullet) -> void:
	print("enemy should be hit",not is_in_group(bullet.not_target))
	if not is_in_group(bullet.not_target):
		health -= bullet.damage
		if health <= 0:
			emit_signal("health_depleted")
			game_controller.create_explosion("small", get_global_position())
			queue_free()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		_hit(body)

