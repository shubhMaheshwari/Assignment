#include <stdio.h>
#include <stdlib.h>

int len,n,m;
int unf[100009],rank[100009];
int flag;
long int ans;


struct edge{
	int s;
	int d;
	long int w;
};

int cmp(const void *a,const void *b)
{

return (*(struct edge*)a).w - (*(struct edge*)b).w;

}

int max(int a,int b)
{
	return a>b?a:b;
}


int find(int u)
{
	if (unf[u] ==u) return u;

	return unf[u]=find(unf[u]);
}


int update(int u,int v)
{
int x=find(u);
int y=find(v);

if(flag==0&&x==y)
return flag=1;

else if(flag==1&&x==y)
	return 0;

else 
{
	if(rank[x]<rank[y])
		{unf[x]=y;
		rank[y]=max(rank[x]+1,rank[y]);}

	else
		{unf[y]=x;
		rank[x]=max(rank[y]+1,rank[x]);}

	return 1;	
}


}


int main()
{
	int i,j,t;
	scanf("%d",&t);

	struct edge* arr;
	while(t--)
	{
	scanf("%d %d",&n,&m);
	flag=0;
	ans=0;

	for(i=0;i<n;i++)
	{unf[i]=i;rank[i]=1;}

	arr=(struct edge*)malloc(sizeof(struct edge)*m);

	for(i=0;i<m;i++)
	{
		scanf("%d %d %ld",&arr[i].s,&arr[i].d,&arr[i].w);
	}


	qsort(arr,m,sizeof(struct edge),cmp);


	// for (i = 0; i < m; ++i)
	// {
	// 	printf("arr:: s:%d d:%d w:%ld\n",arr[i].s,arr[i].d,arr[i].w);
	// }

	for (i = 0; i < m; ++i)
		if(update(arr[i].s,arr[i].d))
			ans+=arr[i].w;

		printf("%ld\n",ans);


	}
	return 0;
}