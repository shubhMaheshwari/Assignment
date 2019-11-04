import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.*; 

public interface ShortestPath extends Remote 
{ 
    // Declaring the method prototype 
    String get_graph(String graph_name) throws RemoteException;
    String shortest_path(String graph_name, String node1, String node2) throws RemoteException;
    String add_edge(String graph_name,String node1, String node2) throws RemoteException;
}