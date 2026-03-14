extends Label


func _ready() -> void:
	$"../Manager".link_changes_max_changed.connect(_on_max_links_changed)

func _on_max_links_changed(max_links) -> void:
	self.text = str(max_links)
