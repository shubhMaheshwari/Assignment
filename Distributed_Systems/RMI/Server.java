// This is our main server to which users must be able to connect from their local machine

// Imports
import java.io.*;				// DataStream Input/Output & File input and output
import java.util.*; 			// Vectos and Map
import java.net.*;				// Java socket
import java.awt.* ;				// Threading
import java.nio.file.*; 		// Path like os.path in python 
import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.*; 


public class Server { 
    public static void main(String args[]) { 
        try{ 
            
			if(args.length!=1){
				System.out.println("[Error]: Specify Port. Usage: java Server <port>"); System.exit(0);
			}

			Integer port = Integer.parseInt(args[0]);


            // Create an object of the interface 
            ShortestPathQuery obj = new ShortestPathQuery(); 
  
            // rmiregistry within the server JVM with 
            // port number 1900 
            LocateRegistry.createRegistry(port); 
  
            // Binds the remote object by the name 
            Naming.rebind("rmi://0.0.0.0:"+ port.toString() + "/shortest_path_finder",obj); 
        } 
        catch(Exception ae) { System.out.println(ae); } 
    } 
} 