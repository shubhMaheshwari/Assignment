import numpy as np
from PIL import Image
from sklearn import mixture
from math import sqrt
import igraph

def GrabCut(filename,T,iter,n_components=5):
    #read image data
    im = Image.open(filename)
    #transform image to RGB matrix
    im=im.convert('RGB')
    #image size
    width = im.size[0]
    height = im.size[1]
    rgb = np.array(im,dtype=float)
    #define gamma
    gamma=50
    #calculate ||Zm-Zn||^2 (four directions enough)
    dis_N=np.sum((rgb[1:height,:]-rgb[:height-1,:])**2,axis=2)
    dis_W=np.sum((rgb[:,1:width]-rgb[:,:width-1])**2,axis=2)
    dis_NW=np.sum((rgb[1:height,1:width]-rgb[:height-1,:width-1])**2,axis=2)
    dis_NE=np.sum((rgb[1:height,:width-1]-rgb[:height-1,1:width])**2,axis=2)
    #calculate Beta
    beta=1/(2*(np.sum(dis_N)+np.sum(dis_W)+np.sum(dis_NE)+np.sum(dis_NW))/(4*height*width - 3*height - 3*width + 2))
    #define V edges
    dis_N=dis_N.reshape([dis_N.shape[0] * dis_N.shape[1]])
    dis_W=dis_W.reshape([dis_W.shape[0] * dis_W.shape[1]])
    dis_NW=dis_NW.reshape([dis_NW.shape[0] * dis_NW.shape[1]])
    dis_NE=dis_NE.reshape([dis_NE.shape[0] * dis_NE.shape[1]])
    #N direction
    temp_from=np.zeros([height,width])
    temp_from[1:height,:]=1
    temp_from=temp_from.reshape([height*width])
    temp_to = np.zeros([height, width])
    temp_to[:height-1,:] = 1
    temp_to = temp_to.reshape([height * width])

    es=np.column_stack([np.where(temp_from==1)[0], np.where(temp_to==1)[0]])#es will be used to define the edges for the cut graph
    w=gamma*np.exp(-beta*dis_N)#w will be used to define the weights for the cut graph
    #W direction
    temp_from = np.zeros([height, width])
    temp_from[:,1:width] = 1
    temp_from = temp_from.reshape([height * width])
    temp_to = np.zeros([height, width])
    temp_to[:,:width-1] = 1
    temp_to = temp_to.reshape([height * width])

    es_temp=np.column_stack([np.where(temp_from == 1)[0], np.where(temp_to == 1)[0]])
    es=np.row_stack([es,es_temp])
    w_temp=gamma * np.exp(-beta * dis_W)
    w=np.append(w,w_temp)
    #NW direction
    temp_from = np.zeros([height, width])
    temp_from[1:height,1:width] = 1
    temp_from = temp_from.reshape([height * width])
    temp_to = np.zeros([height, width])
    temp_to[:height-1,:width-1] = 1
    temp_to = temp_to.reshape([height * width])

    es_temp=np.column_stack([np.where(temp_from == 1)[0], np.where(temp_to == 1)[0]])
    es=np.row_stack([es,es_temp])
    w_temp=gamma/sqrt(2) * np.exp(-beta * dis_NW)
    w=np.append(w,w_temp)
    #NE direction
    temp_from = np.zeros([height, width])
    temp_from[1:height,:width-1] = 1
    temp_from = temp_from.reshape([height * width])
    temp_to = np.zeros([height, width])
    temp_to[:height-1,1:width] = 1
    temp_to = temp_to.reshape([height * width])

    es_temp=np.column_stack([np.where(temp_from == 1)[0], np.where(temp_to == 1)[0]])
    es=np.row_stack([es,es_temp])
    w_temp=gamma/sqrt(2) * np.exp(-beta * dis_NE)
    w=np.append(w,w_temp)
    #vectorization(to fit the required input form of the GMM function)
    K_temp=np.zeros([width*height])#define K index
    T_temp=T.reshape([width*height])#vectorize T
    rgb_temp = rgb.reshape([width * height, 3])#vectorize RGB matrix
    #define Tb Tf Tu according to T
    Tb=T_temp==0
    Tf=T_temp==3
    Tu=(T_temp==1)|(T_temp==2)
    #initalize GMM
    gmm = [mixture.GMM(n_components=n_components),mixture.GMM(n_components=n_components)]#two GMMs(background and foreground) with 5 components
    #define U edges for Tb and Tf
    if any(Tb):
        es_temp = np.column_stack([np.where(Tb)[0], (width * height) * np.ones(Tb[Tb].shape)])
        es = np.row_stack([es, es_temp])
        w_temp = 9 * gamma * np.ones(Tb[Tb].shape)
        w = np.append(w, w_temp)

        es_temp = np.column_stack([np.where(Tb)[0], (width * height + 1) * np.ones(Tb[Tb].shape)])
        es = np.row_stack([es, es_temp])
        w_temp = np.zeros(Tb[Tb].shape)
        w = np.append(w, w_temp)
    if any(Tf):
        es_temp = np.column_stack([np.where(Tf)[0], (width * height + 1) * np.ones(Tf[Tf].shape)])
        es = np.row_stack([es, es_temp])
        w_temp = 9 * gamma * np.ones(Tf[Tf].shape)
        w = np.append(w, w_temp)

        es_temp = np.column_stack([np.where(Tf)[0], (width * height) * np.ones(Tf[Tf].shape)])
        es = np.row_stack([es, es_temp])
        w_temp = np.zeros(Tf[Tf].shape)
        w = np.append(w, w_temp)
    # save the length of the certain parts of the weights and edges vectors
    # in order to keep them unchanged during the iteration
    l=len(w)
    #iterative minimization
    for i in range(iter):
        #set es and w to their certain parts
        es=es[range(l)]
        w=w[range(l)]
        #redefine Tb and Tf according to the new T
        Tb=T_temp<2
        Tf=T_temp>1
        #step1 and step2 assign GMM components and estimate parameters
        K_temp[Tb]=gmm[0].fit_predict(rgb_temp[Tb])
        K_temp[Tf]=gmm[1].fit_predict(rgb_temp[Tf])
        #step 3
        #define U edges for Tu
        #calculate and then append the uncertain parts of es and w to their certain parts
        es_temp = np.column_stack([np.where(Tu)[0], (width*height) * np.ones(Tu[Tu].shape)])
        es = np.row_stack([es, es_temp])
        w_temp = -gmm[1].score(rgb_temp[Tu])
        w = np.append(w, w_temp)

        es_temp = np.column_stack([np.where(Tu)[0], (width*height+1)* np.ones(Tu[Tu].shape)])
        es = np.row_stack([es, es_temp])
        w_temp = -gmm[0].score(rgb_temp[Tu])
        w = np.append(w, w_temp)
        #construct the cut graph using es and w
        es = es.astype(int)
        cuts = igraph.Graph()
        cuts.es['weight'] = 1
        cuts.add_vertices(height * width + 2)
        cuts.add_edges(es)
        cuts.es['weight'] = w
        #minimum cut
        c = cuts.mincut(width * height, width * height+1, capacity='weight')
        #define background/foreground index according to the minimum cut result
        indexb=np.array(list(c[0]),dtype=int)
        indexb=indexb[indexb<width*height]
        indexf = np.array(list(c[1]),dtype=int)
        indexf = indexf[indexf<width*height]
        #reassign the T value according to the index
        T_temp[indexb]=1
        T_temp[indexf]=2
    #reassign output RGB values
    rgb_temp[T_temp<2]=(255,255,255)
    rgb=rgb_temp.reshape([height,width,3])
    rgb=rgb.astype(int)
    #construct output image
    result = Image.new("RGB", (width, height))
    for i in range(width):
        for j in range(height):
            result.putpixel([i, j], tuple(rgb[j, i]))
    result.save("out.png")

    return np.array(result)
