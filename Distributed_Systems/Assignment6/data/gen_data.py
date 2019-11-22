import os
import random
import numpy as np
from sklearn.datasets import make_spd_matrix

size = 1000
a = make_spd_matrix(size, size);

b = np.zeros([size, 1]);
for i in range(size):
	for j in range(size):
		b[i] += a[i][j]

with open("./q3_input", "w+") as f:
	f.write(str(size) + " " +str(size+1) +"\n")
	for i in range(size):
		sum = 0
		for j in range(size):
			f.write(str(a[i][j]) + " ")
		f.write(str(b[i][0]) + "\n") 
 
	f.close()