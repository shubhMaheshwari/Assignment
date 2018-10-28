import numpy as np

# Samples
N = 100
# Layers 
D = 3
H = 2
O = 1

# Input and output
X = np.random.random((N,D))
Y = np.random.random((N,O))

# Parameters
W =np.random.random((D,O))

# Sigmoid Activation
def activation(X):
	return 1./(1.-np.exp(X))

def activation_derivate(X):
	
	# Derivative of sigmoid => sigmoid(X)*(1-sigmoid(X)) 
	sX = activation(X)
	return sX*(1-sX)

# Forward Pass

def backpass_pass(X,Y,W):
	lr = 1e-3
	# Back pass requires forward pass
	# First Layer
	Z = X.dot(W) 
	A = activation(Z)

	Y_pred = A
	# Loss
	Loss = 0.5*np.sum((Y-Y_pred)**2)

	# Loss derivative
	dA = (Y-Y_pred)
	dA = activation_derivate(dA)
	dW = X.T.dot(dA)

	W -= lr*dW

	return Loss

for i  in range(1,100):
	print("Loss	:",backpass_pass(X,Y,W))
