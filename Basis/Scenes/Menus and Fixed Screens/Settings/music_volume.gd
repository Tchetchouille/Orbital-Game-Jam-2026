extends HBoxContainer


func _on_h_slider_value_changed(value: float) -> void:
	var volume = value - 80
	GameMusic.volume_db = volume
