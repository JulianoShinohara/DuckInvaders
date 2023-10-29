class_name HeartBar
extends HBoxContainer

var heart_full = preload("res://Style/Images/Heart/heart_full.png")
var heart_empty = preload("res://Style/Images/Heart/heart_empty.png")
@onready var player: Player = $"../Player"
var player_scene = preload("res://Player/player.tscn")

func _ready():
	(player as Player).connect("update_player_health", update_health)

func update_health(value: int):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty

