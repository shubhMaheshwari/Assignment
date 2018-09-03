import torch
import torch.nn.functional as F 
import numpy as np 
import matplotlib.pyplot as plt

lr_list = [0.001,0.1,0.4]


while True:
	# INPUT
	X = np.random.uniform(-1,1,(10,2))
	# OUTPUT
	W_final = np.random.random((2,))
	# W_final = np.array([1,1])
	Y = X.dot(W_final)


	for lr in lr_list:

		# INITIAL VALUES
		W = np.array([-1,1],dtype='float64')
		loss_hist = []


		for i in range(100):
			# Forward Prop
			Y_Pred = X.dot(W) 
			dL = (Y - Y_Pred)
			# LOSS
			loss = np.sum(dL**2)

			# Back prop
			dW = X.T.dot(dL)
			W += lr*dW

			# For better under visualization cap the loss to 50
			if loss > 50:
				loss = loss_hist[-1]
			loss_hist.append(loss)

		plt.plot(loss_hist,label=str(lr))


	plt.legend()
	plt.show()


