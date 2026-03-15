extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("new_animation")
	$"/root/GameMusic".playing = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name =="new_animation":
		get_tree().change_scene_to_file("res://Florian/FloScene.tscn") # aller à la scène


func _on_button_pressed() -> void:
	play_music()
	get_tree().change_scene_to_file("res://Florian/FloScene.tscn") # aller à la scène

func text_box_change():
	var new_sb = StyleBoxFlat.new()
	new_sb.bg_color = Color(0.176, 0.176, 0.176, 0.62)
	new_sb.border_color = Color(0.176, 0.176, 0.176, 0.82)
	new_sb.set_border_width_all(5)
	new_sb.set_corner_radius_all(10)
	$Control/Label.add_theme_stylebox_override("normal", new_sb)
func play_music():
	$"/root/GameMusic".playing = true
