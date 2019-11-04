// This is our main file containing all the invocation details
// It creates the interface class needed by the server to  
// connenct to the client servers unlike TCP we just need to 
// implement the functions in this class the client can directly 
// invoke the methods defined here. 


// Imports
import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.*; 
import java.util.*;             // Vectos and Map

// Our interface class 
public class ShortestPathQuery extends UnicastRemoteObject implements ShortestPath 
{ 
    // Define our graphs needed to do the computations
    private List< Map<String, List<String> >  > graphs = new ArrayList< Map<String, List<String> >  >();
    private Map<String, Integer> GraphName = new HashMap<>();

    // Default constructor to throw RemoteException 
    // from its parent constructor 
    ShortestPathQuery() throws RemoteException { 
        super(); 
    } 


    @Override
    public String get_graph(String graph_name) throws RemoteException {

        String output_string = "";
        try{

            if(!GraphName.containsKey(graph_name))
                return "Graph:" + graph_name + " does not exist";

            output_string = output_string + "Printing Graph:" + graph_name + "\n";
            // Get the graph 
            Integer graph_index = GraphName.get(graph_name);
            Map<String, List<String> > graph = graphs.get(graph_index);

            for (Map.Entry< String, List<String> > entry : graph.entrySet()){  
                String node = entry.getKey();
                List<String> edges = entry.getValue();

                output_string = output_string + node + "-->["; 

                for(int i=0;i< edges.size(); i++)
                    output_string = output_string + edges.get(i) + ",";

                output_string = output_string + "]\n";
            }
            return output_string;
        } catch(Exception ae) { System.out.println(ae); return "Error Occuered Server Side.\n" + ae.toString() + "\n";} 

    }  


    @Override
    public String shortest_path(String graph_name, String node1, String node2) throws RemoteException {

        try{

            Integer graph_index = GraphName.get(graph_name);

            // Get the graph
            if(!GraphName.containsKey(graph_name))
                return "Graph:" + graph_name + " does not exist\n";

            Map<String, List<String> > graph = graphs.get(graph_index);
            // Get the nodes1 and node2
            if(!graph.containsKey(node1))
                return node1 + " not present in " + graph_name + "\n";

            else if(!graph.containsKey(node2))
                return node2 + " not present in " + graph_name + "\n";
            else{


                // Given its an undirected graph a simple breadth-first search 
                // will provide the results
                Map<String, Integer> visited = new HashMap<>();
                Queue<String> queue = new LinkedList<>();

                queue.add(node1);

                Integer depth = 0;
                visited.put(node1,depth);

                while(!queue.isEmpty()){
                    String head_node = queue.poll();
                    if(head_node.equals(node2))
                        return "Distance between:" + node1 + " and " + node2 + " is " + visited.get(node2).toString() + "\n";                        
                    

                    for(String child: graph.get(head_node)){
                        if(!visited.containsKey(child)){
                            queue.add(child);
                            visited.put(child, visited.get(head_node) + 1);
                        }
                    }    


                }

                return node1 + " and " + node2 + " are disconnected";

            }

            // Compute the Shortest distance 

            // Return the a string connecting the points.
        } catch(Exception ae) { System.out.println(ae); return "Error Occuered Server Side.\n" + ae.toString() + "\n";} 

    }  


    @Override
    public String add_edge(String graph_name,String node1, String node2) throws RemoteException {
        try{
            String output_string = "";

            // Create if no graph present
            if(!GraphName.containsKey(graph_name))
                output_string = output_string + "Adding Graph:" + graph_name + "\n";
                GraphName.put(graph_name,GraphName.size()); 
                graphs.add(new HashMap());

            // Get the graph 
            Integer graph_index = GraphName.get(graph_name);
            Map<String, List<String> > graph = graphs.get(graph_index);

            // Check if node present 
            if(!graph.containsKey(node1))
                graph.put(node1,new ArrayList<String>());
                output_string = output_string + "Adding " + node1 + " to " + graph_name + "\n";

            if(!graph.containsKey(node2))
                graph.put(node2,new ArrayList<String>());
                output_string = output_string + "Adding " + node1 + " to " + graph_name + "\n";

            List<String> vertex1 = graph.get(node1);
            List<String> vertex2 = graph.get(node2);

            // Check if edge already present
            if( vertex1.contains(node2) )
                output_string = output_string + node1 + " --> " + node2 + " already present" + "\n";
            else{
                vertex1.add(node2);
                output_string = output_string + "Added Edge:" + " " + node1 + " --> " + node2 + "\n";
            }

            if( vertex2.contains(node1) )
                output_string = output_string + node2 + " --> " + node1 + " already present" + "\n";
            else{
                vertex2.add(node1);
                System.out.println(node2 + node1);

                output_string = output_string + "Added Edge:" + " " + node2 + " --> " + node1 + "\n";
            }

            // Add node1 and node2 to graph  
            return output_string; 

        } catch(Exception ae) { System.out.println(ae); return "Error Occuered Server Side.\n" + ae.toString() + "\n";} 

    }  
} 