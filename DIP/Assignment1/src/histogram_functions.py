import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image
from histogram import histogram


def local_histogram_equalization(im, k=5, verbose=True):
	new_im = np.zeros_like(im)	

	try:
		h,w,ch = im.shape
	except ValueError:
		h,w = im.shape
		ch =1

	im = np.pad(im,k//2,'constant',constant_values=0)	
	for j in range(k//2,h-k//2):
		for i in range(k//2,w-k//2):
			new_im[j,i] = histogram_equalization(im[j-k//2:j+k//2 , i-k//2:i+k//2],verbose=False)[k//2,k//2]

	if verbose:
		fig = plt.figure()
		ax11 = fig.add_subplot(2,3,1)
		ax12 = fig.add_subplot(2,3,2)
		ax13 = fig.add_subplot(2,3,3)
		ax21 = fig.add_subplot(2,3,4)
		ax22 = fig.add_subplot(2,3,5)
		ax23 = fig.add_subplot(2,3,6)

		hist = histogram(im,verbose=False)[0]
		cum_hist = np.cumsum(hist)

		ax11.plot(np.arange(0,256,1),hist)
		ax11.set_title("Prob Distribuition")
		ax12.plot(np.arange(0,256,1),cum_hist)
		ax12.set_title("Cumalative Prob Distribuition")
		ax13.imshow(im, cmap='gray')
		ax13.set_title("After")
		ax13.axis('off')

		new_hist = histogram(new_im,verbose=False)[0]
		new_cum_hist = np.cumsum(new_hist)

		ax21.plot(np.arange(0,256,1),new_hist)
		ax21.set_title("New Prob Distribuition")
		ax22.plot(np.arange(0,256,1),new_cum_hist)
		ax22.set_title("New CDF")
		ax23.imshow(new_im, cmap='gray')
		ax23.set_title("After")
		ax23.axis('off')

		plt.show()

	return new_im


def histogram_equalization(im,verbose=True):

	new_im = np.zeros_like(im)
	try:
		h,w,ch = im.shape
	except ValueError:
		h,w = im.shape
		ch =1

	hist = histogram(im,verbose=False)[0]
	cum_hist = np.cumsum(hist)
	for j in range(h):
		for i in range(w):
			new_im[j,i] = cum_hist[im[j,i]]*255 

	if verbose:
		fig = plt.figure()
		ax11 = fig.add_subplot(2,3,1)
		ax12 = fig.add_subplot(2,3,2)
		ax13 = fig.add_subplot(2,3,3)
		ax21 = fig.add_subplot(2,3,4)
		ax22 = fig.add_subplot(2,3,5)
		ax23 = fig.add_subplot(2,3,6)

		ax11.plot(np.arange(0,256,1),hist)
		ax11.set_title("Prob Distribuition")
		ax12.plot(np.arange(0,256,1),cum_hist)
		ax12.set_title("Cumalative Prob Distribuition")
		ax13.imshow(im, cmap='gray')
		ax13.set_title("After")
		ax13.axis('off')

		new_hist = histogram(new_im,verbose=False)[0]
		new_cum_hist = np.cumsum(new_hist)

		ax21.plot(np.arange(0,256,1),new_hist)
		ax21.set_title("New Prob Distribuition")
		ax22.plot(np.arange(0,256,1),new_cum_hist)
		ax22.set_title("New CDF")
		ax23.imshow(new_im, cmap='gray')
		ax23.set_title("After")
		ax23.axis('off')

		plt.show()

	return new_im


def histogram_matching(im1,im2, verbose=True):


	try:
		h,w,ch = im1.shape
	except ValueError:
		h,w = im1.shape
		ch =1

	hist1 = histogram(im1,verbose=False)[0]
	cum_hist1 = np.cumsum(hist1)
	hist2 = histogram(im2,verbose=False)[0]
	cum_hist2 = np.cumsum(hist2)

	

	if verbose:
		fig = plt.figure()
		ax11 = fig.add_subplot(3,2,1)
		ax12 = fig.add_subplot(3,2,2)
		ax21 = fig.add_subplot(3,2,3)
		ax22 = fig.add_subplot(3,2,4)
		ax31 = fig.add_subplot(3,2,5)
		ax32 = fig.add_subplot(3,2,6)

		ax11.plot(np.arange(0,256,1),cum_hist1)
		ax11.set_title("Original CDF")
		ax12.imshow(im1, cmap='gray')
		ax12.set_title("Original")
		ax12.axis('off')

		ax21.plot(np.arange(0,256,1),cum_hist2)
		ax21.set_title("Desired CDF")
		ax22.imshow(im2, cmap='gray')
		ax22.set_title("Second Image")
		ax22.axis('off')


		new_hist = histogram(new_im,verbose=False)[0]
		new_cum_hist = np.cumsum(new_hist)
	
		ax31.plot(np.arange(0,256,1),new_cum_hist)
		ax31.set_title("New CDF")
		ax32.imshow(new_im, cmap='gray')
		ax32.set_title("New Image")
		ax32.axis('off')

			

		plt.show()

	return new_im



if __name__ == "__main__":

	# Get the input
	path = sys.argv[1]
	im = Image.open(path).convert('L')
	# Run the function
	im = im.resize((400,400), Image.ANTIALIAS)
	im = np.array(im)

	# histogram_equalization(im)
	# local_histogram_equalization(im,k=3)
	im2 = Image.open(sys.argv[2])
	im2 = im2.resize((400,400), Image.ANTIALIAS)
	im2 = np.array(im2)
	histogram_matching(im,im2)