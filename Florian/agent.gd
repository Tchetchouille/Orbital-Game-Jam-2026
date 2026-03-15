extends Node2D

class_name Agent

@export_range(-1.0,1.0)
var alignment = 0.0

@export var id: int
@export var portrait: Sprite2D
@export var background: Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	background.modulate = Color(0.1,0.3,0.9).lerp(Color(0.867, 0.188, 0.278, 1.0), (alignment + 1.0) * 0.5)
	$Label.text = str(round(alignment*pow(10.0,3))/pow(10.0,3))
