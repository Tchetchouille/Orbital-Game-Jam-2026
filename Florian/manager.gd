extends Node

class_name Manager

@export var agents: Array[Agent]
var links: Dictionary[String, Link] = {}

var max_link_changes_per_turn: int = 3
var link_changes_this_turn: int = 0

signal link_change_reached_max(link_changes_this_turn: int)

func _ready() -> void:
	$"../AgentManager".create_link.connect(_on_create_link)
	#$"../AgentManager".remove_link.connect(_on_remove_link)
	# create_link(agents[0], agents[1])
	# create_link(agents[1], agents[2])
	# create_link(agents[2], agents[0])

	for i in range(84):
		do_turn()
		await get_tree().create_timer(0.1).timeout
		print("Turn ", i)

func create_link(agent1: Agent, agent2: Agent, created_by_player: bool = false) -> void:
	var new_link: Link = Link.new()
	new_link.set_agents(agent1, agent2)
	links[str(agent1.id) + "_" + str(agent2.id)] = new_link
	new_link.set_created_by_player(created_by_player)
	add_child(new_link)

func remove_link(link: Link) -> void:
	links.erase(str(link.agent1.id) + "_" + str(link.agent2.id))
	remove_child(link)

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

func get_link_by_ids(agent1_id:int, agent2_id:int) -> Link:
	# Ensure agent1_id is smaller than agent2_id
	# (Order is important for the link key)
	if agent1_id > agent2_id:
		var temp = agent1_id
		agent1_id = agent2_id
		agent2_id = temp

	if str(agent1_id)+"_"+str(agent2_id) in links:
		return links[str(agent1_id)+"_"+str(agent2_id)]
	return null

func get_agent_by_id(id: int) -> Agent:
	var idx := agents.find_custom(func(x: Agent): return x.id == id)
	return null if idx == -1 else agents[idx]

func _on_remove_link(link: Link):
	if link.created_by_player:
		link_changes_this_turn -= 1
	else:
		if link_changes_this_turn >= max_link_changes_per_turn:
			link_change_reached_max.emit(link_changes_this_turn)
			print("MAX LINK CHANGES PER TURN REACHED")
			return
		link_changes_this_turn += 1
	remove_link(link)

func _on_create_link(agent1_id:int, agent2_id:int):
	print("CONNECT"+str(agent1_id)+"_"+str(agent2_id))

	if get_link_by_ids(agent1_id, agent2_id) != null:
		print("LINK ALREADY EXISTS")
		return

	if link_changes_this_turn >= max_link_changes_per_turn:
		link_change_reached_max.emit(link_changes_this_turn)
		print("MAX LINK CHANGES PER TURN REACHED")
		return
	
	link_changes_this_turn += 1

	# Create link
	create_link(get_agent_by_id(agent1_id), get_agent_by_id(agent2_id))
