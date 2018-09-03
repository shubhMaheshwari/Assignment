import numpy as np 
import matplotlib.pyplot as plt

# Generate Data with 2 classes classfied as -1 and 1
X = np.zeros((1000,2))
X[0:500] = np.random.normal([-4,0],3,(500,2)) 
X[500:1000] = np.random.normal([4,0],3,(500,2)) 
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

# Training
classes = [
	{
	'mean': np.mean(train_x[train_y == 0,:],axis=0),
	'var': np.std(train_x[train_y == 0,:]),
	'prob': 0.5
	},
	{
	'mean': np.mean(train_x[train_y == 1,:],axis=0),
	'var': np.std(train_x[train_y == 1,:]),
	'prob': 0.5
	}
]

# get probablity of being in each class
def get_predictions(x,classes):
		
	x = np.array(x)
	# Store probablity of each attribute for each class 
	p_x_w_list = []
	for clas in classes:
		# Calculate gaussian
		exponent = np.exp(-0.5*((x-clas['mean'])/clas['var'])**2)
		p_x = (1 / (np.sqrt(2*np.pi) * clas['var'])) * exponent
		
		# We are simply multipying for each attribute
		p_x = np.prod(p_x,axis=1)
		# Use the bayes laws
		p_x_w = p_x*clas['prob']
		p_x_w_list.append(p_x_w)
	p_x_w_list = np.array(p_x_w_list)
	# Get the class with the max problality 
	pred = np.argmax(p_x_w_list,axis=0)

	return pred

train_y_pred = get_predictions(train_x,classes)
test_y_pred = get_predictions(test_x,classes)


# Get accuracy
def accuracy(y,y_pred):
	n = np.shape(y)[0]
	acc = np.sum(np.abs(y - y_pred))/n 
	acc = (1 - acc)*100
	return acc

print("Training Accuracy:",accuracy(train_y,train_y_pred))
print("Testing Accuracy:",accuracy(test_y,test_y_pred))


plt.scatter(X[Y ==0,0], X[Y ==0,1], color='red')
plt.scatter(X[Y ==1,0], X[Y ==1,1], color='blue')
plt.title("Data\nTrain Acc:{}\nTest Acc:{}".format(accuracy(train_y,train_y_pred), accuracy(test_y,test_y_pred)))
plt.show()