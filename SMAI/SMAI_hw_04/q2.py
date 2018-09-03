import numpy as np 

# Input
X = np.array([
	[0,-2,1],
	[-7,0,1],
	[5,-4,1],
	[11,-4,1],
	[12,-5,1],
	[2,-8,1]])

# Output
Y = np.array([0,1,1,0,0,0])
n = Y.shape[0]
# Given Weights
W1 = np.array([-11,3,2])
W2 = np.array([11,-3,2])
W3 = np.array([2,-1,0])

# Predictions
Y_pred1 = np.sign(X.dot(W1))
Y_pred2 = np.sign(X.dot(W2))
Y_pred3 = np.sign(X.dot(W3))

Y_pred1[Y_pred1 == -1] = 0
Y_pred2[Y_pred2 == -1] = 0
Y_pred3[Y_pred3 == -1] = 0

acc1 = (n - np.sum(np.abs(Y - Y_pred1)))/n
acc2 = (n - np.sum(np.abs(Y - Y_pred2)))/n
acc3 = (n - np.sum(np.abs(Y - Y_pred3)))/n

print("Y_pred1:",Y_pred1)
print("Y_pred2:",Y_pred2)
print("Y_pred3:",Y_pred3)
print("Accuracy of W1:{} Accuracy of W2:{} Accuracy of W3:{}".format(acc1,acc2,acc3))
