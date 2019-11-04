// Quicksort algorithm: https://www.codeproject.com/KB/threads/Parallel_Quicksort/Parallel_Quick_sort_without_merge.pdf

#include <stdio.h>
#include <stdlib.h> 
#include<math.h>
#include <mpi.h>

void combine(int* final_chunk,int chunk1[],int chunk2[],int f,int s1,int s2){
	int i = 0;
	int j = 0;
	int k = 0;
	while(i<s1 && j < s2)
		final_chunk[k++] = (chunk1[i] < chunk2[j]) ? chunk1[i++]:chunk2[j++];
		
	while(i<s1)
		final_chunk[k++] = chunk1[i++];
	while(j<s2)
		final_chunk[k++] = chunk2[j++];
}


int swap(int* a,int *b){
	int tmp;
	tmp = *a;
	*a = *b;
	*b = tmp;	
}

int partition(int *arr, int left, int right) {
	int i = left-1;
	int pivot = arr[right];
	/* partition */

	for (int j = left; j <= right - 1; j++){  
		// If current element is smaller than the pivot  
		if (arr[j] < pivot)  
		{  
			i++; // increment index of smaller element  
			swap(&arr[i], &arr[j]);  
		}  
	}  

	swap(&arr[i+1],&arr[right]);

	return i+1;
}


int sequential_quicksort(int *a, int low, int high){
	int pivot;
	if ( high > low ) { /* Termination condition! */
		pivot = partition(a, low, high );
		sequential_quicksort( a, low, pivot-1 );
		sequential_quicksort( a, pivot+1, high );
	}

	return pivot;
}


int main(int argc, char **argv) 
{
	// Get the input
	int num_elements = atoi(argv[1]);
	int arr[num_elements];
	int output[num_elements];

	for(int i=0;i<num_elements;i++){
		arr[i] = atoi(argv[i+2]);
	}

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

	// Get chunk for each data
	int chunk_size,compute_size; 
	int* chunk;

	// Data each process needs to sort
	chunk_size = num_elements/num_process;
	if(num_elements % num_process != 0)
		chunk_size++;

	if(num_elements >= chunk_size * (rank+1))
		compute_size = chunk_size;
	else
		compute_size = num_elements - chunk_size * rank;

	chunk = (int*)malloc(chunk_size*sizeof(int));
	MPI_Scatter(arr, chunk_size, MPI_INT, chunk, chunk_size, MPI_INT, 0, MPI_COMM_WORLD);

	// Run serial quicksort
	sequential_quicksort(chunk,0,compute_size-1);


	// Merge the get output in log(num_process) iterations
	for (int iterations = 1; iterations < num_process; iterations = iterations<<1){
		if(rank%(2*iterations)!=0) // Send chunk
		{

	    	MPI_Send(chunk, compute_size, MPI_INT, rank - iterations, 0, MPI_COMM_WORLD);	
	    	break;
		}

		if(rank+iterations < num_process){ // receveie
			int receveie_chunk_size;
			if(num_elements < chunk_size *(rank+2*iterations))
				receveie_chunk_size = num_elements - chunk_size*(rank+iterations);
			else
				receveie_chunk_size = chunk_size * iterations;

		int* new_chunk = (int*)malloc(chunk_size*sizeof(int));	
		int* merge_chunk = (int*)malloc((compute_size+receveie_chunk_size)*sizeof(int));	
	    MPI_Recv(new_chunk, receveie_chunk_size, MPI_INT, rank+iterations, 0, MPI_COMM_WORLD, NULL);

	    combine(merge_chunk, chunk,new_chunk,compute_size+receveie_chunk_size,compute_size,receveie_chunk_size);

	    free(chunk);
	    chunk = merge_chunk;
	    compute_size = compute_size + receveie_chunk_size;
		}
	}

  	MPI_Barrier(MPI_COMM_WORLD);
	if(rank==0){
		printf("Output:");
		for (int i = 0; i < compute_size; ++i)
			printf("%d ", chunk[i]);
		printf("\n");
	}
	 
	ierr = MPI_Finalize();
	if(ierr != MPI_SUCCESS) {
		printf("Error Terminating MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	return 0;
}