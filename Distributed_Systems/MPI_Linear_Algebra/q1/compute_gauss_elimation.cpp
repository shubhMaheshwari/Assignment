// Parallel Stable Marriage algorithm 

#include <stdio.h>
#include <stdlib.h>
#include <iostream> 
#include <fstream> 
#include <mpi.h>

float A[100];
float old_col[100];
float B[100];

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

	// Get data
	const char* filepath = argv[1];
	std::string line;
	printf("Filepath:%s\n",filepath);

	std::ifstream file(filepath);
	if (file.is_open()) {
		std::string line;

		getline(file, line); // Skip first line

		for(int i=0;getline(file, line);i++) {
			// Parse string using delimeter ","
			size_t pos = 0;
			std::string token; 
			for(int j=0; (pos = line.find(",")) != std::string::npos;j++) {
				if(j==rank){
					token = line.substr(0, pos);
					A[i] = std::stof(token);
				}

				line.erase(0, pos + 1);
			}

			token = line.substr(0, pos);
			B[i] = std::stof(token);

		}
		file.close();

		printf("%d A:",rank);
		for (int i = 0; i < num_process; ++i)
			printf("%f ",A[i]);
		printf("\n");

		printf("%d B:",rank);
		for (int i = 0; i < num_process; ++i)
			printf("%f ",B[i]);
		printf("\n");

	}
	else{
		printf("Unable to open the file. Exiting...\n");
		return 0;
	}







	// Exit
	ierr = MPI_Finalize();
	if(ierr != MPI_SUCCESS) {
		printf("Error Terminating MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}
	return 0;

}