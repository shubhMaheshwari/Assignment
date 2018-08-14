import numpy as np 
import matplotlib.pyplot as plt 


r = np.sum(2*(np.random.random((500,100)) - 0.5),axis=0)
plt.hist(r, bins=range(-30,30,1))
plt.title("Unifrom Distribuition of random function in numpy")
plt.xlabel("Sum of random numbers")
plt.ylabel("Number of students")

plt.show()