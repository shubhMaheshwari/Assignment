import random
from matplotlib import pyplot as plt
import math

# size of the grid
N = 8
# No of iterations
EXPERIMENTS = 1000
# No of steps
TIME =1000
# Radius
RADIUS = 100


time_array = [i for i in range(0, TIME)]

def valid(row, col):
	if(row < 0 or row >= N or col < 0 or col >= N):
		return False
	return True

def solve(mouseTheta, mouseAlpha, catTheta, catAlpha):
	
	frq = [0] * TIME
	probability = [0] * TIME

	for i in range(0, EXPERIMENTS):

		mouseRow = mouseStartRow
		mouseCol = mouseStartCol
		catRow = catStartRow
		catCol = catStartY

		x = random.randint(0,1)
		y = random.randint(0,1)
		z = random.randint(0,1)
		dist = math.sqrt(x*x + y*y)
		

		mouse_movement = math.atan(y/x)


		for j in range(1, TIME):

			if(valid(mouseRow + mouse_movement[0], mouseCol + mouse_movement[1])):
				mouseRow = mouseRow + mouse_movement[0]
				mouseCol = mouseCol + mouse_movement[1]

			if(valid(catRow + cat_movement[0], catCol + cat_movement[1])):
				catRow = catRow + cat_movement[0]
				catCol = catCol + cat_movement[1]

			if(mouseRow == catRow and mouseCol == catCol):
				frq[j] = frq[j] + 1
				break

	return [(frq[i] / EXPERIMENTS) for i in range(0, TIME)]
		
MID = N // 2
Opposite = solve(0, 0, N - 1, N - 1)
Center = solve(MID, MID, MID, MID)

plt.plot(time_array, Opposite, label = "Starting at Opposite Corners")
plt.plot(time_array, Center, label = "Starting at Center")
plt.legend()
plt.ylabel("Death Probability")
plt.xlabel("Time")
plt.savefig("Center_Grid.png")
plt.close()