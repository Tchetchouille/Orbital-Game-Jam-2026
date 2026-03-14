extends RichTextLabel

func _process(_delta: float) -> void:
	resize_title()

func resize_title():
	var txt_size = get_window().size.y / 10
	add_theme_font_size_override("normal_font_size", txt_size)


func _on_settings_pressed() -> void:
	pass # Replace with function body.
