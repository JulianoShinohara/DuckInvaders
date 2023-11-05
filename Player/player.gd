extends CharacterBody2D
class_name Player
@onready var _animated_sprite = $AnimatedSprite2D

@export var speed: float = 300
@export var bullet_speed: float = 400
@export var fire_delay: float = 0.10
@export var fire_error: float = 0.08
@export var health: int = 3
@export var invunerability_time: int = 1

var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")
var _input_vector: Vector2
var _can_fire: bool = true
var _can_be_hit: bool = true

signal update_player_health
signal player_health_depleted

func _physics_process(delta: float) -> void:
	_animated_sprite.play("default")	
	_input_vector.x = Input.get_axis("ui_left", "ui_right")
	_input_vector.y = Input.get_axis("ui_up", "ui_down")
	_input_vector = _input_vector.normalized()
	
	if _input_vector != Vector2.ZERO:
		velocity = _input_vector * speed
	else:
		velocity = _input_vector * 0
	
	#global_position.y = clamp(global_position.y,)
	
	move_and_slide()
	_fire_bullet()
	

func _fire_bullet():
	if not _can_fire:
		return
	var bullet: RigidBody2D = _bullet_res.instantiate()
	bullet.position = $BulletPoint.get_global_position()
	bullet.apply_impulse(Vector2(0,-bullet_speed), Vector2())
	get_tree().get_root().add_child(bullet)
	
	_can_fire = false
	await get_tree().create_timer(fire_delay).timeout
	_can_fire = true	

func _hit(bullet: Bullet) -> void:
	if not is_in_group(bullet.not_target):
		if(_can_be_hit == true):
			_can_be_hit = false
			health -= bullet.damage
			emit_signal("update_player_health", health)
			if health <= 0:
				game_controller.create_explosion("normal", get_global_position())
				emit_signal("player_health_depleted")
				for bullets in get_tree().get_nodes_in_group("bullet"):
					bullets.queue_free()
				get_tree().change_scene_to_file("res://Menu/menu.tscn")
			await get_tree().create_timer(invunerability_time).timeout
			_can_be_hit = true
		
func _on_hit_box_body_entered(body):
	if body.is_in_group("bullet"):
		_hit(body)
