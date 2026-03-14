extends Node

var features


func _init():
	var directories = DirAccess.get_directories_at("./Mei/personnage")
	features = {}
	for dir in directories:
		var files = DirAccess.get_files_at("./Mei/personnage/"+dir)
		var png_files = Array()
		for file in files:
			if file.ends_with(".png"):
				png_files.append(file)
		features[dir] = png_files

func _ready():
	var head_nbr = null
	var eye_nbr = null
	for feature in features:
		print(feature)
		var node = Sprite2D.new()
		if feature =="fond_head":
			node.z_index = 1
			head_nbr=randi_range(1, 3)
			var random_obj = features[feature].pick_random()
			random_obj = random_obj.substr(0,len(random_obj) - 5)
			random_obj += str(head_nbr)+".png"
			print(random_obj)
			node.modulate = Color(randf(), randf(), randf(),1)
			node.texture = load("./Mei/personnage/"+feature+"/"+random_obj)
		elif feature == "hair":
			node.z_index=4
			var random_obj = features[feature].pick_random()
			random_obj = random_obj.substr(0,len(random_obj) - 5)
			random_obj += str(head_nbr)+".png"
			node.modulate = Color(randf(), randf(), randf(),1)
			node.texture = load("./Mei/personnage/"+feature+"/"+random_obj)
		elif feature == "eye": 
			node.z_index =3
			eye_nbr=randi_range(1, 4)
			var random_obj = features[feature].pick_random()
			random_obj = random_obj.substr(0,len(random_obj) - 5)
			random_obj += str(eye_nbr)+".png"
			node.modulate = Color(randf(), randf(), randf(),1)
			node.texture = load("./Mei/personnage/"+feature+"/"+random_obj)
		elif feature =="fond_eye":
			node.z_index =2
			var random_obj = features[feature].pick_random()
			random_obj = random_obj.substr(0,len(random_obj) - 5)
			random_obj += str(eye_nbr)+".png"
			node.texture = load("./Mei/personnage/"+feature+"/"+random_obj)
		else:
			node.z_index =2
			var random_obj = features[feature].pick_random()
			node.texture = load("./Mei/personnage/"+feature+"/"+random_obj)
		print(node.texture)
		add_child(node)
