extends Node

class_name Manager

@export var agents: Array[Agent]
var links: Dictionary[String, Link] = {}

func _ready() -> void:
	
	$"../AgentManager".create_link.connect(_on_create_link)
	
	
	create_link(agents[0], agents[1])
	create_link(agents[1], agents[2])
	create_link(agents[2], agents[0])

	for i in range(84):
		do_turn()
		await get_tree().create_timer(0.1).timeout
		print("Turn ", i)

func create_link(agent1: Agent, agent2: Agent) -> void:
	var new_link: Link = Link.new()
	new_link.set_agents(agent1, agent2)
	links[str(agent1.id) + "_" + str(agent2.id)] = new_link
	add_child(new_link)

func propagate_alignment(agent: Agent, neighbors: Array[Agent]) -> float:
	var last_align = agent.alignment
	var new_align = 0 + agent.alignment
	for neighbour in neighbors:
		new_align += ((cos(last_align)**2)*neighbour.alignment)/(len(neighbors)**3)
		if abs(new_align)>=1:
			new_align = -1 if new_align<0 else 1
	return new_align

func do_turn() -> void:
	# Calculate new alignments for all agents
	var new_alignments: Dictionary = {}
	for agent in agents:
		new_alignments[agent] = propagate_alignment(agent, get_neighbors(agent))
		# Animation ?

	# Apply new alignments to all agents
	for agent in agents:
		agent.alignment = new_alignments[agent]

func get_neighbors(agent: Agent) -> Array[Agent]:
	# Find all agents that are connected to the agent by a link
	var neighbors: Array[Agent] = []
	for link_key in links:
		var link = links[link_key]
		if link.agent1 == agent or link.agent2 == agent:
			neighbors.append(get_other_agent(link, agent))
	return neighbors

func get_other_agent(link: Link, agent: Agent) -> Agent:
	return link.agent2 if link.agent1 == agent else link.agent1
	
	
func _on_create_link(agent1_id:int, agent2_id:int):
	print("CONNECT"+str(agent1_id)+"_"+str(agent2_id))
