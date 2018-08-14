#include <stdio.h>
#include <stdlib.h>

int n,m,clr[500009],deg[500009],u[500009],v[500009],cnt[500009],queue[1000009];
int* G[500009];

int bfs(int x,int par)
{
int low=0,high=0,r,i;
queue[high++]=x;
clr[x]=1;

while(high>low)
{
	r=queue[low++];
//	printf("r:%d low:%d high:%d clr[%d]:%d\n",r,low,high,r,clr[r]);

	for(i=0;i<deg[r];i++)
	{
		//printf("here\n");
		if(G[r][i]==r)
			return 1;

		if(clr[G[r][i]]==-1)
		{	
			//printf("here\n");
			clr[G[r][i]]=1-clr[r];
			queue[high++]=G[r][i];
//			printf("Added %d\n",G[r][i]);
		}
		
		else if(clr[G[r][i]]==clr[r]&&G[r][i]!=par)
			return 1;

	}

	// for (i = low; i < high; ++i)
	// {
	// 	printf("queue[%d]:%d clr[%d]:%d\n",i,queue[i],queue[i],clr[queue[i]]);
	// }
	// printf("\n");


}
//printf("here\n");
return 0;
}

int main()
{
	int i,j,flag=0;
	scanf("%d %d",&n,&m);

	for(i=0;i<500009;i++)
	{
		deg[i]=0;
		cnt[i]=0;
		clr[i]=-1;
	}

	for(i=0;i<m;i++)
	{
		scanf("%d %d",&v[i],&u[i]);
		deg[v[i]]++;
		deg[u[i]]++;
	}

	// for (int i = 0; i <=n; ++i)
	// {
	// 	printf("deg[%d]:%d\n",i,deg[i]);
	// }

	for(i=0;i<500009;i++)
			G[i]=(int*)malloc(sizeof(int)*deg[i]);

	for (i = 0; i < m; ++i)
	{
		// printf("here\n");
		// if(v[i]==1||u[i]==1)
		// {printf("v[%d]:%d u[%d]:%d\n",i,v[i],i,u[i]);
		// printf("cnt[%d]:%d\n",v[i],cnt[v[i]]);
		// printf("cnt[%d]:%d\n",u[i],cnt[u[i]]);
		// }
		
		G[v[i]][cnt[v[i]]++]=u[i];
		G[u[i]][cnt[u[i]]++]=v[i];
		
		// if(v[i]==1||u[i]==1)
		// {
		// printf("G[%d][%d]:%d\n",v[i],cnt[v[i]]-1,G[v[i]][cnt[v[i]]-1]);
		// printf("G[%d][%d]:%d\n",u[i],cnt[u[i]]-1,G[u[i]][cnt[u[i]]-1]);
		// }
	}

// 	for (i = 0; i <=n; ++i)
// 	{
// //		printf("here\n");

// 		for (j = 0; j < deg[i]; ++j)
// 		{
// 			printf("G[%d][%d]:%d\n",i,j,G[i][j]);
// 		}
// 		printf("\n");
// 	}



//bfs
		for(i=0;i<n;i++)
		{
			if(clr[i]==-1)
				{flag=bfs(i,i);}	

			if(flag==1)
				break;


		}

		if(i==n)
			printf("Yes\n");
		else 
			printf("No\n");

	return 0;
}