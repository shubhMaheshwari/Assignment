 #include <stdio.h>
#include <stdlib.h>

int clr[100009],low,high;

struct pair
{
int first;
int second;
};

int cmp(const void* a,const void* b)
{
	return (((struct pair *)a)->first - ((struct pair *)b)->first);
}

int main()
{
	int n,m,i,flag;
	scanf("%d %d",&n,&m);
	
struct pair* a=(struct pair*)malloc(sizeof(struct pair)*2*m);

	for(i=0;i<m;i++)
	{scanf("%d %d",&a[i].first,&a[i].second);
	a[i+m].first=a[i].second;
	a[i+m].second=a[i].first;
	}

	for(i=0;i<100009;i++)
		clr[i]=-1;

	qsort(a,2*m,sizeof(struct pair),cmp);

	// for (i = 0; i < 2*m; ++i)
	// printf("a[%d]::first:%d second:%d\n",i,a[i].first,a[i].second);

	for(i=0;i<2*m&&flag==0;i++)
	{
		while(clr[a[i].first]!=-1&&i<2*m&&flag==0)
		{			
			if(clr[a[i].second]==-1)
				clr[a[i].second]=1-clr[a[i].first];
		
			else
				if(clr[a[i].first]==clr[a[i].second])
					flag=1;
		
//	printf("while =i:%d clr[%d]:%d clr[%d]:%d\n",i,a[i].first,clr[a[i].first],a[i].second,clr[a[i].second]);			

			i++;
		}
		if(i==2*m||flag==1)
		break;		

			if(clr[a[i].second]==-1)
				{
				clr[a[i].first]=1;
				clr[a[i].second]=0;
				}
		
			else
				clr[a[i].first]=1-clr[a[i].second];

//	printf("for =i:%d clr[%d]:%d clr[%d]:%d\n",i,a[i].first,clr[a[i].first],a[i].second,clr[a[i].second]);			

	}
	if (flag==1)
		printf("No\n");
	else
		printf("Yes\n");

	return 0;
}