# This program calculates the probablity of 2 molecules meeting
# after N steps

import matplotlib.pyplot as plt
import random 

# Position of 2 molecules at Nth step 
X = [0,0]
# No of Steps
N = 1000
countArray=[0]*N
# No of iterations
M = 1000

for k in range(M):
	i=0
	X =[0,0]	
	for i in range(0,N):
		
		for j in range(len(X)):
			r = random.uniform(0,1)
			if(r < 0.5):
				X[j] = X[j] + 1
			else:
				X[j] = X[j] - 1
		if X[0]==X[1]:
			countArray[i]=countArray[i]+1

# Analytic solution 
analytic=[1*M]
for i in range(1,M):
	analytic.append(analytic[i-1]*(2*i-1)*(2*i)/(4*i*i)) # 2n! /(2^n * n!)^2 

plt.plot(countArray)		
plt.plot(analytic)
plt.xlabel('Step')
plt.ylabel('Probablity of Meet')
plt.savefig("p1_2drunkProblem.png")
plt.show()