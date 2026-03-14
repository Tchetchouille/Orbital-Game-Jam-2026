extends Line2D

class_name Link

@export var agent1: Agent
@export var agent2: Agent

var created_by_player: bool = false


func _ready() -> void:
	z_index = -1000

func set_created_by_player(value: bool) -> void:
	created_by_player = value

func set_agents(new_agent1: Agent, new_agent2: Agent) -> void:
	self.agent1 = new_agent1
	self.agent2 = new_agent2
	print("Link created between agents ", new_agent1.id, " and ", new_agent2.id)

func _process(_delta: float) -> void:
	self.points = PackedVector2Array([agent1.position, agent2.position])
