#include <stdio.h>

int n,len;
int vis[1600],heap[1600];
long int G[1600][1600],x[1600],y[1600];
long int dis[1600],sum;

void swap(int *a,int *b)
{
	*a= *b + *a -(*b=*a);
	return;
}

long int min(long int a,long int b)
{
	return a<b?a:b;
}

long int dist(long int x1,long int y1,long int x2,long int y2)
{
	long int sum=0;
	if(x1>x2)
		sum+=x1-x2;
	else
		sum+=x2-x1;

	if(y1>y2)
		sum+=y1-y2;
	else
		sum+=y2-y1;


	return sum;

}

void insert(int i)
{
	while(i>0&&dis[heap[i]]<dis[heap[((i+1)>>1)-1]])
	{
		swap(&heap[((i+1)>>1)-1],&heap[i]);
		i=((i+1)>>1)-1;
	}

}

void delete()
{
swap(&heap[0],&heap[len-1]);
len--;

		update(0);

return ;
}

void update(int i)
{
int r=i;
while(i>0&&dis[heap[i]]<dis[heap[((i+1)>>1)-1]])
	{
		// printf("case 0 i:%d\n",i);
		swap(&heap[((i+1)>>1)-1],&heap[i]);
		i=((i+1)>>1)-1;
	}

i=r;

int ll=1,rr=2;
while(1)
{
	ll=2*i+1;
	rr=2*i+2;
	if(rr>=len)
		break;

	// printf("i:%d ll:%d rr:%d\n",i,ll,rr );

	if(rr==len&&ll<len&&dis[heap[i]]>dis[heap[ll]])
		{
			// printf("part1\n");
			swap(&heap[i],&heap[ll]);break;}
	else if(rr<len&&ll<len&&dis[heap[ll]]<=dis[heap[rr]]&&dis[heap[ll]]<=dis[heap[i]])
		{
			// printf("part2\n");
			swap(&heap[i],&heap[ll]);i=ll;}

	else if(rr<len&&ll<len&&dis[heap[rr]]<=dis[heap[ll]]&&dis[heap[rr]]<=dis[heap[i]])
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
int xx,t,i,j;
scanf("%d",&t);
while(t--)
	{
		len=0;
		scanf("%d",&n);
		for(i=0;i<n;i++)
			scanf("%ld %ld",&x[i],&y[i]);
		for(i=0;i<n;i++)
			{for (j = 0; j <n ; ++j)
			G[i][j]=dist(x[i],y[i],x[j],y[j]);
			
			vis[i]=0;dis[i]=dist(x[i],y[i],0,0);
			heap[len++]=i;
			insert(i);
			
			}

		// for(i=0;i<n;i++)
		// 	{for (j = 0; j <n ; ++j)
		// 	printf("G[%d][%d]:%ld ",i,j,G[i][j]);
		// 	printf("\n");}

		// for(i=0;i<n;i++)
		// 	printf("heap[%d]:%d dis[%d]:%ld\n",i,heap[i],heap[i],dis[heap[i]]);

		sum=0;
	while(len>0)
		{
			sum+=dis[heap[0]];
			xx=heap[0];
			// printf("removed::x[%d]:%ld y[%d]:%ld\n",xx,x[xx],xx,y[xx]);
			// printf("heap[%d]:%d dis[%d]:%ld\n",0,heap[0],heap[0],dis[heap[0]]);		
			// printf("\n");
			vis[heap[0]]=1;
			delete();
			for(i=0;i<len;i++)
			{dis[heap[i]]=min(dis[heap[i]],G[xx][heap[i]]);update(i);}

// //			printf("updated value\n");
// 			for(i=0;i<len;i++)
// 			{	printf("x[%d]:%ld y[%d]:%ld\n",heap[i],x[heap[i]],heap[i],y[heap[i]]);
// 				printf("heap[%d]:%d dis[%d]:%ld\n",i,heap[i],heap[i],dis[heap[i]]);}
// 				printf("\n");
			
			 }		

		printf("%ld\n",sum);



		}
	
	return 0;
}