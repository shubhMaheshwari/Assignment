import matplotlib.pyplot as plt
import numpy as np

x = np.array([0,1,2,3,4])
y = np.array([1,2,3,4,3])
n = x.shape[0]
# Append one to each x
# x = np.vstack((x,np.ones((1,x.shape[0]))))
# Parameters to optimize
w = np.random.random((1,2))

prev_loss = 0
lr = 1e-3

A = 0.5*((np.sum(y**2) - n*np.mean(y)**2) - (np.sum(x**2) - n*np.mean(x)**2))/(n*np.mean(x)*np.mean(y) - np.sum(x*y))


a = -A - np.sqrt(A**2 +1)
b = np.mean(y) - a*np.mean(x)
L = np.sum((y -(a*x + b))**2)/(1 + a**2)
print("Loss:",L)
a = -A + np.sqrt(A**2 +1)
b = np.mean(y) - a*np.mean(x)
L = np.sum((y -(a*x + b))**2)/(1 + a**2)
print("Loss:",L)
print("Hence:a:{} b:{}".format(a,b))

plt.scatter(x,y)
plt.plot(x,a*x + b)
plt.title("Minimum Orthogonal Distance")
plt.xlabel("x")
plt.ylabel("y")
plt.show()