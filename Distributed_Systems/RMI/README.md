# Remote Method Invocation 
Using RMI, implement Shared Shortest Path Finder. 
    The server would manage a graph. 
    Allow clients to either update graph or find shortest path between any two nodes.

# Introduction 
Distibuted systems need a way to communicate to share memory, resquest and respond, broadcast. It is generally done by creating a graph and using remote method invocation(RMI) to call functions. 

## Distributed Systens Assignment 3
Roll no:- 20161170 Name:- Shubh Maheshwari  

 
# Run
**Compile** : 
```
javac *.java
```

**Start Server**
```
java -Djava.rmi.server.hostname=<server-ip> -Djava.security.policy=server.policy Server <port>

```

**Start Client**
```
java User <server-ip>  <server-port>  
```

# Files 
──> Distributed_Systems_Assignment_3.pdf // Assignment details

──> README.md       // Instructions

──> Server.java     // Main Server 

──> ShortestPath.java   // Template Class for client 

──> ShortestPathQuery.java  // Main interface and implementation

──> User.java       // Client server


## Commands and their usage:

1. `add_edge`:Adds an edge between 2 nodes. 
    
    If graph not present it will create a new graph. It nodes not present it will add new nodes
   ```
   add_edge graph_name node1 node2
   ```
2. `shortest_distance`: Find the shortest path between 2 nodes. 

   ```
   shortest_distance graph_name node1 node2
   ```
5. `get_graph`: Prints the entire graph. 
    It prints the nodes and the edges of each node.
   ```
   get_graph graph_name
   ```
6. `exit` or `close`: Close the program
   ```
   exit
   ```
