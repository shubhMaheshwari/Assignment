// Parallel Stable Marriage algorithm 

#include <stdio.h>
#include <stdlib.h> 
#include<math.h>
#include <mpi.h>

int N;
int men[100][100];
int women[100][100];
int Match[100];
int flag;
int number;

int main(int argc, char **argv) 
{
	
	// Init
	int ierr;
	ierr = MPI_Init(&argc, &argv);
	if(ierr != MPI_SUCCESS) {
		printf("Error starting MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	// Get the rank
	int rank,num_process,terminate=-2,rejection=-4;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &num_process);


	if(rank==0){
		scanf("%d",&N); // Input Nodes
		printf("%d %d\n",N,num_process);
		// Men ranking engaged_women 
		for (int i = 0; i < N; ++i)
			for (int j = 0; j < N; ++j)
				scanf("%d",&men[i][j]);

		// Women Ranking men
		for (int i = 0; i < N; ++i)
			for (int j = 0; j < N; ++j)
				scanf("%d",&women[i][j]);

		if(num_process != 1 + 2*N){
			printf("Number of process should be equal to 1 + 2*N. Terminating. \n");
			MPI_Abort(MPI_COMM_WORLD,0);
		}
	}
    MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(men, 100 * 100, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(women, 100, MPI_INT, 0, MPI_COMM_WORLD);


    if(rank==0){
    	// Do Something

    	// Semd match llist
    	int engaged_women = N;
		while(!flag){
			MPI_Iprobe(MPI_ANY_SOURCE , 0 , MPI_COMM_WORLD, &flag, MPI_STATUS_IGNORE);
			if(flag){
				MPI_Recv(&number, 1, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
				// If woman processes confirms that they're engaged
				if(number == terminate){
					engaged_women--;	// Decrease number of engaged_women that are not engaged yet
				}
			}
			flag = 0;
			// If all engaged_women are engaged
			if(engaged_women == 0){
				// Send termination signal to all processes 
				for(int i=1 ; i<=size-1; i++){
					MPI_Send(&terminate, 1, MPI_INT, i , 0, MPI_COMM_WORLD);
				}

				// Open an output file
				ofstream outFile;
				outFile.open("output.txt");
				// Recieve all couples from engaged_women and write them into the file
				for(int i= (size+1)/2 ; i<size ; i++ ){
					MPI_Recv(&number, 1, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
					outFile << number << "-" << i-n << endl;
				}
				outFile.close();	// File is closed 
				break;

			}
    }

    else if(rank<=N){

    	int num_woman_propose = 0;

		while(!flag){
			MPI_Iprobe(MPI_ANY_SOURCE , 0 , MPI_COMM_WORLD, &flag, MPI_STATUS_IGNORE);
			if(flag){
				MPI_Recv(&number, 1, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
				if(number == terminate){
					break;
				}else{	// If recieved data from a woman
					// This means this man is rejected. Propose the next woman
					MPI_Send( &rank , 1, MPI_INT, men[rank][num_woman_propose], 0, MPI_COMM_WORLD);
					num_woman_propose++;
				}
			}
			flag = 0;
		}

    }

    else{


		vector<int>::iterator _old;
		vector<int>::iterator _new;

    	int isEngaged = 0;

		
		while(!flag){
			MPI_Iprobe( MPI_ANY_SOURCE , 0 , MPI_COMM_WORLD, &flag, MPI_STATUS_IGNORE);
			if(flag){
				MPI_Recv(&number, 1, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
				flag = 0;
				if(number == terminate){
					break;	
				}else{	// Recieved data from a man
					if(!isEngaged){	// The woman is not engaged yet
						isEngaged = number;	// Store the rank of the man
						MPI_Send(&terminate, 1, MPI_INT, 0 , 0, MPI_COMM_WORLD);
					}else{	// Recieved a proposal but already engaged
						
						_old = find (prefs.begin(), prefs.end(), isEngaged);	//Iterator for the old man in the preference list
						_new = find (prefs.begin(), prefs.end(), number);		//Iterator for the new man in the preference list
						
						if(_old < _new)	// If old man comes before the new one
							MPI_Send(&rejection, 1, MPI_INT, number , 0, MPI_COMM_WORLD);	// Reject the new man
						else{ // Otherwise
							MPI_Send(&rejection, 1, MPI_INT, isEngaged, 0, MPI_COMM_WORLD);	// Reject the old man
							isEngaged = number;	// Engaged with new man
						}	
					}
				}
			}
			flag = 0;
		}
		// Send its rank and rank of the her fiance
		MPI_Send( &isEngaged , 1, MPI_INT, 0 , 0, MPI_COMM_WORLD);
    }



	if(rank==0){
		printf("Match:");
		for(int i = 0; i < N; ++i)
			printf("Men:%d Women:%d",i, Match[i]);
		printf("\n");
	}
	 
	ierr = MPI_Finalize();
	if(ierr != MPI_SUCCESS) {
		printf("Error Terminating MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	return 0;
}