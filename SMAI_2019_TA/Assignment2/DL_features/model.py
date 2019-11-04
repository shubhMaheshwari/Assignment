import torch 
import torch.nn as nn
import torchvision.models as models

class Model(nn.Module):
	"""
		Our model
	"""
	def __init__(self,opt,num_classes):
		super(Model,self).__init__()
		self.opt = opt
		self.model = models.resnet50(pretrained=True)
		num_ftrs = self.model.fc.in_features
#		num_ftrs = self.model.classifier[-1].in_features

		self.model.fc = nn.Linear(num_ftrs,num_classes)

		self.outputs = []
		def hook(module, input, output):
			self.outputs.append(input)
	
		self.model.fc.register_forward_hook(hook)


	def forward(self,main_images,get_feature=False):
		"""
			Compute the predictions for both images and also calculate the MMD
			@param main_images: batch of sample images

		"""
		pred = 	self.model(main_images)
		return pred 
