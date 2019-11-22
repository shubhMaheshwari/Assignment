#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define EPSILON 1.0E-20
#define MAX_ITERATIONS 10000

/******************************************************************************/
double ComputeVectorDotProduct(double *Vector1, double *Vector2, int n_rows) {
	int ind;
	double prod;
	for(ind = prod = 0.0; ind<n_rows; prod = prod + Vector1[ind]*Vector2[ind++]);
	return prod;
}

int main(int argc, char *argv[]) {
	MPI_Status status;
    int num_procs, my_id, ierr, n_rows, rows_chunk, iter = 0, a, b, ind;
	double *inp_a, *inp_b, *x_vec, *x_vec_chunk, *A_mat_chunk, *precond_mat_chunk, *buf, *residue_vec_chunk, *hvec_chunk, *dir_vec, *dir_vec_chunk;
	double del0, del1, del0_chunk, del1_chunk, val, tmp, stime, etime;
	

  	ierr = MPI_Init(&argc,&argv);
	ierr = MPI_Comm_size(MPI_COMM_WORLD,&num_procs);
	ierr = MPI_Comm_rank(MPI_COMM_WORLD,&my_id);
    
    if(my_id == 0) {
        FILE *fp;
        int i, j, ind = 0, p, q; 
        fp = fopen (argv[1], "r");
        fscanf(fp, "%d %d", &i, &j);     
        n_rows = i;
        inp_a = (double *) malloc(n_rows*n_rows*sizeof(double));
        inp_b  = (double *)malloc(n_rows*sizeof(double));
        for(p = 0; p < i; p++){
		    for(q = 0; q < j; q++)
                if (q == i) fscanf(fp, "%lf", &inp_b[p]); 
                else fscanf(fp, "%lf", &inp_a[ind++]);
	    }
        fclose(fp);
    }

	ierr = MPI_Barrier(MPI_COMM_WORLD);
	stime = MPI_Wtime();

	ierr = MPI_Bcast(&n_rows, 1, MPI_INT, 0, MPI_COMM_WORLD);
	
    if(my_id != 0) inp_b = (double *) malloc(n_rows*sizeof(double));
	ierr = MPI_Bcast(inp_b, n_rows, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    rows_chunk   = n_rows / num_procs;
	A_mat_chunk = (double *) malloc (rows_chunk * n_rows * sizeof(double));
	ierr = MPI_Scatter(inp_a, rows_chunk * n_rows, MPI_DOUBLE, A_mat_chunk, rows_chunk * n_rows, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    x_vec = (double *) malloc(n_rows*sizeof(double));
    for (ind = 0;ind<n_rows;x_vec[ind++] = 0.0);
    residue_vec_chunk = (double *) malloc(rows_chunk*sizeof(double));
    int GlobalVectorind = my_id * rows_chunk;
	for(a=0; a<rows_chunk; residue_vec_chunk[a++] = -inp_b[GlobalVectorind++]);
	
    precond_mat_chunk = (double *) malloc(rows_chunk*n_rows * sizeof(double));
    ind = 0;
	for(a = 0; a < rows_chunk; a++) for(b=n_rows-1; b>=0; b--) precond_mat_chunk[ind++] = 1.0;

    hvec_chunk = (double *) malloc(rows_chunk*sizeof(double));
	dir_vec_chunk = (double *) malloc(rows_chunk * sizeof(double)); 
    for(ind=0; ind<rows_chunk; hvec_chunk[ind] = residue_vec_chunk[ind++]/1.0);
	for(ind=0; ind<rows_chunk; dir_vec_chunk[ind] = - hvec_chunk[ind++]);
    del0_chunk = ComputeVectorDotProduct(residue_vec_chunk,hvec_chunk, rows_chunk);
    ierr = MPI_Allreduce(&del0_chunk, &del0, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);

	buf = (double *) malloc(rows_chunk*sizeof(double));
	x_vec_chunk = (double *)malloc(rows_chunk*sizeof(double));
    dir_vec = (double *) malloc(n_rows*sizeof(double));
	
    if(EPSILON > del0){
		ierr = MPI_Finalize();
		exit(0);
	}
	
    while(iter < MAX_ITERATIONS) {

        iter++;
		ierr = MPI_Allgather(dir_vec_chunk, rows_chunk, MPI_DOUBLE, dir_vec, rows_chunk, MPI_DOUBLE, MPI_COMM_WORLD);
        for(ind=0; ind<rows_chunk; buf[ind] = ComputeVectorDotProduct(&A_mat_chunk[(ind++)*n_rows], dir_vec, n_rows));
		tmp = ComputeVectorDotProduct(dir_vec_chunk, buf, rows_chunk);
        ierr = MPI_Allreduce(&tmp, &val, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);

		ind = 0;
        for(ind < rows_chunk) {
			residue_vec_chunk[ind] = residue_vec_chunk[ind] + (del0 / val)*buf[ind];
            x_vec_chunk[ind] = x_vec[my_id*rows_chunk + ind] + (del0 / val)*dir_vec_chunk[ind++];
        }

        ierr = MPI_Allgather(x_vec_chunk, rows_chunk, MPI_DOUBLE, x_vec, rows_chunk, MPI_DOUBLE, MPI_COMM_WORLD);
		for(ind=0; ind<rows_chunk; hvec_chunk[ind] = residue_vec_chunk[ind++]/1.0);
		del1_chunk = ComputeVectorDotProduct(residue_vec_chunk, hvec_chunk, rows_chunk);
        ierr = MPI_Allreduce(&del1_chunk, &del1, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
		if (del1 < EPSILON) break;
        for(ind=0; ind<rows_chunk; dir_vec_chunk[ind] = (del1/del0)*dir_vec_chunk[ind] - hvec_chunk[ind++]);
        del0 = del1;
	}

	ierr = MPI_Barrier(MPI_COMM_WORLD);
	etime = MPI_Wtime();

    if (my_id == 0) {
        FILE *fp;
        fp = fopen("./output", "w");
        for (a = 0; a < n_rows; fprintf(fp, "%.3lf ", x_vec[a++]));
        fprintf(fp, "\n");
        fclose(fp);
        printf("Number of iterations = %d\n",iter);
        printf("Time Taken :%lf\n", etime - stime);
    }
	ierr = MPI_Finalize();
}


