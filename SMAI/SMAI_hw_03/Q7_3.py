import numpy as np
import matplotlib.pyplot as plt

# INPUT
X = np.random.random((10,3))
X[:,0] = 1

# OUTPUT
W_final = np.random.random((3,1))
Y = X.dot(W_final)
 
Y = Y[:,0]

# INITIAL VALUES
W = np.array([-1,1,0],dtype='float64')

loss = 40
prev_loss = 0


def plot():
	X1 = X[ Y >= 0,:]
	X2 = X[ Y < 0,:]
	plt.scatter(X1[:,1],X1[:,2],color='red')
	plt.scatter(X2[:,1],X2[:,2],color='blue')

	x = np.linspace(-1,1, 15)
	y = -(x*W[1] + W[0])/(W[2] + 1e-10)
	plt.plot(x,y)

	plt.xlabel('x1')
	plt.xlabel('x2')
	plt.axis('equal')
	plt.show()



# Gradient Descent
lr = 0.01
cnt = 0
while True:
	# Forward Prop
	Y_Pred = X.dot(W) 
	dL = (Y - Y_Pred)
	# LOSS
	loss = np.sum(dL**2)
	if np.abs(loss - prev_loss) <  1e-6:
		break
	# Back prop
	dW = X.T.dot(dL)
	W += lr*dW
	if cnt % 100 == 0:
		print("Iteration:",cnt," Loss:",np.sum((Y - Y_Pred)**2))
		# print("W",W)
		# plot()
	cnt += 1  
	prev_loss = loss

# For a linear line it is not possible to converge on this dateset hence the 
# Function ends up oscilating


print("Iteration:",cnt," Loss:",np.sum(Y - np.sign(Y_Pred)))
plot()