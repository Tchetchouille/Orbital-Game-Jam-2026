extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Manager.create_link($Agent1, $Agent3, false, true)
	$Manager.create_link($Agent1, $Agent2, false, true)
	$Manager.create_link($Agent1, $Agent4, false, false)
	$Manager.create_link($Agent3, $Agent5, false, true)
	$Manager.create_link($Agent3, $Agent4, false, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
