import random

N = 5000
M = 100

mean=0
square =0

for i in range(M):
	x=0
	for j in range(N):
		r = random.uniform(0,1)
		if(r < 0.5):
			x = x+1
		else:
			x = x-1
	mean = mean + x	
	square = square + x*x;
	
print(mean/M)
print(square/M)