import numpy as np 
import matplotlib.pyplot as plt 
import math

# Uniform variable 
U = np.random.random(10000)

# Normal distribuition : https://www.johndcook.com/blog/normal_cdf_inverse/
def normal_dist_inv(p):
	if p < 0.5:
		# F^-1(p) = - G^-1(p)
		return -rational_approximation( np.sqrt(-2.0*np.log(p)))
	else:
		return rational_approximation( np.sqrt(-2.0*np.log(1.0 - p)))

def exp_dist_inv(p):
	return -np.log(1 - p)

def rational_approximation(t):
 
	# Abramowitz and Stegun formula 26.2.23.
	# The absolute value of the error should be less than 4.5 e-4.
	c = [2.515517, 0.802853, 0.010328]
	d = [1.432788, 0.189269, 0.001308]
	numerator = (c[2]*t + c[1])*t + c[0]
	denominator = ((d[2]*t + d[1])*t + d[0])*t + 1.0
	return t - numerator / denominator

def normal_dist(p):
	return np.exp(-(p**2)/8)/2*np.sqrt(2*np.pi)
def main():
	print(np.linspace(-10,10,20))
	x = normal_dist(np.linspace(-10,10,20))*3000
	# x = [normal_dist(p)*3500 for p in np.linspace(-10,10,20)]
	print(x)
	y = np.zeros_like(U)
	for i in range(len(U)):
		y[i] = normal_dist_inv(U[i])

	f1 = plt.figure()
	ax1  = f1.add_subplot(311)
	ax1.set_title("Normal Density")
	ax1.plot(np.linspace(-10,10,20),x)
	ax1.hist(y, bins=range(-15,15,1))

	u = 1.5*np.exp(-1.5*np.linspace(-5,5,20))
	v = np.zeros_like(U)
	for i in range(len(U)):
		v[i] = exp_dist_inv(U[i])

	ax1  = f1.add_subplot(312)
	ax1.set_title("Exponential Density")
	ax1.plot(u*2.4)
	ax1.hist(v, bins=range(-1,15,1))

	y = np.zeros_like(U)
	for i in range(len(U)):
		y[i] = normal_dist_inv(U[i])

	ax1 = f1.add_subplot(313)
	ax1.set_title("Rayleigh Density")
	ax1.plot(np.linspace(-10,10,20),x)	
	ax1.hist(y, bins=range(-15,15,1))
	# f3 = plt.figure()
	# ax3  = f3.add_subplot(111)
	# ax3.plot(u)
	
	# f4 = plt.figure()
	# ax4  = f4.add_subplot(111)

	plt.show()

if __name__ == "__main__":
	main()



