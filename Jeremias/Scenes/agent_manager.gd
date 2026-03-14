extends Node2D

var agents : Array
var hovered_agent : Area2D
var drawing : bool
var line : Line2D
var start_agent : Area2D

signal create_link(agent_a, agent_b)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawing = false
	for agent in get_children():
		agent.mouse_enter_agent.connect(agent_enterred)
		agent.mouse_exit_agent.connect(agent_exited)

func _process(delta: float) -> void:
	if drawing:
		line.points[1] = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		if hovered_agent != null:
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
		line.add_point(hovered_agent.position)
		line.add_point(get_global_mouse_position())
		$"..".add_child(line)
		start_agent = hovered_agent
		drawing = true

func end_line():
	if drawing:
		if line != null:
			$"..".remove_child(line)
			if hovered_agent != null:
				create_link.emit(start_agent, hovered_agent)
				print("create link")
		drawing = false
