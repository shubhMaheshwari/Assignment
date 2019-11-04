#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <mpi.h>

using namespace std;

int N;
int num_color = 0; // Total number of colors
int adj[100][100]; // adjacency matrix
bool colors[100][100]; // color classes
bool free_color[100][100]; // free color classes of nodes
int degree[100]; // degreeuration of a node
int free_node[100]; // number of free color classes for nodes
bool color_node[100]; // is the node ready

struct REDUCE_MPI_STRUCT{
	int free;
	int rank;
};


int main(int argc, char **argv) {
	// Init
	int ierr;
	ierr = MPI_Init(&argc, &argv);
	if(ierr != MPI_SUCCESS) {
		printf("Error starting MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	// // Get the rank
	MPI_Status status;
	int rank, num_process;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &num_process);

	int  min_free, min_degree, min_rank;
	int startval, endval;

	if (rank == 0) {
		int m;
		scanf("%d %d",&N,&m);
		for (int i = 0; i < m; i++) {
			int u,v;
			scanf("%d %d",&u,&v);
			adj[v][u] = 1;
			adj[u][v] = 1;
		}
	}

	MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);
	startval = N * rank / num_process;
	endval = N * (rank + 1) / num_process;

	MPI_Bcast(adj, 100 * 100, MPI_CHAR, 0, MPI_COMM_WORLD);

	// Find the degree of each node 
	for (int i = 0; i < N; ++i) {
		for (int j = 0; j < N; ++j) {
			degree[i] += adj[i][j];
		}
	}



	for (int v = 0; v < N; ++v) {
		min_free = N;
		min_degree = N;
		min_rank = -1;
		for (int i = startval; i < endval; ++i)
			if(!color_node[i]) // Find node not ready to be colored 
			 	if(degree[i] < min_degree)	// Find the least degreeuration
			 		if (min_free >= free_node[i]){	// Find the minumum lowest free node
						min_free = free_node[i];
						min_degree = degree[i];
						min_rank = i;
					}

		REDUCE_MPI_STRUCT* p = (REDUCE_MPI_STRUCT *)malloc(sizeof(REDUCE_MPI_STRUCT));
		REDUCE_MPI_STRUCT* tmp_p = (REDUCE_MPI_STRUCT *)malloc(sizeof(REDUCE_MPI_STRUCT));
		p->rank = min_rank;
		p->free = min_free;
		MPI_Allreduce(p, tmp_p, 1, MPI_2INT, MPI_MINLOC, MPI_COMM_WORLD);

		min_rank = tmp_p->rank;
		min_free = tmp_p->free;

		color_node[min_rank] = 1; //ready to color
		//color it:
		if (min_free == 0) {
			//We need a new color class.
			colors[num_color][min_rank] = 1;
			//the new color class posible class for the rest:
			for (int i = startval; i < endval; ++i)
				if (!color_node[i]) {
					free_color[i][num_color] = 1;
					free_node[i] = free_node[i]+1;
				}
			//but not for the connected nodes:
			for (int i = startval; i < endval; ++i) {
				if (!color_node[i] && adj[i][min_rank]) {
					free_color[i][num_color] = 0;
					free_node[i] = free_node[i]-1;
				}
			}
			
			num_color = num_color + 1;
		} else {
			//We put node into an old color class.
			//find the class:
			int input_process = 0,c;
			while(input_process < num_process){
				if (N * input_process / num_process <= min_rank && min_rank < N * (input_process + 1) / num_process) break;
					if (rank == input_process)
						for (c = 0; !free_color[min_rank][c]; ++c);
							MPI_Bcast(&c, 1, MPI_INT, input_process, MPI_COMM_WORLD);
				input_process = input_process + 1;
			}

			colors[c][min_rank] = 1;
			for (int i = startval; i < endval; ++i) {
				if (!color_node[i] && free_color[i][c] && adj[i][min_rank]) {
					free_color[i][c] = 0;
					free_node[i] = free_node[i]-1;
				}
			}
		}
	}


	// Print Output 
	if (rank == 0) {
		printf("Total Colors required:%d\n",num_color);
		for (int i = 0; i < N; i++) {
			int c = num_color-1;
			while(true)
				if(colors[c][i]){
					printf("Node: %d Color:%d \n",i,c );
					break;
				}
				else{
					c--;
				}
		}
	}
	MPI_Finalize();
}