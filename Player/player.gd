class_name Player
extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D

@export var speed: float = 300
@export var bullet_speed: float = 400
@export var fire_delay: float = 0.10
@export var fire_error: float = 0.08
@export var health: int = 3

var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")
var _input_vector: Vector2
var _can_fire: bool = true

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
	
	if(Input.is_action_pressed("fire")):
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
	health -= bullet.damage
	
	if health <= 0:
		emit_signal("player_health_depleted")
		get_tree().change_scene_to_file("res://Menu/menu.tscn")
	#	game_controller.create_explosion("small", get_global_position())
		


func _on_hit_box_body_entered(body):
	if body.is_in_group("bullet"):
		_hit(body)
