extends Node2D

class_name Agent

@export_range(-1.0,1.0)
var alignment = 0.0

@export var id: int


@export_node_path("Sprite2D") var background_path

var background: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background = get_node(background_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	background.modulate = Color.BLUE.lerp(Color.RED, alignment)
