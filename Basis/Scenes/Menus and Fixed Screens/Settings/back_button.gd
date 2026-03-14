extends Button

@export var ratio = 0.05

func _process(delta: float) -> void:
	resize_text()

func resize_text():
	var txt_size = get_window().size.y * ratio
	add_theme_font_size_override("font_size", txt_size)


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Basis/Scenes/Menus and Fixed Screens/Main Menu/main_menu.tscn")
