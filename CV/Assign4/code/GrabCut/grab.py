import numpy as np
import cv2
from matplotlib import pyplot as plt
from grabcut import GrabCut

def minx(x1,x2,y1,y2):
	if x1<x2:
		return x1,y1
	else:
		return x2,y2

def checkout(x,p):
	if x>p:
		return p
	if x<0:
		return 0
	return x

def algo_grabcut(filename,foreground=[],background=[],pos1x=1,pos1y=1,pos2x=511,pos2y=511,times=5, algo=True):
	img = cv2.imread(filename)
	mask = np.zeros(img.shape[:2],np.uint8)	
	height = img.shape[:2][0]
	width = img.shape[:2][1]
	pos1x = checkout(pos1x,width-1)
	pos1y = checkout(pos1y,height-1)
	pos2x = checkout(pos2x,width-1)
	pos2y = checkout(pos2y,height-1)
	mask[min(pos1y,pos2y):max(pos1y,pos2y)+1,min(pos1x,pos2x):max(pos1x,pos2x)+1]=3
	for y1,x1,y2,x2 in foreground:
		x1 = checkout(x1,height-1)
		y1 = checkout(y1,width-1)
		x2 = checkout(x2,height-1)
		y2 = checkout(y2,width-1)
		if x1==x2:
				mask[x1,min(y1,y2):max(y1,y2)+1] = 1
		else:
			k = (y1-y2)/(x1-x2)
			x,y = minx(x1,x2,y1,y2)
			while True:
				mask[x,y] = 1
				x = x+1
				y = checkout(int(round(y+k)),width-1)
				if x>max(x1,x2):
					break
	for y1,x1,y2,x2 in background:
		x1 = checkout(x1,height-1)
		y1 = checkout(y1,width-1)
		x2 = checkout(x2,height-1)
		y2 = checkout(y2,width-1)
		if x1==x2:
				mask[x1,min(y1,y2):max(y1,y2)+1] = 0
		else:
			k = (y1-y2)/(x1-x2)
			x,y = minx(x1,x2,y1,y2)
			while True:
				mask[x,y] = 0
				x = x+1
				y = checkout(int(round(y+k)),height-1)
				if x>max(x1,x2):
					break
	if algo:
		rect=(0,0,0,0)
		bgdModel = np.zeros((1,65),np.float64)
		fgdModel = np.zeros((1,65),np.float64)
		cv2.grabCut(img,mask,rect,bgdModel,fgdModel,times,cv2.GC_INIT_WITH_MASK)
		mask2 = np.where((mask==2)|(mask==0),0,1).astype('uint8')
		im = img*mask2[:,:,np.newaxis]
		im += 255*(1-cv2.cvtColor(mask2, cv2.COLOR_GRAY2BGR))
		cv2.imwrite('out.png',im)
	else:
		mask1 = np.zeros(img.shape[:2],np.uint8)
		mask1[mask==1] = 3
		mask1[mask==2] = 1
		mask1[mask==3] = 2		
		GrabCut(filename, mask1, 1)
	return True
