extends Control



func set_score(value):
	$Panel/Score.text = "SCORE: " + str(value)

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_exit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
