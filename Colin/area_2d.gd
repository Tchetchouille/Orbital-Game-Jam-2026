extends Area2D

func propagate(agent, neighbours):
	var last_align = agent.alignement
	var new_align = 0 + agent.alignement
	for neighbour in neighbours:
		new_align += ((cos(last_align)**2)*neighbour.alignement)/(len(neighbours)**3)
		if abs(new_align)>=1:
			new_align = -1 if new_align<0 else 1
	return new_align
