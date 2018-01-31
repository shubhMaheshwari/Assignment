# Assignment 1 Computer networks
## Name: Shubh Maheshwari Roll_no: 20161170
## Name: Pranay Gupta Roll_no: 20161088

## Question 1)

- There are two files client.c and server.c copy the server.c to the directory from where you want to download files.

- Run _make_

- Start the server first by "./server <portnumber>".

- Then start the client by "./client <hostname> <portnumber> <name_of_the_file_to_be_downloaded>" 


# Multiple file transfer using Persistent and Non Persistent Connections

## Non-Persistant Connections
The folder named *Q2.1* contains the codes for the first part of the assignment, i.e., _Non Persistent_  connections.

The client and server will by default run on port number 60001.

## Persistans Connection 
The folder named *Q2.2* contains the codes for the second part of the assignment, i.e., Persistent  connections.

The client and server will by default run on port number 60001.

### Instructions for Q2:
  # In the server, run the server file first
  python server.py
  # In the client folder, in some other terminal, run the client file
  python client.py
  # Then as per the asked inputs, write the inputs


### Time Test 
- For 5 files of 93 MB:
- Persistant Network:
	python r.py  0.49s user 0.65s system 11% cpu 9.800 total
- Non Persistant Network:
	python r.py  0.49s user 0.65s system 11% cpu 5.600 total
