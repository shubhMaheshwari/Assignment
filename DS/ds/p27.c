#include <stdio.h>
#include <stdlib.h>

int n,m,cnt[110000],deg[110000],u[110000],v[110000];
int *G[110000];
long int *W[110000];
long int w[11000];

int max_node(long int time,int node)
{
	// printf("node:%d\n",node);

	if(time<0)
		return 0;

	if(node==n)
		return 1;

	int i,max=0,val;
	for (i = 0; i <deg[node] ; ++i)
	{
		// printf("neigbour :%d\n",G[node][i]);
		val=max_node(time-W[node][i],G[node][i]);
		if(val!=0)
			val++;
		// printf("%d -> %d  val:%d\n",node,G[node][i],val);

		if(max<val)
			max=val;
	}

	return max;

}

int main()
{
	int i,j;
	long int time;
	scanf("%d %d %ld",&n,&m,&time);

	for(i=1;i<=n;i++)
	{
		deg[i]=0;
		cnt[i]=0;		
	}

	for(i=0;i<m;i++)
	{
		scanf("%d %d %ld",&v[i],&u[i],&w[i]);
		deg[v[i]]++;
	}

	// for (int i = 0; i <=n; ++i)
	// {
	// 	printf("deg[%d]:%d\n",i,deg[i]);
	// }

	for(i=1;i<=n;i++)
			{
				G[i]=(int*)malloc(sizeof(int)*deg[i]);
				W[i]=(long int*)malloc(sizeof(long int)*deg[i]);
			}

	for (i = 0; i < m; ++i)
	{
		// printf("here\n");
		// if(v[i]==1||u[i]==1)
		// {printf("v[%d]:%d u[%d]:%d\n",i,v[i],i,u[i]);
		// printf("cnt[%d]:%d\n",v[i],cnt[v[i]]);
		// printf("cnt[%d]:%d\n",u[i],cnt[u[i]]);
		// }
		
		G[v[i]][cnt[v[i]]]=u[i];
		W[v[i]][cnt[v[i]]]=w[i];
		cnt[v[i]]++;
		// if(v[i]==1||u[i]==1)
		// {
		// printf("G[%d][%d]:%d\n",v[i],cnt[v[i]]-1,G[v[i]][cnt[v[i]]-1]);
		// printf("G[%d][%d]:%d\n",u[i],cnt[u[i]]-1,G[u[i]][cnt[u[i]]-1]);
		// }
	}

// 	for (i = 1; i <=n; ++i)
// 	{
// //		printf("here\n");

// 		for (j = 0; j < deg[i]; ++j)
// 		{
// 			printf("G[%d][%d]:%d W[%d][%d]:%ld\n",i,j,G[i][j],i,j,W[i][j]);
// 		}
// 		printf("\n");
// 	}


	printf("%d\n",max_node(time,1));

	return 0;
}