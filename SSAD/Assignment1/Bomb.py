from Block import Block

class Bomb():
	def __init__(self,x,y,time):
		self.x = x
		self.y = y
		self.time = time

	def update(self):
		self.time = self.time - 1