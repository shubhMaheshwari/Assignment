#include <stdio.h>
#include <stdlib.h>

int len,n,m,indeg[3009],outdeg[3009],u[3009],v[3009],cnt[3009],heap[3009],vis[3009];
int* G[3009];

void swap(int *a,int *b)
{
	*a= *b + *a -(*b=*a);
	return;
}

void insert()
{
int i=len-1;


	while(i>1&&heap[i]>heap[i>>1])
	{
		swap(&heap[i>>1],&heap[i]);
		i=i>>1;
	}

}

void delete()
{
swap(&heap[1],&heap[len-1]);
len--;

int i=1;
int ll=2,rr=3;
while(1)
{
	ll=2*i;
	rr=2*i+1;
	if(rr>len)
		break;

	// printf("i:%d ll:%d rr:%d\n",i,ll,rr );

	if(rr==len&&ll<len&&heap[i]<heap[ll])
		{
			// printf("part1\n");
			swap(&heap[i],&heap[ll]);break;}
	else if(rr<len&&ll<len&&heap[ll]>=heap[rr]&&heap[ll]>=heap[i])
		{
			// printf("part2\n");
			swap(&heap[i],&heap[ll]);i=ll;}

	else if(rr<len&&ll<len&&heap[rr]>=heap[ll]&&heap[rr]>=heap[i])
		{	
			// printf("part3\n");
		swap(&heap[i],&heap[rr]);i=rr;}

	else 
		break;

}

return ;
}

int main()
{
	int i,j,t,x;
	int p_arr[3009];
	int p_len;
	scanf("%d",&t);

	while(t--)
	{
	scanf("%d %d",&n,&m);

	for(i=1;i<3009;i++)
	{
		indeg[i]=0;
		cnt[i]=0;
		vis[i]=0;
		outdeg[i]=0;
	}

	for(i=0;i<m;i++)
	{
		scanf("%d %d",&v[i],&u[i]);
		indeg[u[i]]++;
		outdeg[v[i]]++;
	}

	// for (int i = 1; i <=n; ++i)
	// {
	// 	printf("deg[%d]:%d\n",i,deg[i]);
	// }

	for(i=1;i<3009;i++)
			G[i]=(int*)malloc(sizeof(int)*indeg[i]);

	for (i = 0; i < m; ++i)
	{
		// printf("here\n");
		// if(v[i]==1||u[i]==1)
		// {printf("v[%d]:%d u[%d]:%d\n",i,v[i],i,u[i]);
		// printf("cnt[%d]:%d\n",v[i],cnt[v[i]]);
		// printf("cnt[%d]:%d\n",u[i],cnt[u[i]]);
		// }
		G[u[i]][cnt[u[i]]++]=v[i];
		
		// if(v[i]==1||u[i]==1)
		// {
		// printf("G[%d][%d]:%d\n",v[i],cnt[v[i]]-1,G[v[i]][cnt[v[i]]-1]);
		// printf("G[%d][%d]:%d\n",u[i],cnt[u[i]]-1,G[u[i]][cnt[u[i]]-1]);
		// }
	}

// 	for (i = 1; i <=n; ++i)
// 	{
// //				printf("here\n");

// 		for (j = 0; j < indeg[i]; ++j)
// 		{
// 			printf("G[%d][%d]:%d\n",i,j,G[i][j]);
// 		}
// 		printf("\n");
// 	}

	len=1;
	p_len=0;
	for (i = 1; i <=n; ++i)
		{
			if(outdeg[i]==0)
			{
				// printf("%d len:%d\n",i,len );
				vis[i]=1;
				heap[len++]=i;
				insert();
				
			}
		}	

			// for(i=1;i<len;i++)
			// printf("heap[%d]:%d ",i,heap[i]);
			// printf("\n");

		while(len>1)
		{
			x=heap[1];
			p_arr[p_len++]=x;
			delete();


			// for(i=1;i<len;i++)
			// printf("heap[%d]:%d ",i,heap[i]);
			// printf("\n");


			// printf("outdeg:%d\n",outdeg[x]);
			for(i=0;i<indeg[x];i++)
			{
				outdeg[G[x][i]]--;
				// printf("outdeg[%d]:%d\n",G[x][i],outdeg[G[x][i]]);
				if(outdeg[G[x][i]]==0&&vis[G[x][i]]==0)
				{
					vis[G[x][i]]=1;
					heap[len++]=G[x][i];
					insert();
					// printf("\ninserted %d\n",G[x][i]);

					}
				// 	for(j=1;j<len;j++)
				// printf("heap[%d]:%d ",j,heap[j]);
				// printf("\n");
			}

			

		}

		for (i =p_len-1;i >=0;--i)
		printf("%d ",p_arr[i]);

		printf("\n");
	}

	return 0;
}