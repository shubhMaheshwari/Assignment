import numpy as  np 
import matplotlib.pyplot as plt


X = np.random.random((1000,20))
y = np.random.randint(0,5,(1000,))
Y = np.zeros((1000,5))
Y[[np.arange(0,1000),y]] = 1
W_mse = W_cross = np.random.random((20,5))


def softmax(x):
	x = np.exp(x - np.max(x))
	return x/np.sum(x,axis=1)[:,np.newaxis]

def accuracy(pred):
	# print(np.argmax(pred,axis=1) == y)
	return np.sum(np.argmax(pred,axis=1) == y)

lr = 1e-4
loss = 1000
previous_loss = 0
for i in range(1000):
	# Forward prop for mse
	Y_mse= X.dot(W_mse)

	# Forward prop from cross entropy
	Y_cross = softmax(X.dot(W_cross))
	# Y_cross = Y_mse

	# MSE loss
	L_mse = np.mean((Y - Y_mse)**2)

	# Cross entropy loss
	L_cross = -np.mean(Y*np.log(Y_cross))

	print(L_mse,L_cross)
	if np.abs(L_mse + L_cross - previous_loss) < 1e-3:
		break
	# Backprop For mse 
	dW = X.T.dot(Y - Y_mse)
	W_mse += lr*dW

	# Back prop for cross entropy
	dL = Y_cross
	dL[[np.arange(0,1000),y]] -= 1
	dW = X.T.dot(dL)

	W_cross -= lr*dW

	previous_loss = L_mse + L_cross

	print(accuracy(Y_cross),accuracy(Y_mse))

