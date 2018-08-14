#include <stdio.h>
#include <stdlib.h>

struct node {
	int val;
	long int data;
	int child;
};


int n,cnt[300009],deg[300009],vis[300009],u[300009],v[300009];
int *G[300009];
long int ans,sum;
struct node* tree;

struct node dfs(int x)
{
	struct node r;
	int i;
	vis[x]=1;
	printf("x:%d\n",x);	

	for (i = 0; i < deg[x]; ++i)
	if(vis[G[x][i]]==0)
	{
//		printf("G[%d][%d]:%d vis[%d]:%d\n",x,i,G[x][i],G[x][i],vis[G[x][i]]);
		r=dfs(G[x][i]);
//		printf("r:: val:%d data:%ld child:%d\n",r.val,r.data,r.child);
		ans+=(r.data*r.child)+((sum-r.data)*(n-r.child));
		printf("comp1:%ld \n",(r.data*r.child));
		printf("comp2:%ld \n",((sum-r.data)*(n-r.child)));

	//	printf("ans:%ld\n",ans);
		tree[x].data+=r.data;
		tree[x].child+=r.child;

//		printf("tree[%d]:: val:%d data:%ld child:%d\n",x,tree[x].val,tree[x].data,tree[x].child);
	}


	return tree[x];
}


int main()
{
int i,j;	
sum=0;
ans=0;
scanf("%d",&n);

tree=(struct node*)malloc(sizeof(struct node)*(n+1));

for(i=1;i<=n;i++)
{
	scanf("%d",&tree[i].val);
	tree[i].data=tree[i].val;
	tree[i].child=1;
	deg[i]=0;
	cnt[i]=0;
	vis[i]=0;
	sum+=tree[i].val;
}


	for(i=0;i<n-1;i++)
	{
		scanf("%d %d",&v[i],&u[i]);
		deg[v[i]]++;
		deg[u[i]]++;
	}

//	printf("sum:%ld\n",sum);


	// for (int i = 0; i <=n; ++i)
	// {
	// 	printf("deg[%d]:%d\n",i,deg[i]);
	// }

	for(i=0;i<=n;i++)
			G[i]=(int*)malloc(sizeof(int)*deg[i]);

	for (i = 0; i < n-1; ++i)
	{
		// printf("here\n");
		// if(v[i]==1||u[i]==1)
		// {printf("v[%d]:%d u[%d]:%d\n",i,v[i],i,u[i]);
		// printf("cnt[%d]:%d\n",v[i],cnt[v[i]]);
		// printf("cnt[%d]:%d\n",u[i],cnt[u[i]]);
		// }
		
		G[v[i]][cnt[v[i]]++]=u[i];
		G[u[i]][cnt[u[i]]++]=v[i];
		
		
	}

// 	for (i = 0; i <=n; ++i)
// 	{
// //		printf("here\n");
// 			// printf("tree[%d].val:%d\n",i, );
// 		for (j = 0; j < deg[i]; ++j)
// 		{
// 			printf("G[%d][%d]:%d\n",i,j,G[i][j]);
// 		}
// 		printf("\n");
// 	}


//dfs to store data

for(i=0;i<=n;i++)
if(vis[i]==0)
{
	dfs(i);
}

printf("%ld\n",ans);

//dfs to get answer


	return 0;
}
