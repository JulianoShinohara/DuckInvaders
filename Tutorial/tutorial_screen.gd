extends Control



func change_visibility(visibility):
	self.visible = visibility


func _on_exit_button_pressed():
	change_visibility(false)
