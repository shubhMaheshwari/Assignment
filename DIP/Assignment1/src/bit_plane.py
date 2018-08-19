import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image

def BitQuantizeImage(fg):

	# Get the dimensions of background image 
	im = np.array(fg)

	fig = plt.figure()
	k = 128
	while k > 0:
		plt.imshow(255*(im//k))
		plt.axis('off')
		plt.show()
		im = im - k*(im//k)
		k = k//2
	

if __name__ == "__main__":

	# Get the input
	fgpath = sys.argv[1]
	fg = Image.open(fgpath)
	# Run the function

	BitQuantizeImage(fg)
	