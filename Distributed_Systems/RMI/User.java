// This is our clint server using which users connect to the main server

// Imports
import java.io.*;				// DataStream Input/Output & File input and output
import java.util.*;				// Vectos and Map
import java.net.*;				// Java socket 
import java.awt.*;				// Threads
import java.rmi.*; 


public class User 
{ 
	public static void main(String args[]) 
	{ 
		try{ 

			if(args.length!=2)      // Check correct number of arguments passed to the program
			{
				System.out.println("[Error]: Specify Port. Usage: java ShareFile <server-ip> <server-port>"); System.exit(0);
			}

			// Initialize data
			String server_ip = args[0];            
			Integer server_port = Integer.parseInt(args[1]);


			// lookup method to find reference of remote object 
			ShortestPath access = (ShortestPath)Naming.lookup("rmi://" + server_ip + ":" + server_port + "/shortest_path_finder"); 
		
			// Define Inputstream for command input 
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
			String inputLine=null, graph_name=null,node1=null,node2=null;          // String where all the commands are stored
			// Get commands
			while(true){
				try{

					try{Thread.sleep(200);}catch(InterruptedException ex){Thread.currentThread().interrupt();}

					// Print Basics
					System.out.print(">>>");
					inputLine=bufferedReader.readLine();
					if(inputLine.length() == 0)
						continue;
					// Get the command and variables from the input
					StringTokenizer tokenizedCommand = new StringTokenizer(inputLine);

					String command = tokenizedCommand.nextToken();

					if(command.equals("close") ||  command.equals("exit") ){break;}		// Exit

					else if(command.equals("add_edge")){ 								// Add Edge to a particular graph
						if(tokenizedCommand.countTokens() != 3){
							System.out.println("Usage: add_edge graph_name node1 node2");  
							continue;
						 }

						graph_name = tokenizedCommand.nextToken();
						node1 = tokenizedCommand.nextToken();                    
						node2 = tokenizedCommand.nextToken();                    
						System.out.print(access.add_edge(graph_name,node1,node2));	// Print the results

					}

					else if(command.equals("shortest_distance")){    					// Find the shortest distance between the graphs
						if(tokenizedCommand.countTokens() != 3){
							System.out.println("Usage: shortest_distance graph_name node1 node2"); 
							continue;
						}

						graph_name = tokenizedCommand.nextToken();
						node1 = tokenizedCommand.nextToken();                    
						node2 = tokenizedCommand.nextToken();
						System.out.print(access.shortest_path(graph_name,node1,node2)); // Print the results


					}

					else if(command.equals("get_graph")){            					// Print the complete graph 
						if(tokenizedCommand.countTokens() != 1){
							System.out.println("Usage: get_graph graph_name"); 
							continue;
						}

						graph_name = tokenizedCommand.nextToken();
						System.out.print(access.get_graph(graph_name)); 				// Print the results

					}

					else{System.out.println("Unrecognized Command");continue;}

				} catch(Exception ae) { System.out.println(ae);}// End of the try statement in while loop 
			}// End of while loop

		} catch(Exception ae) { System.out.println(ae);} // End of main try statement  
	}// End of main
}// End of class

