import socket
from time import sleep



port = 60001
s = socket.socket()
host = ""
s.bind((host, port))
s.listen(5)

buffer_size = 1024

print 'Server listening....'

conn, addr = s.accept()

print 'Got connection from', addr

while True:
	sleep(1)
	filename = conn.recv(buffer_size)
	print ("filename:",filename)

	try:
		f = open(str(filename),'rb')
	except IOError:
		l = ''
		conn.send(l)
		break

	l = f.read(buffer_size)
	while (l):
		conn.send(l)
		l = f.read(buffer_size)


	print('Done sending file:%s',filename)
	l = ''
	conn.send(l)   

	f.close()

conn.close()