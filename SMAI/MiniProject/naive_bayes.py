import numpy as  np 
from PIL import Image
import os
import sys
opt = {
	'image_size': 64,
	'is_grayscale': True,
	'num_classes':8,
	'val_split': 0.7
}

# Load images
double_dict = {}
# Load Image using PIL for dataset
def load_image(path):
	im = Image.open(path).convert('L' if opt['is_grayscale'] else 'RGB')
	im = im.resize((opt['image_size'],opt['image_size']))
	im = np.array(im)
	im = im/256
	return im

# Load the full data from directory
def load_data(train_txt,test_txt):
	image_list = []
	y_list = []

	image_test = []

	with open(train_txt,'r') as f:
		for line in f.read().split('\n'):
			try:
				filename,y_name = line.split(' ')
				im = load_image(filename)
				image_list.append(im)
				if y_name in double_dict:
					y = double_dict[y_name]
				else:
					double_dict[y_name] = opt['num_classes']
					double_dict[opt['num_classes']] = y_name
					y = opt['num_classes']
					opt['num_classes'] += 1

				y_list.append(y)

			except Exception as e:
				# print(e)
				pass

	image_list = np.array(image_list)
	y_list = np.array(y_list)

	with open(test_txt,'r') as f:
		for line in f.read().split('\n'):
			try:
				im = load_image(line)
				image_test.append(im)
			except:
					pass

	image_test = np.array(image_test)

	return image_list,y_list,image_list

# Load the data
X,y,X_test = load_data(sys.argv[1],sys.argv[2])


N,W,H = X.shape[0:3]
C = 1 if opt['is_grayscale'] else X.shape[3]

# Flatten to apply PCA
X = X.reshape((N,np.prod(X.shape[1:])))
X_test = X.reshape((N,np.prod(X.shape[1:])))

def get_eigen_vectors(X):
	"""
		Get the eigen vectors of the covariance matrix
		also sort them by eigen value
	"""

	X_cov = np.cov(X.T)

	eig_val, eig_vec = np.linalg.eig(X_cov)
	

	sort_ind = np.argsort(eig_val)[::-1]
	eig_vec = eig_vec[sort_ind,:]
	return eig_vec


eig_vec = get_eigen_vectors(X)
def get_pca(X,eig_vec,k):
	"""
		Get PCA of K dimension using the top eigen vectors 
		by eigen value
		Also return the reconstructed data using just the top K vectors
	"""
	return np.real(X.dot(eig_vec[0:k,:].T)) , np.abs(X.dot(eig_vec[0:k,:].T.dot(eig_vec[0:k,:])))


# Get the PCA of K=32 to solve
K = 32
X,_ = get_pca(X,eig_vec,K)
X_test = X_test.reshape((X_test.shape[0],np.prod(X_test.shape[1:])))
eig_vec_test = get_eigen_vectors(X_test)
X_test,_ = get_pca(X_test,eig_vec_test,K)

# Get the covariance matrix 
X_cov =  np.cov(X.T)

# Check which case do these statisfy
X_sub_cov_list = []
for clas in range(opt['num_classes']):
	X_subclass = X[y==clas]
	X_sub_cov = np.cov(X.T)
	X_sub_cov_list.append(X_sub_cov) 

X_sub_cov_list = np.array(X_sub_cov_list)
	
np.all(X_sub_cov_list == X_sub_cov_list[0,:], axis = (1,2))    

# Hence They classify for class 2
# Get W,w,b => parameters for bayesian network for each class
print(X_sub_cov_list)
X_sub_cov_inv = np.linalg.inv(X_sub_cov_list[0])
w_class = []
b_class =[]
for clas in range(opt['num_classes']):

	X_subclass = X[y==clas]
	X_sub_mean = X_subclass.mean(axis=0)
	prob = (X_subclass.shape[0]/N)
	
	w = X_sub_cov_inv.dot(X_sub_mean)
	w_class.append(w)
	b = np.log(prob) \
		-0.5*X_sub_mean.T.dot(X_sub_cov_inv).dot(X_sub_mean)
	b_class.append(b)

w_class = np.array(w_class)
b_class = np.array(b_class)

# For each class get the g(t) or X.wi  + bi for each class
y_pred = X.dot(w_class.T) + b
y_pred = np.argmax(y_pred,axis=1)

# Accuracy

y_test = X_test.dot(W) + b
y_test = np.argmax(y_test,axis=1)
for y in y_test:
	print(double_dict[y])