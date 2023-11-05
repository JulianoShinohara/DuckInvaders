class_name ButtonA
extends Node2D

@export var button_action: String = "action"

func _new_input(action: String, pressed: bool) -> void:
	var ev: InputEventAction = InputEventAction.new()
	ev.action = action
	ev.pressed = pressed
	Input.parse_input_event(ev)	


func _on_TouchScreenButton_pressed() -> void:
	_new_input(button_action, true)


func _on_TouchScreenButton_released() -> void:
	# Precisa tirar o acesso ao botão enquanto inventário estiver aberto
	_new_input(button_action, false)
