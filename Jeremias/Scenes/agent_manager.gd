extends Node2D

# NOTE : "Agents" here are actually the area of the agent nodes.

var start_agent : Area2D
var hovered_agent : Area2D
var drawing : bool
var line : Line2D

signal create_link(agent_a, agent_b)
signal delete_link(link)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawing = false
	for agent in get_tree().get_nodes_in_group("agent_areas"):
		agent.mouse_enter_agent.connect(agent_enterred)
		agent.mouse_exit_agent.connect(agent_exited)

func _process(_delta: float) -> void:
	if drawing:
		line.points[1] = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		start_line(hovered_agent)
	if Input.is_action_just_released("left_click"):
		end_line()

func agent_enterred(agent):
	hovered_agent = agent

func agent_exited():
	hovered_agent = null

func start_line(agent):
	if not drawing:
		line = Line2D.new()
		line.z_index = -1000
		$"..".add_child(line)
		if hovered_agent != null:
			start_agent = agent
			line.add_point(agent.global_position)
		else:
			line.add_point(get_global_mouse_position())
		line.add_point(get_global_mouse_position())
		drawing = true

func end_line():
	if drawing:
		if line != null:
			$"..".remove_child(line)
			if hovered_agent != null and start_agent != null:
				if hovered_agent != start_agent:
					create_link.emit(start_agent.get_parent().id, hovered_agent.get_parent().id)
			elif hovered_agent == null and start_agent == null:
				var line_length = line.points[0].distance_to(line.points[1])
				for link in $"../Manager".get_children():
					print(link)
					var slope_a = (line.points[1] - line.points[0]).normalized()
					var slope_b = (link.agent2.position - link.agent1.position).normalized()
					var intersect = Geometry2D.line_intersects_line(line.points[0], slope_a, link.agent1.position, slope_b)
					var intersect_length = line.points[0].distance_to(intersect)
					if(line_length >= intersect_length):
						delete_link.emit(link)
		drawing = false
		start_agent = null
		print("END")
