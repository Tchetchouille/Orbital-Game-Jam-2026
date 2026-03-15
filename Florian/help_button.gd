extends Button

func _on_pressed() -> void:
	$"../Panel".visible = not $"../Panel".visible
