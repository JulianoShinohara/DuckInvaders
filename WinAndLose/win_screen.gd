extends Control



func set_score(value):
	$Panel/Score.text = "SCORE: " + str(value)

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Stage2/stage2.tscn")


func _on_exit_button_pressed():
	get_tree().paused = false
	game_controller._score = 0
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
