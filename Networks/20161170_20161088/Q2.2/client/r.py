import socket                   
host = ""
port = 60001                

s = socket.socket()                     
s.connect((host, port))
buffer_size = 1024



num = int(raw_input("Enter No. of files:"))
files = []

for i in range(num):
    file = raw_input(str(i)+ ':')
    files.append(file)


for filename in files:
    try:
        f = open(filename,'wb')
        s.send(filename)

        while True:
            data = s.recv(buffer_size)
            if not data or data == '' : 
                break
            f.write(data)

            if len(data) < buffer_size:
                break
        f.close()

    except socket.error, exc:    
        continue

s.close()
print('connection closed')


print('Operation Complete')
