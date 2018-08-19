import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image

def ChromaKey(fg, bg, chr_color):

	# Get the dimensions of background image 
	bw, bh = bg.size
	fg = fg.resize((bw,bh), Image.ANTIALIAS)


	bg = np.array(bg)
	fg = np.array(fg)

	fg[fg == np.array(chr_color)] = bg[fg == np.array(chr_color)] 
	plt.imshow(fg)
	plt.show()
if __name__ == "__main__":

	# Get the input
	fgpath = sys.argv[1]
	bgpath = sys.argv[2]
	chr_color = [ int(x) for x in sys.argv[3].split(',')]
	fg = Image.open(fgpath).convert('RGB')
	bg = Image.open(bgpath).convert('RGB')
	# Run the function
	print(fg.size)
	ChromaKey(fg,bg,chr_color)
