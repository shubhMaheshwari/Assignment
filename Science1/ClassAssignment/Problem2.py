import matplotlib.pyplot as plt
import random
import math

M = 100000
N = 10

X = [ [0]*N ]*M
Y = [ [0]*N ]*M
Z = [ [0]*N ]*M
D = [0]*N

for k in range(10):
	print("          235")
	print(" STEP:           ",k)

	for i in range(M-1):
		for j in range(N):
			x=0
			y=0
			z=0

			if(random.uniform(0,1) > 0.5):
				x = 1
			else:
				x = -1
			if(random.uniform(0,1) > 0.5):
				y = 1
			else:
				y = -1
			if(random.uniform(0,1) > 0.5):
				z = 1
			else:
				z = -1

			# displacement = math.sqrt(x*x + y*y + z*z)
			displacement = 1.7320508075688772 # (sqrt(3)) 
			X[i+1][j] = X[i][j] + x / displacement
			Y[i+1][j] = Y[i][j] + y / displacement
			Z[i+1][j] = Z[i][j] + z / displacement
			if i%10 == 0:
				print(" He    ",X[i][j],"	",Y[i][j],"		",Z[i][j])

