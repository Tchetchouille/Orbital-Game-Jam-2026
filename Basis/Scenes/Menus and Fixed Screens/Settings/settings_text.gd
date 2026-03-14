extends RichTextLabel

@export var ratio = 0.1

func _process(delta: float) -> void:
	resize_text()

func resize_text():
	var txt_size = get_window().size.y * ratio
	add_theme_font_size_override("normal_font_size", txt_size)
