import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D


# Input => 1000 2d samples between 0,1
X = np.random.uniform(-1,1,(1000,2))

# Weights to be predicted by our model
W_final = np.random.uniform(-1,1,(2,))

# Non linearity function (sigmoid)
def sigmoid(x):
	return 1/(1 + np.exp(-x))

# Output that needs to be predicted
Y = sigmoid(X.dot(W_final))
Y[ Y > 0.5 ] = 1
Y[ Y <= 0.5 ] = -1

# Plotting data
fig = plt.figure()

W1,W2 = np.meshgrid(np.linspace(-1,1,20),np.linspace(-1,1,20))


# Case 1
# Let us study loss = y - g(W.dot(X))^2 by plot the error surface on the data
y_pred = X[:,0]*W1.reshape((20,20,1)) + X[:,1]*W2.reshape((20,20,1)) 
y_pred = sigmoid(y_pred)

y_pred[ y_pred > 0.5 ] = 1
y_pred[ y_pred <= 0.5 ] = -1

y = Y
error_non_convex = np.mean((y - y_pred)**2,axis=2)
ax1 = fig.add_subplot(121, projection='3d')
ax1.plot_surface(W1,  W2,error_non_convex, cmap='terrain', alpha=0.9)
ax1.set_xlabel('W1')
ax1.set_ylabel('W2')
ax1.set_zlabel('Error func')
ax1.set_title('Non-convex Error Surface')

# Case 2
# Let us study loss = (y - W.dot(X))^2 by plot the error surface on the data
y_pred = X[:,0]*W1.reshape((20,20,1)) + X[:,1]*W2.reshape((20,20,1)) 
y = Y
error_convex = np.mean((y - y_pred)**2,axis=2)
ax2 = fig.add_subplot(122, projection='3d')
ax2.plot_surface(W1, W2,error_convex, cmap='terrain', alpha=0.9)
ax2.set_xlabel('W1')
ax2.set_ylabel('W2')
ax2.set_zlabel('Error func')
ax2.set_title('Convex Error Surface')



plt.show()
