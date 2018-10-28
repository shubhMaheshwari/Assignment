import numpy as np
import matplotlib.pyplot as plt


fig = plt.figure()
X = np.linspace(-10,10,100)

def sigmoid(X):
	return 1./(1+np.exp(-X))

def tanh(X):
	return np.arctan(X)

def relu(X):
	Y = X.copy()
	Y[X<0] = 0
	return Y
ax = fig.add_subplot(1,3,1)
ax.plot(X,sigmoid(X),label='sigmoid')
ax.plot(X,sigmoid(X)*(1-sigmoid(X)),label='derivative')
ax.set_title("Sigmoid")

ax = fig.add_subplot(1,3,2)
ax.plot(X,tanh(X),label='tanh')
ax.plot(X,(1-tanh(X)**2),label='derivative')
ax.set_title("tanh")

ax = fig.add_subplot(1,3,3)
ax.plot(X,relu(X),label='relu')
ax.plot(X,X>0,label='derivative')
ax.set_title("tanh")

plt.legend()
plt.show()
