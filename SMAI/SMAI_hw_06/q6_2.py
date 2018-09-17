import numpy as np
import matplotlib.pyplot as plt

feat_prob = np.array([0.6,0.4])
# Class 1
u1 = np.array([1.0])
E1 = np.array([[2]])
X1 = np.random.multivariate_normal(u1, E1 , size=(500,))
Y1 = np.ones(500)

# Class 2
u2 = np.array([3.0])
E2 = np.array([[1]])
X2 = np.random.multivariate_normal(u2, E2, size=(500,))
Y2 = np.zeros(500)

X = np.zeros([1000,1])
X[0:500,:] = X1
X[500:,:] = X2
Y = np.zeros([1000,])
Y[0:500] = Y1
Y[500:] = Y2

E1_inv = np.linalg.inv(E1)
W1 = -0.5*E1_inv
w1 = E1_inv.dot(u1)
b1 = -0.5*(u1.T.dot(E1_inv)).dot(u1) -0.5*np.linalg.det(E1) + np.log(feat_prob[0])


E2_inv = np.linalg.inv(E2)
W2 = -0.5*E2_inv
w2 = E2_inv.dot(u2)
b2 = -0.5*(u2.T.dot(E2_inv)).dot(u2) -0.5*np.linalg.det(E2) + np.log(feat_prob[1])


g1 = X.dot(W1)*X + X*w1 + b1 
g2 = X.dot(W2)*X + X*w2 + b2 
g = (g1-g2)
ge = (abs(g1-g2)<0.2)*1



fig = plt.figure()
ax1 = fig.add_subplot(121)
ax1.scatter(X, g1, c='r',label='class1')
ax1.scatter(X, g2, c='b',label='class2')
ax1.set_title('ground_truth')
plt.legend()


ax2 = fig.add_subplot(122)
X_ind_g2 = g<0
ax2.scatter(X[X_ind_g2[:,0]], g1[X_ind_g2[:,0]],label='class1')
X_ind_g1 = g>0
ax2.scatter(X[X_ind_g1[:,0]], g2[X_ind_g1[:,0]],label='class2')
ax2.set_title('Classification')

plt.legend()
plt.show()

