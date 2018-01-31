import socket

port = 60001
s = socket.socket()
host = ""
s.bind((host, port))
s.listen(5)

while True:
	print 'Server listening....'
	conn, addr = s.accept()
	print 'Got connection from', addr
	filename = conn.recv(1024)
	print ("filename:",filename)
	print('Server received', repr(filename))

	try:
		f = open(filename,'rb')
	except IOError:
		conn.send(l)	


	l = f.read(10)
	while (l):
	   conn.send(l)
	   l = f.read(10)




	print('Done sending file:%s',filename)
	conn.close()
	f.close()
