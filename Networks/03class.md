# Numerical 
1. A and B transmit using Router R
Link = 10Mbps 
Propogation Delay = 20us
Processing at R = 35 us 

a) 1 packet of 10,000 bits from A=>B
	1. Link delay from a=>r = 10K/10M = 1000 us
	2. Propagation from A=>R  = 20 us
	3. Processing delay = 35 us
	4. Link delay from r=>b = 1000us
	5. Propagation Delay = 20us
	TOTAL = 2075 us


b) 2 packets from 5,000 bits from A=>B right after another.

	t = 0  P1 starts transmitting 
	t = 500 P2 starts transmitting 
	t = 520 P1 reaches P1
	t = 555 P1 processes on R/ P1 starts transmitting
	t = 1020 P2 propogates to R 
	t = 1055 P1 links B/ P2 processes at R transmitting from R
	t = 1075 P1 propgates to B
	t =1555 P2 links to B
	t = 1575 P2 Prapogates to B 

	Total = 1575 us 

2. Series of Links connected without a router
Ans => Throughput = Wire with the least speed. 

Hence time delay = data-size/wire with least speed


# Application Layer 
	eg. Email, video streaming, P2P, file sharing
	0. Different Application needs different protocol.
	1. This protocol is the not defined at the backbone routers but at the end systems because these are just bytes for the backbone network. 
	2.Routers are only needed until the  network layer 

## Sockets 
	Sockets are basically doors for communiation between devices

## Client Server Architecture 
	Server: 
		1. Always must be switched on. 
		2. Ip address can't be changed or a message must be send to all imaginable user.

	Client: 
		1. Can be mobile/ dynamic Ip address
		2. Can be switched on and off
		3. 2 clients cannot communicate with each other			 	

## Peer 2 Peer
	eg. Bluetooth, Infrred communication, Device to device communication (no need of a client)

	1. Cannot garuntee of communication(both may not be on)
	2. Dynamic IP address(when changing location IP might change) Hence complex management is required.

### Throw box Architecture(Complicated P2p with buckets)	
	eg. Torrent

## Process Communication	
	i. client process
	ii. server process 
	Is IP address enough ?
		No, their can be multiple process
		Hence we have ports
		Ports is the location where the process looks for the bytes recieved by the network.

## Services required by App
	eg. Video=> 
			1. Timestamp(Min Lagging)
			2. Less data loss
			3. Security	  
			4. Data integrity 
			5. Throughput(Some applications require minimum throughput)

## TCP protocol 
	1. Secure / Reliable
	2. Is data loss then retransmission
	3. Flow control 
	4. Congestion Control 
	5. Cannot garuntee timing, 
	6. Connection orieanted protocol, first sets up the connection then makes a request

## UDP protocol			
	1. Faster 
	eg. telephone calls, media streaming 

## HTTP
	


