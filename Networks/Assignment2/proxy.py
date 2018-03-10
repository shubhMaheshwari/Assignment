from __future__ import print_function

import time
import os
import threading
import socket,sys
import signal

# Maximum number of connections 
max_conn = 20
# Amount of data in one flow 
buffer_size = 4096

HOST = ""
PORT = 12345

# Webserver port: connecting to port 80 if not specified otherwise

# connect to the webserver and make request
def proxy_server(webserver,port,conn,addr,filename):
	# try:
	# Make a TCP connection to the webserver
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.connect((webserver,port))
	print("=> Page:",filename)

	if filename in os.listdir('./.cache/'):
		s.send("GET /"+ filename + " HTTP/1.1\r\nIf-Modified-Since: " + time.ctime(os.path.getmtime('./.cache/' + filename)) + " \r\n\r\n")
	else:
		s.send("GET "+ filename + " HTTP/1.1\r\n\r\n")

	# Check if modified
	reply = s.recv(buffer_size)
	#  200 == yes
	if reply.find("200") >= 0:	
		f = open(os.path.join('./.cache/',filename),'wb')
		while 1:
			if(len(reply) > 0):
				f.write(reply)

				conn.send(reply)
				# send reply back to the client
				dar = float(len(reply))/1024
				# Print on successful message transfer
				print("=> Request done to:",str(addr[0]),"Response Size(KB):",dar)

				reply = s.recv(buffer_size)
		
			else: 
				# break the connection
				break	

		f.close()		

	# No modification to the file
	elif reply.find("304") >= 0:			
		print("=> Response Code:304 Already present in cache") 	
		f = open(os.path.join('./.cache/',filename),'rb')			
		l = f.read(buffer_size)
		while (l):
	   		conn.send(l)
	   		l = f.read(buffer_size)
	   	f.close()	

	else: 
		print("=> Response Status:",reply)			


	s.close()
	conn.close()
	# except socket.error as serr:
	# 	print("Socker error:",serr)
	# 	s.close()
	# 	conn.close()
	# 	sys.exit(1)	
	# except Exception as e:
	# 	print("Exception:",e)
	# 	s.close()
	# 	conn.close()
	# 	sys.exit(1)

# Each thread calls this function to retrieve the host,address and port
def conn_string(conn,addr,byte_data):
	try:
		# convert from bytes to string
		
		data = str(byte_data)
		first_line = data.split('\r\n')[0]
		url = first_line.split()[1]
		
		# Get the url without the protocol
		http_pos = url.find('://')
		if(http_pos == -1):
			temp = url 
		else:
			temp = url[(http_pos+3):]

		# Position of the port number
		port_pos = temp.find(':')
		webserver_pos = temp.find('/')

		# position where port number ends
		if webserver_pos == -1:
			webserver_pos = len(temp)

		webserver = ''
		port = -1

		if port_pos == -1 or webserver_pos < port_pos:
			port = 80
			webserver = temp[:webserver_pos]

		else:
			# For specific ports
			port = int((temp[(port_pos+1):])[:webserver_pos - port_pos -1])
			webserver = temp[:port_pos]

		print("=> Request",webserver,port)    

		# Find the file name
		try:
			filename = temp.split('/')[1]
		except IndexError:
			filename = '/'

		proxy_server(webserver,port,conn,addr,filename)


	except Exception as e:
		print("Thread Creation Exception:",e)


# Start the program 
def start():
	# Open the path to ./.cache if not present make one 
	if os.path.isdir('./.cache'):
		print("Using the existing cache")
	else:
		os.makedirs('.cache')
		print("Creating folder .cache")	

	# Create a TCP socket
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

	s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

	# bind the socket to a public host, and a port   
	s.bind((HOST, PORT))
	

	s.listen(max_conn)

	s.listen(max_conn) # become a server socket
	clients = {}

	# except Exception as e:
	#     print("Unable to Initialize Socket:",e)
	#     sys.exit(2)


	while True:
		try:
		# Establish the connection
			(conn, addr) = s.accept() 
			data = conn.recv(buffer_size)
			t = threading.Thread(target=conn_string,args=(conn,addr,data))
			t.start()
			# d = threading.Thread(name=self._getClientName(client_address), 
			# target = self.proxy_thread, args=(clientSocket, client_address))
			# d.setDaemon(True)
			# d.start()
		except Exception as e: 
			print("Proxy server Shutting down")
			print("Error:",e)
			s.close()
			sys.exit(1)

	s.close()    

if __name__ == '__main__':
	start()