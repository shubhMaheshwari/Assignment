import numpy as np 
import matplotlib.pyplot as plt

X = np.array([
	[1,2],
	[2,3],
	[3,4],
	[-1,0],
	[-2,-1],
	[-3,-2]
	])

Y = np.array([1,1,1,-1,-1,-1])

# Covariance matrix 
cov_mat = np.cov((X-np.mean(X)).T)
# Eigen Vectors and values 
eig_val_cov, eig_vec_cov = np.linalg.eig(cov_mat)

new_x = X.dot(eig_vec_cov[1,:].T)

# Simple classification using a linear classifier would be good enough 


fig = plt.figure()
ax1 = fig.add_subplot(121)
ax1.scatter(X[0:3,0],X[0:3,1],c='red')
ax1.scatter(X[3:6,0],X[3:6,1],c='blue')
ax1.set_title("Original Plot")
ax1.set_xlabel('x1')
ax1.set_xlabel('x2')

ax2 = fig.add_subplot(122)
ax2.scatter(new_x[0:3],np.zeros((3,)),c='red',label='class1')
ax2.scatter(new_x[3:6],np.zeros((3,)),c='blue',label='class2')
ax2.plot(np.zeros((10,)),np.linspace(-1,1,10),label='classification line')

ax2.set_title("PCA to 1D")
ax2.set_xlabel('new x1')
plt.legend()
plt.show()



