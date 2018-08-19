
# Creating a function dm(im,k) to show the k dominant colors in an image im.
# Uses of this function: Display the dominant colors in an image

import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans
import sys
from PIL import Image
	
	
def KmeansClustering(im,k):

	im = im.resize((400,400),Image.ANTIALIAS)
	im = np.array(im)
	h,w = 400,400
	try:
		ch = np.shape(im)[2]
	except IndexError:
		ch = 1
	# centeroids  = np.random.randint(())
	im = im.reshape((w*h,ch))
	kmeans = KMeans(n_clusters=k)
	kmeans.fit(im)


	return kmeans.cluster_centers_.astype('uint8')

def domColors(im,k):
	# Find the least square distance 

	colors = KmeansClustering(im,k)
	im = np.array(im)

	try:
		h,w,c = im.shape
	except IndexError:
		h,w = im.shape


	ch = h//10
	cw = w//k
	
	new_img = np.empty((h+ch,w,3))
	new_img[0:h , 0:w, :] = im
	
	for i,color in enumerate(colors):

		new_img[h:h+ch,cw*i:cw*(i+1),:] = color[:]
		# print(new_img[h:h+200,cw*i:cw*(i+1),:],color,w+cw*i,w+cw*(i+1))
	new_img = new_img.astype('uint8')
	plt.imshow(new_img)
	plt.axis('off')
	plt.title("Dominant Colors in the image")
	plt.show()

	return colors



if __name__ == "__main__":

	# Get the input
	path = sys.argv[1]
	k = int(sys.argv[2])
	im = Image.open(path)

	# Run the function
	domColors(im,k)
