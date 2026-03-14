extends Area2D


signal mouse_enter_agent(id)
signal mouse_exit_agent()



func _on_mouse_entered() -> void:
	mouse_enter_agent.emit(self)



func _on_mouse_exited() -> void:
	mouse_exit_agent.emit()
