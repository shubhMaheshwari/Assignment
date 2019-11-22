// Parallel Stable Marriage algorithm 
#include <stdio.h>
#include <stdlib.h>
#include <iostream> 
#include <vector> 
#include <fstream> 
#include <mpi.h>

using namespace std;

const double eps = 1e-6; // Minimum Error and 
MPI_Status status;

// Need to comute the dot product between 2 vectors and return a scalar value
double inner_product(vector<double> x,vector<double> y){
	// @param a => Vector a of size N
	// @param b => Vector b of size N
	// @return val => dot product of 2 vectors

	if(x.size() != y.size()){
		// If a and b are not of same dimensions return 0
		printf("Vector A and Vector B are not equal.\n");
		return 0.0;
	}

	// Compute dot product 
	int N = x.size();
	int val = 0.0;
	for (int i = 0; i < N; ++i){
		val += x[i]*y[i];
	}

	return val;
}

// Given matrix A and vector x we need to compute dot(A,x)
int send_mat_product(float** a ,float *b,int rank,int M){
	// @param a => Matrix a of size N,M
	// @param x => Vector b of size M
	// @return Ax => dot product of 2 vectors of size N

	int* send_a = (int*)malloc(N*(M+1)*sizeof(int));
	for (int i = 0; i < N; ++i){
		for (int j = 0; j < M; ++j)
			send_a[i*M+j] = a[i][j];
		send_a[(i+1)*M] = b[i];
	}


	MPI_Bcast(send_a, N*(M+1), MPI_DOUBLE, rank, MPI_COMM_WORLD);
	// Synchronize again
	MPI_Barrier(MPI_COMM_WORLD);
	return 0;
}

// Given matrix A and vector x we need to compute dot(A,x)
vector<double>  cal_mat_product(vector<vector<double> > a,vector<double> b){
	// @param a => Matrix a of size N,M
	// @param x => Vector b of size M
	// @return Ax => dot product of 2 vectors of size N

	int N = a.size();
	int M = a[0].size();


	vector<double> Ax;  

	if(M != b.size()){
		// Return an empty vector
		printf("Matrix A and Vector B are not equal.\n");
		return Ax;
	}

	for (int i = 0; i < N; ++i)
	{
		int val = 0.0;
		for (int j = 0; j < M; ++j){
			val += a[i][j]*b[j];
		}

		Ax.push_back(val);
	}

	return Ax;
}

int solve_master(){
	return 0;
}

int solve_slave(){
	return 0;
}




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
	int N = atoi(argv[1]);
	int M = atoi(argv[2]);
	M--; // Extra column to store B
	double A[1024][1024];
	double B[1024];


	const char* filepath = argv[3];
	std::string line;
	printf("Filepath:%s N:%d M:%d\n",filepath,N,M);

	std::ifstream file(filepath);
	if (file.is_open()) {
		std::string line;

		getline(file, line); // Skip first line

		for(int i=0;getline(file, line);i++) {
			// Parse string using delimeter ","
			size_t pos = 0;
			std::string token; 
			for(int j=0; (pos = line.find(",")) != std::string::npos;j++) {
				token = line.substr(0, pos);
				A[i][j] = std::stof(token);

				line.erase(0, pos + 1);
			}

			token = line.substr(0, pos);
			B[i] = std::stof(token);

		}
		file.close();

		printf("%d A:\n",rank);
		for (int i = 0; i < N; ++i){
			for (int j = 0; j < M; ++j)
				printf("%lf ",A[i][j] );
			
			printf("\n");
			}

		printf("%d B:",rank);
		for (int i = 0; i < M; ++i)
			printf("%lf ",B[i]);
		printf("\n");

	}
	else{
		printf("Unable to open the file. Exiting...\n");
		return 0;
	}


	if(rank==0)
		solve_master();
	else
		solve_slave();

	// Exit
	ierr = MPI_Finalize();
	if(ierr != MPI_SUCCESS) {
		printf("Error Terminating MPI program. Terminating. \n");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}
	return 0;

}