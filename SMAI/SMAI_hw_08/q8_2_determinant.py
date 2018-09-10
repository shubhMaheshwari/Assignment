import numpy as np 
import matplotlib.pyplot as plt

feat_prob = np.array([0.6,0.4])
X = np.zeros((1000,1))
X[0:500] = np.random.normal(-1,2,(500,1)) 
X[500:1000] = np.random.normal(2,3,(500,1)) 
Y = np.zeros((1000,))
Y[0:500] = 0
Y[500:1000] = 1

# Shuffle data
shuffle = np.random.permutation(1000)

X = X[shuffle]
Y = Y[shuffle]

# Train data 
train_x  = X[0:700,:]
train_y  = Y[0:700]
# Test data
test_x  = X[700:1000,:]
test_y  = Y[700:1000]

# Let us define 2 gi(x) = >g1(x) and g2(x) for each get wi, and bi
W = []
b = []

for i in range(num_features):
	W.append(np.linalg.inv(cov_mat[i]).dot(feat_mean[i,:]))
	b.append(np.log(feat_prob[i]) + feat_mean[i].dot(np.linalg.inv(cov_mat[i])).dot(feat_mean[i]))	

print(W,b)

# As we only have 2 features g(x) = g1(x) - g2(x)
g1 = X.dot(W[0]) + b[0]
g2 = X.dot(W[1]) + b[1]

# 	Calculate error 
error = np.sum(np.abs((Y - (g2 > g1))))/1000

print("Error:",error)

plt.scatter(X[Y ==0,0], X[Y ==0,1], color='red',label='Class 1')
plt.scatter(X[Y ==1,0], X[Y ==1,1], color='blue', label='Class 2')
plt.title("Bayesian classifier\nError.{}".format(error))
plt.xlabel('W1')
plt.ylabel('W2')
# Now let us plot the classifier as a linear plot
x1 = np.linspace(-3,3,20)
x2 = -(x1*(W[1][0] - W[0][0]) + (b[1] - b[0]))/(W[1][1] - W[0][1] + 1e-7)

plt.plot(x1, x2, color='black')
plt.legend()
plt.show()