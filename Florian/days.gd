extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Manager".days_passed_changed.connect(_on_days_passed_changed)


func _on_days_passed_changed(new: int) -> void:
	self.text = "Day " + str(new)
