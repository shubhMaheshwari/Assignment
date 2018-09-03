# Generate Data with 2 classes classfied as 0 and 1
import numpy as np 
import matplotlib.pyplot as plt

# Generate Data with 2 classes classfied as 0 and 1
X = np.random.random((1000,2))

# Mean, Covaraince Matrix, Feature Probablity
num_features = 2
feat_mean = np.array([[-3,-3], [2,5]])
cov_mat = np.array([ 
	[[2,0],[0,2]],
	[[2,0],[0,2]]
	])
feat_prob = np.array([0.5,0.5])
print(feat_mean[0].shape,cov_mat[0].shape)

X[0:500] = np.random.multivariate_normal(feat_mean[0,:],cov_mat[0],(500,)) 
X[500:1000] = np.random.multivariate_normal(feat_mean[1,:],cov_mat[1],(500,)) 
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


# As we only have 2 features g(x) = g1(x) - g2(x)
g1 = X.dot(W[0]) + b[0]
g2 = X.dot(W[1]) + b[1]

# 	Calculate error 
bayesian_error = np.sum(np.abs((Y - (g2 > g1))))/1000

# Our non linearity
def sigmoid(x):
	return 1/(1 + np.exp(-x))

# Logistic regression
def train_logistic_regression(train_x,train_y):
	loss = 1e7
	prev_loss = 0
	loss_hist = []
	n,feat = train_x.shape
	W = np.random.random((feat,))
	lr = 1e-3

	while True:
		# Forward prop
		y_pred = sigmoid(train_x.dot(W))
		loss = np.mean(train_y*np.log(y_pred) - (1-train_y)*np.log(1 - y_pred)) 

		loss_hist.append(loss)

		if np.abs(loss - prev_loss) < 1e-5:
			break

		# Backprop
		dL = train_y - y_pred[:]
		# dW for weights
		dW = train_x.T.dot(dL)
		W += lr*dW 

		prev_loss = loss
	return W,loss_hist


# Get accuracy for logistic regressian on the data
def accuracy(y,y_pred):
	n = np.shape(y)[0]
	acc = np.mean(np.abs(y - y_pred)) 
	acc = (1 - acc)*100
	return acc

W_no_bias,loss_hist_no_bias = train_logistic_regression(train_x,train_y)
train_y_pred_no_bias = train_x.dot(W_no_bias)
train_x = np.hstack((np.ones((700,1)),train_x))	 
W_bias,loss_hist_bias = train_logistic_regression(train_x,train_y)
train_y_pred_bias = train_x.dot(W_bias)

plt.scatter(X[Y ==0,0], X[Y ==0,1], color='red',label='Class 1')
plt.scatter(X[Y ==1,0], X[Y ==1,1], color='blue', label='Class 2')
plt.xlabel('W1')
plt.ylabel('W2')
# Now let us plot the classifier as a linear plot
x1 = np.linspace(-3,3,20)
x2bayesian = -(x1*(W[1][0] - W[0][0]) + (b[1] - b[0]))/(W[1][1] - W[0][1] + 1e-7)
x2log_bias = -(x1*(W_bias[1]) + (W_bias[0]))/(W_bias[2] + 1e-7)
x2log_no_bias = -(x1*(W_no_bias[0]))/(W_no_bias[1] + 1e-7)
plt.plot(x1, x2bayesian, color='green', label='Bayesian Classifier')
plt.plot(x1, x2log_bias, color='pink', label='Logistic regressian with Bias')
plt.plot(x1, x2log_no_bias, color='black', label='Logistic regressian with No Bias')
plt.legend()
plt.show()

# Lets get new data
plt.scatter(X[Y ==0,0], X[Y ==0,1], color='yellow',label='Class 1')
plt.scatter(X[Y ==1,0], X[Y ==1,1], color='brown', label='Class 2')

X[0:500] = np.random.multivariate_normal(feat_mean[0,:],cov_mat[0],(500,)) 
X[500:1000] = np.random.multivariate_normal(feat_mean[1,:],cov_mat[1],(500,)) 
Y = np.zeros((1000,))
Y[0:500] = 0
Y[500:1000] = 1

# Shuffle data
shuffle = np.random.permutation(1000)

X = X[shuffle]
Y = Y[shuffle]

plt.scatter(X[Y ==0,0], X[Y ==0,1], color='red',label='New Class 1')
plt.scatter(X[Y ==1,0], X[Y ==1,1], color='blue', label='New Class 2')

plt.xlabel('W1')
plt.ylabel('W2')
# Now let us plot the classifier as a linear plot
x1 = np.linspace(-3,3,20)
x2bayesian = -(x1*(W[1][0] - W[0][0]) + (b[1] - b[0]))/(W[1][1] - W[0][1] + 1e-7)
x2log_bias = -(x1*(W_bias[1]) + (W_bias[0]))/(W_bias[2] + 1e-7)
x2log_no_bias = -(x1*(W_no_bias[0]))/(W_no_bias[1] + 1e-7)
plt.plot(x1, x2bayesian, color='green', label='Bayesian Classifier')
plt.plot(x1, x2log_bias, color='pink', label='Logistic regressian with Bias')
plt.plot(x1, x2log_no_bias, color='black', label='Logistic regressian with No Bias')
plt.legend()
plt.show()
