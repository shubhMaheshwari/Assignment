#include <iostream>
#include <cmath>
#include <algorithm>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <cmath>
#include <sys/time.h>
#include <mpi.h>


using namespace std;
const double eps = 1e-6;
int myid, numprocs;
//int namelen;
//char processor_name[MPI_MAX_PROCESSOR_NAME];
MPI_Status status;
int col;
double *t1, *t2, *res;
int k = 1;

double VecMulVec(double *a, double *b, int N) {
	double ans = 0;
	for (int i = 0; i < N; i++) {
		ans += a[i] * b[i];
	}
	return ans;
}

int k1 = 100000, k2 = 200000, k3 = 300000;
int tt = 0;

void MatrixMulVec(double **a, double *b, double *r, int M, int N) {
	/*for (int i = 0; i < M; i++) {
		r[i] = 0;
		for (int k = 0; k < N; k++) {
			r[i] += a[i][k] * b[k];
		}
	}*/
	tt++;
	
	//send
	if (tt == 1) {
	for (int m = 1; m < numprocs; m++) {
		int size = 0;
		for (int j = (m -1) * col; j < m * col; j++) {
			for (int i = 0; i < M; i++) {
				t1[size++] = a[i][j];
			}
		}
		//cout<<myid<<' '<<k1 + k * numprocs + m<<' '<<k2 + k * numprocs + m<<endl;
		MPI_Send(t1, size, MPI_DOUBLE, m, k1 + k * numprocs + m, MPI_COMM_WORLD);
	}
	}
	for (int m = 1; m < numprocs; m++) {
		int size2 = 0;
		for (int j = (m -1) * col; j < m * col; j++) {
			t2[size2++] = b[j];
		}
		//cout<<myid<<' '<<k1 + k * numprocs + m<<' '<<k2 + k * numprocs + m<<endl;
		MPI_Send(t2, size2, MPI_DOUBLE, m, k2 + k * numprocs + m, MPI_COMM_WORLD);
	}
	//cout<<"send done"<<endl;
	
	//init
	for (int i = 0; i < M; i++) {
		r[i] = 0;
	}
	//receive
	for (int m = 1; m < numprocs; m++) {
		//cout<<myid<<' '<<k3 + k * numprocs + m<<endl;
		MPI_Recv(res, M, MPI_DOUBLE, m, k3 + k * numprocs + m, MPI_COMM_WORLD, &status);
		for (int i = 0; i < M; i++) {
			r[i] += res[i];
			//if (tt == 1) cout<<i<<' '<<r[i]<<endl;
		}
	}
	//cout<<"receive done"<<endl;
	
	//reset part
	for (int j = (numprocs - 1) * col; j < N; j++) {
		for (int i = 0; i < M; i++) {
			r[i] += a[i][j] * b[j];
			//if (tt == 1) cout<<i<<' '<<r[i]<<endl;
		}
	}
}

void Cal(int M, int N) {
	//cout<<myid<<' '<<k1 + k * numprocs + myid<<' '<<k2 + k * numprocs + myid<<endl;
	tt++;
	if (tt == 1) {
		MPI_Recv(t1, col * M, MPI_DOUBLE, 0, k1 + k * numprocs + myid, MPI_COMM_WORLD, &status);
	}
	MPI_Recv(t2, col, MPI_DOUBLE, 0, k2 + k * numprocs + myid, MPI_COMM_WORLD, &status);
	for (int i = 0; i < M; i++) {
		res[i] = 0;
		for (int j = 0; j < col; j++) {
			res[i] += t1[j * M + i] * t2[j];
			//if (tt == 1) cout<<t1[j * M + i]<<' '<<t2[j]<<' '<<res[i]<<endl;
		}
	}
	//cout<<myid<<' '<<k3 + k * numprocs + myid<<endl;
	MPI_Send(res, M, MPI_DOUBLE, 0, k3 + k * numprocs + myid, MPI_COMM_WORLD);
}

int t = 0;

bool check(double *r, int N) {
	double res = 0;
	for (int i = 0; i < N; i++) {
		res += fabs(r[i]);
	}
	t++;
	/*if (t < 10) {
		for (int i = 0; i < N; i++)
			cout<<r[i]<<' ';
		cout<<endl;
		cout<<res<<endl;
	}*/
	if (res < eps) return true;
	else return false;
}

