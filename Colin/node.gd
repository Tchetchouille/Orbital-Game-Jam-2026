extends Node

const BASE_PATH := "res://Mei/personnage/"

const FEATURES := {
	"fond_head": ["fond_head_1.png", "fond_head_2.png", "fond_head_3.png"],
	"fond_eye": ["fond_eye_1.png", "fond_eye_2.png", "fond_eye_3.png", "fond_eye_4.png"],
	"eye": ["eye_1.png", "eye_2.png", "eye_3.png", "eye_4.png"],
	"eyebrown": ["eyebrown_1.png", "eyebrown_2.png"],
	"hair": [
		"hair_1_1.png", "hair_1_2.png", "hair_1_3.png",
		"hair_2_1.png", "hair_2_2.png", "hair_2_3.png",
		"hair_3_1.png", "hair_3_2.png", "hair_3_3.png",
		"hair_4_1.png", "hair_4_2.png", "hair_4_3.png",
		"hair_5_1.png", "hair_5_2.png", "hair_5_3.png",
		"hair_6_1.png", "hair_6_2.png", "hair_6_3.png",
	],
	"mouth": ["mouth_1.png", "mouth_2.png", "mouth_3.png", "mouth_4.png"],
	"nose": ["nose_1.png", "nose_2.png", "nose_3.png", "nose_4.png"],
	"accesories": [
		"accesories_1.png", "accesories_2.png", "accesories_3.png",
		"accesories_4.png", "accesories_5.png", "accesories_6.png",
	],
}

func _ready():
	var head_nbr = randi_range(1, 3)
	var eye_nbr = randi_range(1, 4)
	for feature in FEATURES:
		var node = Sprite2D.new()
		if feature == "fond_head":
			node.z_index = 1
			var random_obj = FEATURES[feature].pick_random()
			random_obj = random_obj.substr(0, len(random_obj) - 5)
			random_obj += str(head_nbr) + ".png"
			node.modulate = skin_tone_color()
			node.texture = load(BASE_PATH + feature + "/" + random_obj)
		elif feature == "hair":
			node.z_index = 4
			var random_obj = FEATURES[feature].pick_random()
			random_obj = random_obj.substr(0, len(random_obj) - 5)
			random_obj += str(head_nbr) + ".png"
			node.modulate = Color(randf(), randf(), randf(), 1)
			node.texture = load(BASE_PATH + feature + "/" + random_obj)
		elif feature == "eye":
			node.z_index = 3
			var random_obj = FEATURES[feature].pick_random()
			random_obj = random_obj.substr(0, len(random_obj) - 5)
			random_obj += str(eye_nbr) + ".png"
			node.modulate = Color(randf(), randf(), randf(), 1)
			node.texture = load(BASE_PATH + feature + "/" + random_obj)
		elif feature == "fond_eye":
			node.z_index = 2
			var random_obj = FEATURES[feature].pick_random()
			random_obj = random_obj.substr(0, len(random_obj) - 5)
			random_obj += str(eye_nbr) + ".png"
			node.texture = load(BASE_PATH + feature + "/" + random_obj)
		else:
			node.z_index = 2
			var random_obj = FEATURES[feature].pick_random()
			node.texture = load(BASE_PATH + feature + "/" + random_obj)
		node.position = Vector2($"..".position.x, $"..".position.y + 5)
		node.scale = Vector2(0.1, 0.1)
		add_child(node)
func skin_tone_color():
	var t=randf()
	var r = (129*t**3 -  482*t**2 + 137*t + 244)/255
	var g = (616*t**3 - 1066*t**2 + 237*t + 240)/255
	var b = (556*t**3 -  706*t**2 -  41*t + 238)/255
	var color = Color(r,g,b,1)

	return color
