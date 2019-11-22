#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {

	MPI_Status status;     
	int ierr, n_rows, rows_chunk, i, j, p, q, num_procs, my_id, a, b, c, piv_col, proc = 0;
	double *inp_A, *inp_B, *rec_A, *rec_B, *out, piv, *x_buf, *y_buf, *piv_buf, *bksub_buf, tmp, stime, etime; 

	ierr = MPI_Init(&argc, &argv); 
	ierr = MPI_Comm_rank(MPI_COMM_WORLD, &my_id);
	ierr = MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

	if(my_id == 0) {
		FILE *fp;
		fp = fopen(argv[1], "r");
		fscanf(fp, "%d %d", &i,&j);     
		n_rows = i;
		int ind = 0;
		inp_A = (double *) malloc(n_rows * n_rows * sizeof(double));
		inp_B = (double *) malloc(n_rows * sizeof(double));
		for(p = 0; p < i; p++){
			for(q = 0; q < j; q++) {
				if (q == i) fscanf(fp, "%lf", &inp_B[p]);	
				else fscanf(fp, "%lf", &inp_A[ind++]);
			}
		}
		fclose(fp); 
	}

	ierr = MPI_Barrier(MPI_COMM_WORLD);
	stime = MPI_Wtime();

	ierr = MPI_Bcast(&n_rows, 1, MPI_INT, 0, MPI_COMM_WORLD); 
	rows_chunk = n_rows/num_procs;
	rec_A = (double *) malloc (rows_chunk * n_rows * sizeof(double));
	rec_B = (double *) malloc (rows_chunk * sizeof(double));
	ierr = MPI_Scatter (inp_A, rows_chunk * n_rows, MPI_DOUBLE, rec_A, rows_chunk * n_rows, MPI_DOUBLE, 0, MPI_COMM_WORLD);
	ierr = MPI_Scatter (inp_B, rows_chunk, MPI_DOUBLE, rec_B, rows_chunk, MPI_DOUBLE, 0, MPI_COMM_WORLD);
	
	piv_buf = (double *) malloc ((n_rows * rows_chunk + rows_chunk + 1) * sizeof(double));
	while(proc < my_id) {
		ierr = MPI_Recv(piv_buf, n_rows * rows_chunk + rows_chunk + 1, MPI_DOUBLE, proc, proc, MPI_COMM_WORLD, &status);
		a = 0;
		while(a < rows_chunk) {	
			piv_col  =  ((int) piv_buf[0]) * rows_chunk + a;
			b = 0;
			while(b < rows_chunk) {	
				tmp = rec_A[b*n_rows + piv_col];
				for (c = piv_col; c < n_rows; rec_A[b*n_rows + c] = rec_A[b*n_rows + c] - (tmp * piv_buf[a*n_rows + (c++) + 1 + rows_chunk]));
				rec_B[b] -= tmp * piv_buf[1+a];
				rec_A[(b++)*n_rows + piv_col]  =  0.0;
			}
			a++;
		}
		a = 0;
		proc++;
	}

	y_buf = (double *) malloc (rows_chunk * sizeof(double));
	a = 0;
	i = 1;
	while(a < rows_chunk) {
		piv_col = my_id * rows_chunk + a;
		piv = rec_A[a * n_rows + piv_col];
		if (piv == 0) exit(0);
		for (c = piv_col; c < n_rows; c++) piv_buf[a * n_rows + c + 1 + rows_chunk] = rec_A[a * n_rows + c] = rec_A[a * n_rows + c]/piv;
		y_buf[a] = rec_B[a]/piv;
		piv_buf[a+1] = y_buf[a];
		b = a+1;
		while(b<rows_chunk) {
			tmp = rec_A[b*n_rows + piv_col];
			for (c = piv_col+1; c < n_rows; rec_A[b*n_rows+c] = rec_A[b*n_rows+c] - tmp * piv_buf[a*n_rows + (c++) + 1 + rows_chunk]);
			rec_B[b] -= tmp * y_buf[a];
			rec_A[(b++)*n_rows+a] = 0;
		}
		a++;
	}

	while(i+my_id < num_procs) {
		piv_buf[0] = (double) my_id;
		ierr = MPI_Send(piv_buf, n_rows * rows_chunk + rows_chunk + 1, MPI_DOUBLE, ((i++) + my_id), my_id, MPI_COMM_WORLD);
	} 
	i = 1;
	bksub_buf = (double *) malloc (2*rows_chunk * sizeof(double));
	x_buf = (double *) malloc (rows_chunk * sizeof(double));
	while(i+my_id < num_procs) {
		ierr = MPI_Recv(bksub_buf, 2*rows_chunk, MPI_DOUBLE, i+my_id, i+my_id, MPI_COMM_WORLD, &status); 
		for (a  = rows_chunk-1; a >= 0; a--) for (c = rows_chunk-1;c >= 0; y_buf[a] = y_buf[a] - bksub_buf[rows_chunk+c] * rec_A[(int) (a*n_rows+bksub_buf[c--])]);
		i++;
	}
	
	i = 1;
	while(rows_chunk-i >= 0) {
		bksub_buf[rows_chunk-i] = (double) (my_id*rows_chunk + rows_chunk - i);
		bksub_buf[rows_chunk + rows_chunk - i] = x_buf[rows_chunk - i] = y_buf[rows_chunk - i];
		for (b = rows_chunk-i-1; b >= 0; y_buf[b] = y_buf[b] -  x_buf[rows_chunk-i] * rec_A[(int)((b--)*n_rows + bksub_buf[rows_chunk-i])]);
		i++;
	}

	for (proc = 0; proc < my_id; ierr = MPI_Send(bksub_buf, 2*rows_chunk, MPI_DOUBLE, proc++, my_id, MPI_COMM_WORLD));
	out = (double *) malloc (n_rows * sizeof(double));
	ierr = MPI_Gather(x_buf, rows_chunk, MPI_DOUBLE, out, rows_chunk, MPI_DOUBLE, 0, MPI_COMM_WORLD);

	ierr = MPI_Barrier(MPI_COMM_WORLD);
	etime = MPI_Wtime();

	if (my_id == 0) {
		FILE *fp;
        fp = fopen("./output", "w");
        for (a = 0; a < n_rows; fprintf(fp, "%.3lf ", out[a++]));
        fprintf(fp, "\n");
        fclose(fp);
        printf("Time Taken :%lf\n", etime - stime);
	}
	ierr = MPI_Finalize(); 
}