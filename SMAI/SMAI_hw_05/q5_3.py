import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
# from matplotlib.animation import FuncAnimation

# INPUT
X = np.random.uniform(-1,1,(10,2))

# OUTPUT
W_final = np.random.random((2,))
# W_final = np.array([1,1])
Y = X.dot(W_final)

# INITIAL VALUES
W = np.array([-1,1],dtype='float64')
W_hist = []
loss = 40
prev_loss = 0
loss_hist = []

# Gradient Descent
lr = 0.01
cnt = 0

while True:
	# Forward Prop
	Y_Pred = X.dot(W) 
	dL = np.cos(Y - Y_Pred)
	# LOSS
	loss = np.sum(np.sin(Y - Y_Pred))

	# Back prop
	dW = X.T.dot(dL)
	W += lr*dW

	W_hist.append([W[0],W[1]])
	loss_hist.append(loss)

	if np.abs(loss - prev_loss) <  1e-6:
		break

	# Similiarly for 2nd order derivative back prop

	if cnt % 100 == 0:
		print("Iteration:",cnt," Loss:",np.sum((Y - Y_Pred)**2))
		# plot()
		# print("W",W)
		# plot()
	cnt += 1  
	prev_loss = loss

print("Iteration:",cnt," Loss:",np.sum((Y - Y_Pred)**2))



fig2 = plt.figure()

ax1 = fig2.add_subplot(111)
ax1.plot(np.arange(len(loss_hist)),loss_hist,label='First order loss')

ax1.set_xlabel('Iteration')
ax1.set_ylabel('Loss')
ax1.set_title('Loss Convergence(orange 2nd order)	')



fig3 = plt.figure()

ax3 = fig3.add_subplot(111)
X1 = X[ Y >= 0,:]
X2 = X[ Y < 0,:]
ax3.scatter(X1[:,0],X1[:,1],color='red')
ax3.scatter(X2[:,0],X2[:,1],color='blue')

ax3.set_xlabel('x1')
ax3.set_ylabel('x2')
ax3.axis('equal')
ax3.set_title('Data Points')



W_hist = np.array(W_hist)

W1,W2 = np.meshgrid(np.linspace(-1,1,20),np.linspace(-1,1,20))
y_pred = X[:,0]*W1.reshape((20,20,1)) + X[:,1]*W2.reshape((20,20,1)) 
y = Y
error = np.sum(np.sin(y_pred - y),axis=2)
# For different cases of W1 and W2 get the error values
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(W_hist[:,0],W_hist[:,1],loss_hist,color='black', marker='x', label='First order derivative')
ax.plot_surface(W1, W2,error, cmap='terrain', alpha=0.9)
ax.set_xlabel('W1')
ax.set_ylabel('W2')
ax.set_zlabel('Error func')
ax.set_title('Error Surface')
plt.show()

