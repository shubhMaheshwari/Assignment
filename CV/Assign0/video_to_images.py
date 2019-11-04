import os
import cv2
import numpy as np
import matplotlib.pyplot as plt


def video2image(path):
	"""
		It will convert video to frames which are stored in a directory same name as of the video

		params :=> Given path to any video (mpeg, mp4,avi) 
		return: None
		files: takes video as input and returns a directory of frames 
		
		incase path = 0(webcam), images are stored in a directory named webcam 
	"""

	# Initialize video
	cap = cv2.VideoCapture(path)

	if (cap.isOpened()== False): 
		print("Error opening video stream or file")
		return

	# If path = 0 we are running the webcam
	if path == 0:
		dir_name = 'webcam'
	else:
		dir_name = path.split('.')[0]

	# Create the dir 
	if not os.path.isdir(dir_name):
		os.mkdir(dir_name)

	# Write frames into the dir
	cnt = 0
	while cap.isOpened():
		ret,frame = cap.read()
		if ret == True:
			cv2.imshow('Frame',frame)
			
			cv2.imwrite('{}/{}.png'.format(dir_name,cnt),frame)
			cnt += 1
			# Press Q on keyboard to  exit
			if cv2.waitKey(25) & 0xFF == ord('q'):
				break

		elif cnt >= 100:
			break
		else:
			break
	
	# Close files
	cap.release()
	cv2.destroyAllWindows()

	return 

def image2video(dir_path):
	"""
	It will convert frames to video which are stored in a directory same name as of the video

	params :=> Given path to any image dir (png, jpeg, jpg) 
	return: None
	files : video(avi):  
	
	"""
	# Create a new video
	path = dir_path + '.avi'

	# Set parameters
	fps = 30.0
	width = 480
	height= 640
	fourcc = cv2.VideoWriter_fourcc(*'XVID')
	cap = cv2.VideoWriter(path,fourcc,fps,(height,width),1)


	# List elements and sort them using their names  
	cnt = 0
	image_list = sorted(os.listdir(dir_path),key=lambda x: int(x.split('.')[0]))
	for filename in image_list:
		frame = cv2.imread(os.path.join(dir_path,filename))
		cnt += 1
		cap.write(frame)
		cv2.imshow('Frame',frame)
		# Press Q on keyboard to  exit
		if cv2.waitKey(25) & 0xFF == ord('q'):
			break
	cap.release()
	cv2.destroyAllWindows()

	return

def croma_key(fg_video,bg_video):

	"""
		Given a green screen video and a background merge the 2 create a new video
		params :=> fg_video: foreground green screen image
				   bg_video: background screen image			
	"""

	# Convert 2 videos to images
	video2image(fg_video)
	video2image(bg_video)


	# Get their frame dir names 
	fg_dir = fg_video.split('.')[0]
	bg_dir = bg_video.split('.')[0]
	RED, GREEN, BLUE = (2, 1, 0)
	
	# Create the list of images
	cnt_list = [ int(file.split('.')[0]) for file in os.listdir(fg_dir)]
	cnt_list1 = [ int(file.split('.')[0]) for file in os.listdir(bg_dir)]

	cnt_list = sorted(cnt_list)
	cnt_list1 = sorted(cnt_list1)

	# Output dir name
	out_dir = 'chroma'
	for cnt in cnt_list:
		# Read and resize images
		fg_img = cv2.imread('{}/{}.png'.format(fg_dir,cnt))
		bg_img = next(iter(cnt_list1))
		h,w,c = fg_img.shape
		
		bg_img = cv2.imread('{}/{}.png'.format(bg_dir,bg_img))		

		print(fg_img.shape,bg_img.shape)
		bg_img = cv2.resize(bg_img, (h,w)) 

		# Get mask 
		reds = fg_img[:, :, RED]
		greens = fg_img[:, :, GREEN]
		blues = fg_img[:, :, BLUE]

		# Threshold  == 35
		mask = (greens < 35) | (np.amax(fg_img, axis=2) != greens)

		mask_fg = np.where(mask==1)
		mask_fg = np.array([mask_fg,mask_fg,mask_fg]).T
		mask_bg = np.where(mask==0)
		mask_bg = np.array([mask_bg,mask_bg,mask_bg]).T

		# Create new image
		new_image = np.zeros((w,h,c))
		new_image[mask_fg] = fg_img[mask_fg]
		new_image[mask_bg] = bg_img[mask_bg]

		# Write to output frames dir
		cv2.imwrite('{}/{}.png'.format(out_dir,cnt),new_image)
		
	# Convert to video
	image2video(out_dir)	

	return

if __name__ == '__main__':
	# Check webcam is working
	# video2image(0)
	# Check for local video from video
	# image2video('webcam')

	# Croma key
	croma_key('fire_bomb.mp4','meme_video.mp4')

