extends Control



func set_score(value):
	$Panel/Score.text = "SCORE: " + str(value)

func _on_restart_button_pressed():
	get_tree().paused = false
	if(game_controller._stage == 5):
		get_tree().change_scene_to_file("res://Creditos/creditos.tscn")
	else:
		game_controller._stage += 1
		get_tree().change_scene_to_file("res://Stage" + str(game_controller._stage) + "/stage" + str(game_controller._stage) + ".tscn")


func _on_exit_button_pressed():
	get_tree().paused = false
	game_controller._score = 0
	game_controller._stage = 1
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
