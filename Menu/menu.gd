extends Node2D

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Stage1/stage1.tscn")


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_commands_pressed():
	get_tree().call_group("tutorial", "change_visibility", true)


func _on_button_credits_pressed():
	get_tree().change_scene_to_file("res://Creditos/creditos.tscn")
