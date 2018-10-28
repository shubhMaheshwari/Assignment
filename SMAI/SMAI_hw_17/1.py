

import numpy as np

# Samples
N = 100
# Layers 
D = 3
H1 = 5
H2 = 5
O = 2

# Input and output
X = np.random.random((N,D))
Y = np.random.random((N,O))

# Parameters
W1 = np.random.random((D,H1))
W2 = np.random.random((H1,H2))
W3 = np.random.random((H2,O))

b1 = np.random.random((H1,))
b2 = np.random.random((H2,))
b3 = np.random.random((O,))

# Sigmoid Activation
def activation(X):
	return 1./(1.-np.exp(X))

# Forward Pass
def forward_pass(X):
	# First Layer
	Z1 = X.dot(W1) + b1
	A1 = activation(Z1)

	# Second Lauer
	Z2 = A1.dot(W2) + b2
	A2 = activation(Z2)

	# Output
	Z3 = A2.dot(W3) + b3
	A3 = activation(Z3)

	return A3

print("Y_pred:",forward_pass(X))
