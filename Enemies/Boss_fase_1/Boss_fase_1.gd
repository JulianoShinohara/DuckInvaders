extends CharacterBody2D

class_name Boss_fase_1

# Enemy
@export var health: float = 25
@export var speed: float = 4.0
var _player: Player


@export var bullet_speed: float = 150
@export var fire_delay: float = 0.5
@export var fire_error: float = 0.08

signal boss_killed

var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")

var _can_fire: bool = true

# Tiros
#var fireRate: float 0.4
func set_player(player: Player):
	_player = player
	
func _ready():
	pass

func _process(delta):
	_fire_bullet()
	

func _fire_bullet():
	if not _can_fire:
		return
	var bullet1: RigidBody2D = _bullet_res.instantiate()
	bullet1.not_target = "enemy"
	bullet1.position = $BulletPoint1.get_global_position()
	bullet1.collision_layer = 8
	bullet1.collision_mask = 8
	var dir = (_player.global_position - global_position).normalized()
	bullet1.apply_impulse(Vector2(0, -bullet_speed).rotated(dir.angle() + PI / 2.0), Vector2())
	get_tree().get_root().add_child(bullet1)
	
	var bullet2: RigidBody2D = _bullet_res.instantiate()
	bullet2.not_target = "enemy"
	bullet2.position = $BulletPoint2.get_global_position()
	bullet2.collision_layer = 8
	bullet2.collision_mask = 8
	bullet2.apply_impulse(Vector2(0, -bullet_speed).rotated(dir.angle() + PI / 2.0), Vector2())
	get_tree().get_root().add_child(bullet2)
	
	_can_fire = false
	await get_tree().create_timer(fire_delay).timeout
	_can_fire = true	

func _hit(bullet: Bullet) -> void:
	if not is_in_group(bullet.not_target):
		health -= bullet.damage
		if health <= 0:
			emit_signal("health_depleted")
			game_controller.enemy_eliminated(self)
			game_controller.create_explosion("small", get_global_position())
			queue_free()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		_hit(body)
