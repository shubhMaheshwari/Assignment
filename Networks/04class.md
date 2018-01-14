# SMTP 

##	Requirements:
	1. Needs TCP
	2. TCP is secure and reliable 
	3. Port 25

	4. We do not want the mails to go to any other server except 2 mail server
	5. ASCII is mandatory 
	6. 3 phases 
		1. Handshake 2. Send message 3. Closure
	7. Persistent connection for sending large amount of data as multiple packets	 
	8. HTTP and SMTP are very similiar 
		1. Handshaking 
		2. Both have ASCII
		3. Both require TCP(transport layer protocol is TCP)

	9. Protocols 
		1. POP (Delete's from server after 1 download)
		2. IMAP 
		3. HTTP 
	10. Allows user to manage messages in multiple folders


# DNS 
	1. Domain Name System
	2. It is a distributed server implemented in an hierarchical manner.
	3. Not centeralized because 
		1. Single point of failure 
		2. Traffic Volume 
		3. Centralized system doesn't scale 
		4. Can take too long to respond, depending on location 
	4. TLD top-level domain 
		- such as .com,.net, .edu etc.
		- Sends the name of the Authoritative DNS server

	5. Authoritative DNS server 
		- Sends the actual IP address

## Query 
	1. Iterated query
	2. Recursive Query (Preferred query)

## DNS records 
		

## DNS Registrar
	Provide Names and domain and map it to an IP address		 	

# Transport Layer Protocol 

##	TCP
	1. Reliable but not secure 	
		If data is loss we can get it back 
	2. Garunteed Throughput 

# Multiplexing and Demultiplxing	
	Read from PPT or online

