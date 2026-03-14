import math

class Node():
	def __init__(self,align):
		self.alignement = align
		
	def get_neighbours(self):
		return [Node(-1), Node(-1), Node(1)]
	
	def propagate(self):
		last_align = self.alignement
		new_align = 0 + self.alignement
		for neighbour in self.get_neighbours(): #revoir la terminologie
			new_align += ((math.cos(last_align)**2)*neighbour.alignement)/(len(self.get_neighbours())**3)
			#print(new_align)
		if abs(new_align)>=1:
			new_align = -1 if new_align<0 else 1
		return new_align

node_test = Node(0)
for i in range(100):
	node_test.alignement = node_test.propagate()
	if node_test.alignement == -1:
		print(i)