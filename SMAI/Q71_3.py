import numpy as np
import matplotlib.pyplot as plt

# For question 3
X = np.random.random((20,2))
Y = np.random.random((20,))
Y[ Y > 0.5] = 1
Y[ Y <= 0.5] = -1


# HIDDEN LAYER
W1 = np.random.random((2,3))
B1 = np.random.random((3,))
# OUTPUT LAYER
W2 = np.random.random((3,1))
B2 = np.random.random((1))

prev_loss = 0.0
loss = 36

# Learning
lr = 1e-2
# Helper function
def relu(x):

	y = np.zeros_like(x)
	y[x >0] = x[x>0]
	return y
def plot():
	X1 = X[ Y >= 0,:]
	X2 = X[ Y < 0,:]
	plt.scatter(X1[:,0],X1[:,1],color='red')
	plt.scatter(X2[:,0],X2[:,1],color='blue')

	plt.xlabel('x1')
	plt.xlabel('x2')
	plt.axis('equal')
	plt.show()
	print("Repeated Loss:",np.sum((Y - Y_Pred)**2))

# Gradient Descent
cnt = 0
while np.abs(loss - prev_loss) > 1e-5:
	# Forward Prop
	Z = X.dot(W1) + B1
	A = relu(Z)
	Y_Pred = A.dot(W2) + B2

	dL = (Y.reshape((20,1)) - Y_Pred)/6
	# LOSS
	loss = np.sum(dL**2)/6

	# Back prop
	B2 += lr*np.sum(dL)
	W2 += lr*A.T.dot(dL)	

	dA = dL.dot(W2.T)

	dZ = np.zeros_like(dA)
	dZ[A > 0] = dA[A>0]
	
	B1 += lr*np.sum(dZ,axis=0)
	W1 += lr*X.T.dot(dZ)
	
	if cnt % 100 == 0:
		plot()

	cnt += 1  

plot()	
print("Iteration:",cnt," Loss:",loss)
print("W1",W1)
print("B1",B1)
print("W2",W2)
print("B2",B2)