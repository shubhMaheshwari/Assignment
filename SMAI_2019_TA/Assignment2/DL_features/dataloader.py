import os
import numpy as np
from PIL import Image
import torch
from torchvision.transforms import transforms


train_transforms =  transforms.Compose([
    transforms.RandomResizedCrop(224),
    transforms.RandomHorizontalFlip(),
	transforms.ToTensor(),
	transforms.Normalize(mean=[0.485, 0.456, 0.406],std=[0.229, 0.224, 0.225])
])

val_transforms =  transforms.Compose([
 	transforms.Resize(256),
    transforms.CenterCrop(224),
	transforms.ToTensor(),
	transforms.Normalize(mean=[0.485, 0.456, 0.406],std=[0.229, 0.224, 0.225])
])

def get_labels(name,label_dict):
	name = name.split('_')[0]
	y = label_dict[name]
	return y	


class DataSet(torch.utils.data.Dataset):
	"""
		Our dataset loader for each training, testing, val dataset

	"""
	def __init__(self,opt, image_dir):
		super().__init__()
		# Directories
		# Calculate filename list 


		self.image_list = [os.path.join(image_dir,filename) for filename in  os.listdir(image_dir) if filename.split('.')[-1] == 'png']

		
		if "CFW" in image_dir:
			label_dict = {'Amitabhbachan': 0,
				'AamirKhan': 1,
				'DwayneJohnson': 2,
				'AishwaryaRai': 3,
				'BarackObama': 4,
				'NarendraModi': 5,
				'ManmohanSingh': 6,
				'VladimirPutin': 7}

		elif "yale" in image_dir.lower():
			label_dict = {}
			for i in range(15):
				label_dict[str(i+1)] = i
		elif "IMFDB" in image_dir:
			label_dict = {'MadhuriDixit': 0,
				 'Kajol': 1,
				 'SharukhKhan': 2,
				 'ShilpaShetty': 3,
				 'AmitabhBachan': 4,
				 'KatrinaKaif': 5,
				 'AkshayKumar': 6,
				 'Amir': 7}

		self.labels = [ get_labels(filename,label_dict)  for filename in os.listdir(image_dir) if filename.split('.')[-1] == 'png'  ]
		self.opt = opt
		self.N = len(self.image_list)
		print("Dataset size Images(0):{}".format(self.N))

	def __getitem__(self,idx):
	
		"""
			Given an index it returns the image and its ground truth (fake: 1, true: 0)
		"""
		im = Image.open(self.image_list[idx]).convert('RGB')
		im = train_transforms(im)
		y = self.labels[idx]
		return im,y				

	def __len__(self):
		return self.N



if __name__ == "__main__":
	pass
