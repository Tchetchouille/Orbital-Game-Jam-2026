extends Button

@export var ratio = 0.03

func _process(delta: float) -> void:
	resize_text()

func resize_text():
	var txt_size = get_window().size.y * ratio
	add_theme_font_size_override("font_size", txt_size)


func _on_toggled(toggled_on: bool) -> void:
	# Stolen from: https://forum.godotengine.org/t/toggle-full-screen/86670
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)
	match toggled_on:
		true:
			text = "ON"
		false:
			text = "OFF"
	print(text)
