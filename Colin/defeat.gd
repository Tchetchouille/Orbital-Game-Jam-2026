extends Node2D

func _on_button_pressed() -> void:
	var last: String = get_tree().get_meta("last_scene", "")
	if last != "":
		get_tree().change_scene_to_file(last)
	else:
		get_tree().reload_current_scene()
