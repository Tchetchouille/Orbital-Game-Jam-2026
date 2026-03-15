extends Node2D

# NOTE : "Agents" here are actually the area of the agent nodes.

var start_agent : Area2D
var hovered_agent : Area2D
var drawing : bool
var line : Line2D

signal create_link(agent_a, agent_b)
signal delete_link(link)

# Checks if point q lies on segment pr (collinear case).
func _on_segment(p: Vector2, q: Vector2, r: Vector2) -> bool:
	return (
		q.x <= max(p.x, r.x)
		and q.x >= min(p.x, r.x)
		and q.y <= max(p.y, r.y)
		and q.y >= min(p.y, r.y)
	)

# Returns orientation for ordered triplet (p, q, r):
# 0 = collinear, 1 = clockwise, 2 = counterclockwise.
func _orientation(p: Vector2, q: Vector2, r: Vector2) -> int:
	var val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)

	if is_zero_approx(val):
		return 0

	return 1 if val > 0.0 else 2

# Segment intersection test adapted from orientation method.
func _segments_intersect(p1: Vector2, q1: Vector2, p2: Vector2, q2: Vector2) -> bool:
	var o1 = _orientation(p1, q1, p2)
	var o2 = _orientation(p1, q1, q2)
	var o3 = _orientation(p2, q2, p1)
	var o4 = _orientation(p2, q2, q1)

	# General case.
	if o1 != o2 and o3 != o4:
		return true

	# Special collinear cases.
	if o1 == 0 and _on_segment(p1, p2, q1):
		return true
	if o2 == 0 and _on_segment(p1, q2, q1):
		return true
	if o3 == 0 and _on_segment(p2, p1, q2):
		return true
	if o4 == 0 and _on_segment(p2, q1, q2):
		return true

	return false

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
		line.width=20
		line.z_index = -1000
		line.texture = load("res://Mei/lien/corde.png")
		line.texture_mode =Line2D.LINE_TEXTURE_STRETCH
		$"..".add_child(line)
		if hovered_agent != null:
			start_agent = agent
			line.add_point(agent.global_position)
		else:
			Input.set_custom_mouse_cursor(load("res://Mei/curseur/ciseau.png"))
			line.add_point(get_global_mouse_position())
		line.add_point(get_global_mouse_position())
		drawing = true

func end_line():
	if drawing:
		Input.set_custom_mouse_cursor(load("res://Mei/curseur/crayon.png"))
		if line != null:
			$"..".remove_child(line)
			if hovered_agent != null and start_agent != null:
				if hovered_agent != start_agent:
					create_link.emit(start_agent.get_parent().id, hovered_agent.get_parent().id)
			elif hovered_agent == null and start_agent == null:
				var draw_start = line.points[0]
				var draw_end = line.points[1]
				for link in $"../Manager".get_children():
					var link_start = link.agent1.global_position
					var link_end = link.agent2.global_position
					if _segments_intersect(draw_start, draw_end, link_start, link_end):
						delete_link.emit(link)
						print("LINK DELETED" + str(link))
		drawing = false
		start_agent = null
		print("END")
