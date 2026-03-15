extends Line2D

class_name Link

@export var agent1: Agent
@export var agent2: Agent

var created_by_player: bool = false
var removable: bool = true


func _ready() -> void:
	z_index = -1000
	if removable:
		texture = load("res://Mei/lien/corde.png")
		width=20
	else:
		texture = load("res://Mei/lien/chaine.png")
		width = 28
	texture_mode = Line2D.LINE_TEXTURE_STRETCH

func set_removable(value: bool) -> void:
	removable = value

	if removable:
		texture = load("res://Mei/lien/corde.png")
		width=20
	else:
		texture = load("res://Mei/lien/chaine.png")
		width = 28

func set_created_by_player(value: bool) -> void:
	created_by_player = value

func set_agents(new_agent1: Agent, new_agent2: Agent) -> void:
	self.agent1 = new_agent1
	self.agent2 = new_agent2
	print("Link created between agents ", new_agent1.id, " and ", new_agent2.id)

func _process(_delta: float) -> void:
	self.points = PackedVector2Array([agent1.position, agent2.position])
