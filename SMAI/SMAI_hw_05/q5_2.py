import numpy as np 
import matplotlib.pyplot as plt 

# Let us do logistic regression multiple times and 
lr = 0.1
x = -2
y = 0
X_hist = []
Y_hist = []
loss_hist = []
for j in range(50):
	print(x)
	# forward prop
	Y_pred = x**2

	loss = np.abs(y - x)

	# Backprop
	dx = -2*x

	X_hist.append(x)
	Y_hist.append(Y_pred)
	loss_hist.append(loss)

	x += lr*dx

plt.plot(loss_hist)
plt.ylabel('Error')
plt.xlabel('Time')
plt.show()
plt.plot(loss_hist)
plt.xlabel('Iter')
plt.ylabel('Loss/Error')
plt.show()