void solve(double **a, double *b, double *x, double *r, double *p, int M, int N) {
	for (int i = 0; i < N; i++) {
		x[i] = rand() / (RAND_MAX + 1.0);
	}
	double *tmp, *nr;
	tmp = new double [M];
	nr = new double [M];
	MatrixMulVec(a, x, tmp, M, N);
	for (int i = 0; i < M; i++)
		r[i] = b[i] - tmp[i];
	for (int i = 0; i < M; i++)
		p[i] = r[i];
	int flag;
	while (true) {
		k++;
		flag = 0;
		for (int m = 1; m < numprocs; m++) {
			//cout<<0<<' '<<k * numprocs + m<<endl;
			MPI_Send(&flag, 1, MPI_INT, m, k * numprocs + m, MPI_COMM_WORLD);
		}
		MatrixMulVec(a, p, tmp, M, N);
		double alpha = VecMulVec(r, r, M) / VecMulVec(p, tmp, M);
		for (int i = 0; i < N; i++)
			x[i] += alpha * p[i];
		for (int i = 0; i < M; i++)
			nr[i] = r[i] - alpha * tmp[i];
		if (check(nr, M)) break;
		double beta = VecMulVec(nr, nr, M) / VecMulVec(r, r, M);
		for (int i = 0; i < M; i++)
			p[i] = nr[i] + beta * p[i];
		for (int i = 0; i < M; i++)
			r[i] = nr[i];
	}
	delete []tmp;
	delete []nr;
	flag = 1;
	k++;
	for (int m = 1; m < numprocs; m++) {
		MPI_Send(&flag, 1, MPI_INT, m, k * numprocs + m, MPI_COMM_WORLD);
	}
}

void solve2(double **a, double *b, double *x, double *r, double *p, int M, int N) {
	int flag;
	Cal(M, N);
	while (true) {
		++k;
		//cout<<0<<' '<<k*numprocs +myid<<endl;
		MPI_Recv(&flag, 1, MPI_INT, 0, k * numprocs + myid, MPI_COMM_WORLD, &status);
		if (flag == 1)
			break;
		Cal(M, N);
	    //cout<<k<<' '<<flag<<endl;
	}
}

int main (int argc, char* argv[]){
	
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);

	int M, N;

	string T, P, Db;
	M = atoi(argv[1]);
	N = M;

	double elapsedTime, elapsedTime2;
	timeval start, end, end2;

	if(argc > 2) {
		T = argv[2];
		if(argc > 3) {
			P = argv[3];
			if(argc > 4) {
				Db = argv[4];
			}
		}
	}
	
	double **a, *b, *x, *r, *p;
	a = new double *[M];
	b = new double [M];
	x = new double [N];
	r = new double [M];
	p = new double [M];
	
	for (int i = 0; i < M; i++) {
		a[i] = new double [N];
	}
	
	col = N / numprocs;
	t1 = new double[M * col];
	t2 = new double[col];
	res = new double[M];
	
	if (myid == 0) {
		ifstream matrixfile("matrix");
		if(!(matrixfile.is_open())){
			cout<<"Error: file not found"<<endl;
			return 0;
		}
		for(int i = 0; i < M; i++){
			for(int j = 0; j < N; j++){
				matrixfile >> a[i][j];
			}
		}
		for(int i = 0; i < M; i++){
			matrixfile >> b[i];
		}
		matrixfile.close();
	
		gettimeofday(&start, NULL);
		solve(a, b, x, r, p, M, N);
		gettimeofday(&end, NULL);
	
		//Output time and iterations
		if(T == "-t" || P == "-t"){
			elapsedTime = (end.tv_sec - start.tv_sec) * 1000.0;
			elapsedTime += (end.tv_usec - start.tv_usec) / 1000.0;
			cout<<"Time: "<<elapsedTime<<" ms."<<endl<<endl;
		}


		// Output the matrixes for debug
		if(T == "-p" || P == "-p"){
			for (int i = 0; i < N; i++) {
				cout<<x[i]<<endl;
			}
		}

		//Generate files for debug purpouse
		if(Db == "-d" || T == "-d" || P == "-d"){
			ofstream Af;
			Af.open("mpi");
			for (int i = 0; i < N; i++) {
				Af<<x[i]<<endl;
			}
			Af.close();
		}
		for (int i = 0; i < M; i++) {
			delete []a[i];
		}
	} else {
		solve2(a, b, x, r, p, M, N);
	}
	delete []a;
	delete []b;
	delete []x;
	delete []r;
	delete []p;
	delete []t1;
	delete []t2;
	delete []res;
	MPI_Finalize();
	return 0;
}
