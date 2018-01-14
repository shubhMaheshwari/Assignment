import numpy as np 

fh = open('protein.pdb','r')
file = fh.read()

file = file.split('\n')
file = file[1:-2]

x = np.array([])
for line in file:
	line = line.split(' ')
	line = filter(lambda x: x != '',line) 
	x = np.append(x,np.array(map(float,line[6:9])),axis = 0)

x = np.reshape(x,(len(file),3))
x = x + np.mean(x,0)
print(x)
# open('rotate.pdb','a+').write()






# close()