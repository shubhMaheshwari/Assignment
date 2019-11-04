# Main module to train the model, load the data,
# do gradient descent etc. followed by saving our model for later testing
import os
import numpy as np 
import torch
from torchvision.transforms import *
import torch.optim as optim

from options import TestOptions
from model import Model
from dataloader import DataSet


# Get the Hyperparaeters 
opt = TestOptions().parse()


sample_dataset = DataSet(opt,"../dataset/IMFDB")

sample_loader = torch.utils.data.DataLoader(sample_dataset,batch_size=opt.batch_size,num_workers=5,shuffle=False)


# Check if gpu available or not
device = torch.device("cuda" if (torch.cuda.is_available() and opt.use_gpu) else "cpu")
opt.device = device

# Load the model and send it to gpu
model = Model(opt,15)
model = model.to(device)
if opt.use_gpu:	
	model = torch.nn.DataParallel(model, device_ids=opt.gpus)

# Print our model 
print('------------ Model -------------')
print(model)
print('-------------- End ----------------')	


# Make checkpoint dir to save best models
if not os.path.exists('./checkpoints'):
	os.mkdir('./checkpoints')

# If require load old weights
if opt.load_epoch > 0:
	print(torch.load('./checkpoints/' + 'model.pt'.format(opt.load_epoch)))
	model.load_state_dict(torch.load('./checkpoints/' + 'model.pt'.format(opt.load_epoch)))
# Variables to store the losses and accuracy in list so that we can plot it later
best_epoch = 0

def save_model(model,epoch):
	filename = './checkpoints/' + 'model.pt'.format(epoch)
	torch.save(model.state_dict(), filename)

def get_accuracy(pred_sample, sample_labels):
	pred_sample = np.argmax(pred_sample.cpu().data.numpy(),axis=1 )
	# Getting accuracy on sample images
	sample_acc = np.mean(pred_sample == sample_labels.cpu().data.numpy())

	return sample_acc



model.eval()
for i, (sample_images, sample_labels) in enumerate(sample_loader):			

	# Do a prediction
	try:
		pred_sample = model(sample_images.to(device))
		print(model.outputs[0].shape)

	except RuntimeError  as r:
		print("Error:",r)
		torch.cuda.empty_cache()
		continue
	except Exception as e:
		print("Error:",e)	
		torch.cuda.empty_cache()
		continue