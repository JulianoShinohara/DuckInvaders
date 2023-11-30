extends CharacterBody2D
class_name Player
@onready var _animated_sprite = $AnimatedSprite2D

@export var speed: float = 300
@export var bullet_speed: float = 400
@export var fire_delay: float = 0.12
@export var fire_error: float = 0.08
@export var health: int = 3
@export var invunerability_time: int = 3
@export var damage: int = 1
@onready var _rapid_fire_timer: SceneTreeTimer = get_tree().create_timer(0)
@onready var _damage_up_timer: SceneTreeTimer = get_tree().create_timer(0)
@onready var _spread_shot_timer: SceneTreeTimer = get_tree().create_timer(0)
@onready var bullet_points = [$BulletPoint,$BulletPoint2,$BulletPoint3]
var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")
var _input_vector: Vector2
var _can_fire: bool = true
var _spread_shot: bool = false
@export var can_be_hit: bool = true

func set_rapid_fire():
	self.fire_delay = 0.04
	self.bullet_speed = 450

	if(_rapid_fire_timer.time_left > 0):
		_rapid_fire_timer.set_time_left(_rapid_fire_timer.time_left + 5)
	else:
		_rapid_fire_timer = get_tree().create_timer(5)
		await _rapid_fire_timer.timeout
		self.bullet_speed = 400
		self.fire_delay = 0.12

func set_damage():
	self.damage = 3
	if(_damage_up_timer.time_left > 0):
		_damage_up_timer.set_time_left(_damage_up_timer.time_left + 5)
	else:
		_damage_up_timer = get_tree().create_timer(5)
		await _damage_up_timer.timeout
		self.damage = 1
		
func set_spread():
	self._spread_shot = true
	if(_spread_shot_timer.time_left > 0):
		_spread_shot_timer.set_time_left(_spread_shot_timer.time_left + 5)
	else:
		_spread_shot_timer = get_tree().create_timer(5)
		await _spread_shot_timer.timeout
		self._spread_shot = false


signal update_player_health
signal player_health_depleted
signal killed

func _ready():
	_animated_sprite.play("default")	

func _physics_process(delta: float) -> void:
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
	if _spread_shot:
		for i in bullet_points:
			var bullet: RigidBody2D = _bullet_res.instantiate()
			bullet.position = i.get_global_position()
			bullet.damage = self.damage
			bullet.apply_impulse(Vector2(0,-bullet_speed), Vector2())
			get_tree().get_root().add_child(bullet)
	else:
		var bullet: RigidBody2D = _bullet_res.instantiate()
		bullet.position = bullet_points[0].get_global_position()
		bullet.damage = self.damage
		bullet.apply_impulse(Vector2(0,-bullet_speed), Vector2())
		get_tree().get_root().add_child(bullet)
	_can_fire = false
	await get_tree().create_timer(fire_delay).timeout
	_can_fire = true	

func _hit(bullet: Bullet) -> void:
	if not is_in_group(bullet.not_target):
		if(can_be_hit == true):
			can_be_hit = false
			set_player_health(health - bullet.damage)
			_animated_sprite.play("invuneravel")
			if health <= 0:
				game_controller.create_explosion("normal", get_global_position())
				emit_signal("player_health_depleted")
				emit_signal("killed")
				$DeathSoundPlayer.play()
			await get_tree().create_timer(invunerability_time).timeout
			_animated_sprite.play("default")
			can_be_hit = true
		
func _on_hit_box_body_entered(body):
	if body.is_in_group("bullet"):
		_hit(body)
		
func set_player_health(health: int):
	self.health = health
	emit_signal("update_player_health", health)
