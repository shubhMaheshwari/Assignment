import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image

def BitQuantizeImage(fg,k):

	# Get the dimensions of background image 
	im = np.array(fg)
	im = im/256
	im = np.floor(im*(2**k)).astype('uint8')


	print(im[im >1])


	return Image.fromarray(im)
if __name__ == "__main__":

	# Get the input
	fgpath = sys.argv[1]
	k = int(sys.argv[2])
	fg = Image.open(fgpath)
	# Run the function

	im = BitQuantizeImage(fg,k)
	plt.imshow(im)
	plt.axis('off')
	plt.show()