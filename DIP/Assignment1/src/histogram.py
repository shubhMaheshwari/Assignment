import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image

def bucket_sort(im_list):
	buckets = np.zeros((256))
	for x in im_list:
		buckets[x] += 1
	return buckets

def histogram(im,new_dim=400, verbose=True):

	try:
		im = im.resize((new_dim,new_dim), Image.ANTIALIAS)
	except:
		pass

	im = np.array(im)
	try:
		w,h,ch = im.shape
	except ValueError:
		w,h = im.shape
		ch = 1
		im = im.reshape((w,h,1))

	hist_list = []
	plot_colors = ['red' , 'green', 'blue']
	for c in range(ch):
		y = bucket_sort(np.reshape(im[:,:,c],(w*h,1)) )	
		y = y/(w*h)
		hist_list.append(y)
		if verbose:
			plt.plot(np.arange(0,256,1), y , color=plot_colors[c])
			plt.fill_between(np.arange(0,256,1),y,0, alpha=0.3 , color=plot_colors[c])


	if verbose:
		plt.show()

	return np.array(hist_list)


if __name__ == "__main__":

	# Get the input
	path = sys.argv[1]
	im = Image.open(path)
	# Run the function
	histogram(im,new_dim=16)
	histogram(im,new_dim=32)
	histogram(im,new_dim=64)
	histogram(im,new_dim=128)
	histogram(im,new_dim=256)