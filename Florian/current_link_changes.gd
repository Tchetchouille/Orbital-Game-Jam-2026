extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Manager".link_changes_changed.connect(_on_link_changes_changed)

func _on_link_changes_changed(new: int) -> void:
	self.text = str(new)
