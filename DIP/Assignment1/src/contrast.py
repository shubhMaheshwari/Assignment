import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image
from histogram import histogram


if __name__ == "__main__":

	# Get the input
	path = sys.argv[1]
	im = Image.open(path).convert('L')
	im = np.array(im)
	im1 = im[:,0:im.shape[1]//2]
	im2 = im[:,im.shape[1]//2+1:im.shape[1]]
	# Run the function
	hist1 = histogram(im1,verbose=False)[0]
	hist2 = histogram(im2,verbose=False)[0]

	fig = plt.figure()
	ax11 = fig.add_subplot(2,2,1)
	ax12 = fig.add_subplot(2,2,2)
	ax21 = fig.add_subplot(2,2,3)
	ax22 = fig.add_subplot(2,2,4)

	ax11.plot(np.arange(0,256,1),hist1)
	ax11.set_title("Histogram Low Contrast")
	ax12.imshow(im1, cmap='gray')
	ax12.set_title("Low Contrast")
	ax12.axis('off')

	ax21.plot(np.arange(0,256,1),hist2)
	ax21.set_title("Histogram High Contrast")
	ax22.imshow(im2, cmap='gray')
	ax22.set_title("High Contrast")
	ax22.axis('off')

	plt.show()