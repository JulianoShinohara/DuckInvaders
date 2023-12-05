class_name ButtonFullscreen
extends Button

var _is_full_screen: bool = false

func _toggle_fullscreen() -> void:
	_is_full_screen = not _is_full_screen
	
	if _is_full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("fullscreen"):
		_toggle_fullscreen();
		
func _ready() -> void:
	self.focus_mode = Control.FOCUS_NONE
	if OS.has_feature("mobile"):
		set_visible(false)
		
func _on_pressed() -> void:
	_toggle_fullscreen()
