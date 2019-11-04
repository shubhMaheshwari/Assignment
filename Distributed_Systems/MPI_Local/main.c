// Quicksort algorithm: https://www.codeproject.com/KB/threads/Parallel_Quicksort/Parallel_Quick_sort_without_merge.pdf

#include <stdio.h>
#include <stdlib.h> 
#include <mpi.h>

int main(int argc, char **argv) 
{
	// Get the input

	// Init
	int ierr;
	ierr = MPI_Init(&argc, &argv);
	if(ierr != MPI_SUCCESS) {
		printf("Error starting MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	// Get the rank
	int rank,num_process;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &num_process);

	int token;
	if(rank==0){	// Rank 0 receives from main function
		token = atoi(argv[1]);
		printf("Process:%d received token %d from process %d\n",rank,token,-1);
	}
	else{
		// All process receive from the previous process
		MPI_Recv(&token, 1, MPI_INT, rank - 1, 0,MPI_COMM_WORLD, MPI_STATUS_IGNORE);
		printf("Process %d received token %d from process %d\n",rank, token, rank - 1);
	}
	
	// Sending to the next process
	MPI_Send(&token, 1, MPI_INT, (rank + 1) % num_process,0, MPI_COMM_WORLD);

	if(rank==0){
		MPI_Recv(&token, 1, MPI_INT, num_process-1, 0,MPI_COMM_WORLD, MPI_STATUS_IGNORE);
		printf("Process:%d received token %d from process %d\n",rank,token,num_process-1);
	}

	 
	ierr = MPI_Finalize();
	if(ierr != MPI_SUCCESS) {
		printf("Error Terminating MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	return 0;
}