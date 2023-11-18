extends CharacterBody2D

class_name Enemy_Rapido

# Enemy
@export var health: float = 10

var _player: Player


@export var bullet_speed: float = 150
@export var fire_delay: float = 1
@export var fire_error: float = 0.08

var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")
@onready var _animated_sprite = $Sprite2D

var _can_fire: bool = true

signal health_depleted

# Tiros
#var fireRate: float 0.4
func set_player(player: Player):
	_player = player

func _process(delta):
	
	_fire_bullet()
	

func _fire_bullet():
	if not _can_fire:
		return
	var bullet: RigidBody2D = _bullet_res.instantiate()
	bullet.not_target = "enemy"
	bullet.position = $BulletPoint.get_global_position()
	bullet.collision_layer = 8
	bullet.collision_mask = 8
	var dir = (_player.global_position - global_position).normalized()
	bullet.apply_impulse(Vector2(0, -bullet_speed).rotated(dir.angle() + PI / 2.0), Vector2())
	get_tree().get_root().add_child(bullet)
	
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
		

