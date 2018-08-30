import numpy as np
import matplotlib.pyplot as plt

# For question 1
# X = [[1,1,1] , [1,-1,-1], [1,2,2],[1,-2,-2], [1,-1,1], [1,1,-1]]
# Y = [-1,-1,1,-1,1,1]

# For question 2
# X = [[1,1,1] , [1,-1,-1], [1,2,2],[1,-2,-2], [1,-1,1], [1,1,-1]]
# Y = [1,-1,1,-1,1,1]

# INPUT
X = np.array(X,dtype='float64')
# OUTPUT
Y = np.array(Y,dtype='float64')
W = np.array([-1,1,0],dtype='float64')

loss = 6

# Gradient Descent
lr = 0.01
cnt = 0
while abs(loss) > 0:
	# Forward Prop
	Y_Pred = X.dot(W) 
	dL = (Y - np.sign(Y_Pred))
	# LOSS
	loss = np.sum(dL**2)

	# Back prop
	dW = X.T.dot(dL)
	W += lr*dW
	if cnt % 10 == 0:

		# print("Iteration:",cnt," Loss:",loss," Y_Pred:",Y_Pred)
		# print("W",W)


		X1 = X[ Y >= 0,:]
		X2 = X[ Y < 0,:]
		plt.scatter(X1[:,1],X1[:,2],color='red')
		plt.scatter(X2[:,1],X2[:,2],color='blue')

		x = np.linspace(-3,3, 15)
		y = -(x*W[1] + W[0])/(W[2] + 1e-10)

		plt.plot(x,y)
		plt.xlabel('x1')
		plt.xlabel('x2')
		plt.axis('equal')
		plt.title('Points missed:' + str(loss//4))
		plt.show()
		print("Repeated Loss:",np.sum((Y - Y_Pred)**2))
	cnt += 1  
			

# For a linear line it is not possible to converge on this dateset hence the 
# Function ends up oscilating



print("Iteration:",cnt," Loss:",loss," Y_Pred:",Y_Pred)
print("W",W)


X1 = X[ Y_Pred >= 0,:]
X2 = X[ Y_Pred < 0,:]
plt.scatter(X1[:,1],X1[:,2],color='red')
plt.scatter(X2[:,1],X2[:,2],color='blue')

x = np.linspace(-3,3, 15)
y = -(x*W[1] + W[0])/(W[2] + 1e-10)

plt.plot(x,y)
plt.xlabel('x1')
plt.xlabel('x2')
plt.axis('equal')
plt.show()