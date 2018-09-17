import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse

feat_prob = np.array([0.5,0.5])
# Class 1
u1 = np.array([0.0,0.0])
E1 = np.array([[1.5,1],[1,1.5]])
X1 = np.random.multivariate_normal(u1, E1 , size=(500,))
Y1 = np.ones(500)

# Class 2
u2 = np.array([0.0,0.0])
E2 = np.array([[5,1],[1,1.5]])
X2 = np.random.multivariate_normal(u2, E2, size=(500,))
Y2 = np.zeros(500)

X = np.zeros([1000,2])
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

g1 = (X.dot(W1).dot(X.T)).diagonal() + X.dot(w1) + b1 
g2 = (X.dot(W2).dot(X.T)).diagonal() + X.dot(w2) + b2 
g = (g1-g2)

# print(g1-g2)
fig = plt.figure()
ax1 = fig.add_subplot(121)
ax1.scatter(X2[:,0], X2[:,1], c='b', marker='o', label='class2')
ax1.scatter(X1[:,0], X1[:,1], c='r', marker='X', label='class1')
ax1.set_title('ground_truth')
plt.legend()

def plot_cov_ellipse(cov, pos, nstd=2, ax=None, **kwargs):
    def eigsorted(cov):
        vals, vecs = np.linalg.eigh(cov)
        order = vals.argsort()[::-1]
        return vals[order], vecs[:,order]

    if ax is None:
        ax = plt.gca()

    vals, vecs = eigsorted(cov)
    theta = np.degrees(np.arctan2(*vecs[:,0][::-1]))

    # Width and height are "full" widths, not radius
    width, height = 2 * nstd * np.sqrt(vals)
    ellip = Ellipse(xy=pos, width=width, height=height, angle=theta, **kwargs)

    ax.add_artist(ellip)
    return ellip

ax2 = fig.add_subplot(122)
X_ind_g2 = g<0
ax2.scatter(X[X_ind_g2,0], X[X_ind_g2,1],label='class1')
X_ind_g1 = g>0
# ax2.plot()
ax2.scatter(X[X_ind_g1,0], X[X_ind_g1,1],label='class2')
ax2.set_title('Classification')

plot_cov_ellipse(E1,u1, nstd=3, alpha=0.5, color='green')

plt.legend()
plt.show()
