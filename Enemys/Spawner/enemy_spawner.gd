class_name Generator
extends Node2D

@export var generation_delay: float = 1.5
@export var initial_delay: bool = true
@export var enemy_limit: int = 5
@export var atirador_quantity: int = 10
@export_file("*.tscn") var entity_scene: String

var _sprites: Array[Sprite2D]
var _entity_res: Resource
var _timer: Timer
var _player: Player
var _active: bool = false
var _tween: Tween
var _enemy_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get reference to all sprites 2D within this node
	for spr in get_children():
		if spr is Sprite2D:
			_sprites.append(spr)
	
	assert(entity_scene, name + ": 'entity' must de set.")
	#assert(_player, name + ": 'player' must de injected.")
	
	_entity_res = load(entity_scene)

func _generate_entity() -> void:
	if _enemy_count >= enemy_limit:
		return

	if atirador_quantity > 0:
		var instance: Enemy_Atirador = _entity_res.instantiate()
		instance.position = get_global_position()
		instance.set_player(_player)
		get_parent().call_deferred("add_child", instance)
		
		_enemy_count += 1
		instance.health_depleted.connect(_on_enemy_killed)
		
	


func _on_enemy_killed() -> void:
	_enemy_count -= 1

#############################################################
# PUBLIC METHODS
#############################################################

# dependency injection
func set_player(instance: Player) -> void:
	_player = instance


func activate() -> void:
	if _active:
		return
		
	_active = true
	_timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_generate_entity)
	_timer.set_wait_time(generation_delay)
	_timer.set_one_shot(false)
	_timer.start()
	
	if not initial_delay:
		_generate_entity()


func _hit(body: Node2D) -> void:
	health -= body.damage
	
	if _tween:
		_tween.stop()
	_tween = create_tween()
	_tween.tween_property($Sprite2D1, "modulate", Color.RED, 0.0)
	_tween.tween_property($Sprite2D1, "modulate", Color.WHITE, 0.1)
	
	if health <= 0:
		game_controller.get_camera().shake_camera(5, 0.3)
		game_controller.create_explosion("normal", get_global_position())
		queue_free()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		_hit(body)
