extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Manager.create_link($Agent3, $Agent4, false, true)
	$Manager.create_link($Agent4, $Agent5, false, false)
	$Manager.create_link($Agent5, $Agent6, false, false)
	$Manager.create_link($Agent6, $Agent7, false, false)
	$Manager.create_link($Agent7, $Agent8, false, false)
	$Manager.create_link($Agent8, $Agent9, false, false)
	$Manager.create_link($Agent9, $Agent3, false, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
