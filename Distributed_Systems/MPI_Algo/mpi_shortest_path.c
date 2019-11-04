#include <algorithm>
#include <mpi.h>
using namespace std;

const int INF = 9999; //big enough number, bigger than any possible path

int adj[100][100]; //adjacency matrix
bool visited[100]; //nodes done
int D[100]; //distance

int nproc, id;
int N;
int S;

struct REDUCE_MPI_STRUCT{
    int dist;
    int node;
};

int main(int argc, char **argv) {

    // Init
    int ierr;
    ierr = MPI_Init(&argc, &argv);
    if(ierr != MPI_SUCCESS) {
        printf("Error starting MPI program. Terminating. \n");
        MPI_Abort(MPI_COMM_WORLD, ierr);
    }

    MPI_Comm_size(MPI_COMM_WORLD, &nproc);
    MPI_Comm_rank(MPI_COMM_WORLD, &id);

    if (id == 0){
        int m;
        scanf("%d %d %d",&N,&m,&S);
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                adj[i][j] = INF;
            }
        }
        for (int i = 0; i < m; ++i){
            int u,v,w;
            scanf("%d %d %d",&u,&v,&w);
            adj[u][v] = w;
            adj[v][u] = w;

            if(u==S)
                D[v] = adj[S][v];

            if(v==S)
                D[u] = adj[S][u];

        }

    }
    
    MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(&S, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(adj, 100 * 100, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(D, 100, MPI_INT, 0, MPI_COMM_WORLD);

    D[S] = 0;
    visited[S] = true;
    int tmp, x;
    for (int j = 1; j < N; j++) {
        tmp = INF;
        for (int i = id; i < N; i += nproc) {
            if(!visited[i])
                if(D[i] < tmp) {
                    x = i;
                    tmp = D[i];
                }

        }

        REDUCE_MPI_STRUCT* p = (REDUCE_MPI_STRUCT *)malloc(sizeof(REDUCE_MPI_STRUCT));
        REDUCE_MPI_STRUCT* tmp_p = (REDUCE_MPI_STRUCT *)malloc(sizeof(REDUCE_MPI_STRUCT));
        p->dist = tmp;
        p->node = x;

        MPI_Allreduce(p, tmp_p, 1, MPI_2INT, MPI_MINLOC, MPI_COMM_WORLD);

        x = tmp_p->node;
        D[x] = tmp_p->dist;
        visited[x] = true;

        for (int i = id; i < N; i += nproc) {
            if(visited[i])
                if(D[i] > D[x] + adj[x][i]){
                    D[i] = D[x] + adj[x][i];
                }
        }
    }

    if (id == 0) {
        printf("Shortest Path from node:%d\n",S);
        for (int i = 0; i < N; ++i) {
            printf("Node:%d Dist:%d\n",i,D[i] );
        }
    }
    MPI_Finalize();
}