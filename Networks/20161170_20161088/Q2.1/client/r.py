import socket                   

host = ""
port = 60001                


num = int(raw_input("Enter No. of files:"))
files = []

for i in range(num):
    file = raw_input(str(i)+ ':')
    files.append(file)


for filename in files:
    try:
        s = socket.socket()                     
        s.connect((host, port))
        # filename = raw_input("Enter file to recieve:")
        f = open(filename,'wb')
        s.send(filename)

        while True:
            data = s.recv(1024)
            if not data:
                break
            # write data to a file
            f.write(data)
        s.close()
        print('connection closed')
    except socket.error, exc:    
        print("exc:",exc)    
        continue

    print('Operation Complete')
