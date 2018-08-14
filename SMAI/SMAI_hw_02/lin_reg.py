import matplotlib.pyplot as plt
import numpy as np

x = np.array([0,1,2,3,4])
y = np.array([1,2,3,4,3])

# Append one to each x
x = np.vstack((x,np.ones((1,x.shape[0]))))
# Parameters to optimize
w = np.random.random((1,2))

prev_loss = 0
lr = 1e-3
while True:
	L = np.sum( (y - w.dot(x))**2)
	dw = (x.dot((w.dot(x) - y).T)).T
	w -= lr*dw

	if np.abs(L - prev_loss) < 1e-5:
		break
	else:
		print("Loss:",L)
		prev_loss = L

print("a & b:",w)

plt.plot(x[0,:],w.dot(x)[0])
plt.scatter(x[0,:],y)
plt.title("Linear Regression")
plt.xlabel("x")
plt.ylabel("y")
plt.show()
