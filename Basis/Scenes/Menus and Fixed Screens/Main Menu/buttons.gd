extends VBoxContainer

func _process(_delta: float) -> void:
	resize_buttons()

func resize_buttons():
	var txt_size = get_window().size.y / 20
	$Play.add_theme_font_size_override("font_size", txt_size)
	$Settings.add_theme_font_size_override("font_size", txt_size)
	$Credits.add_theme_font_size_override("font_size", txt_size)
	$Quit.add_theme_font_size_override("font_size", txt_size)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Basis/Scenes/main.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Basis/Scenes/Menus and Fixed Screens/Settings/settings.tscn")

func _on_credits_pressed() -> void:
		get_tree().change_scene_to_file("res://Basis/Scenes/Menus and Fixed Screens/Credits/credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
