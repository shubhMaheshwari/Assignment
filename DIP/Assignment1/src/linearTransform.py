import matplotlib.pyplot as plt
import numpy as np
import sys
from PIL import Image

def LinearTransform(im, k1, k2, a, b):


    x = np.arange(0,1,0.01)
    y = k1*x + k2
    y[ x < a] = 0
    y[ x > b] = 1
    y[ y > 1] = 1
    y[ y < 0] = 0
    print(y)

    # Update y for main use
    k1 = int(k1*255)
    k2 = int(k2*255)
    a = int(a*255)
    b = int(b*255)

    # Get the dimensions of background image 
    im = np.array(im)


    new_im = k1*im + k2
    new_im[im > b] = 255
    new_im[im < a] = 0

    fig = plt.figure()
    ax1 = fig.add_subplot(1,3,2)
    ax2 = fig.add_subplot(1,3,3)
    ax3 = fig.add_subplot(1,3,1)
    ax1.imshow(im, cmap='gray')
    ax2.imshow(new_im, cmap='gray')
    ax3.plot(x,y)
    ax1.set_title('Old Image')
    ax2.set_title('Transformed Image')
    ax3.set_title('Function')
    ax1.axis('off')
    ax2.axis('off')
    ax3.axis('scaled')
    plt.show()


if __name__ == "__main__":

    # Get the input
    path = sys.argv[1]
    k1 = float(sys.argv[2])
    k2 = float(sys.argv[3])
    a = float(sys.argv[4])
    b = float(sys.argv[5])

    im = Image.open(path)
    # Run the function
    LinearTransform(im,k1,k2,a,b)
