#include <stdio.h> 

int loc[10005]; //current location of each element
int val[10005]; // value at each position
int a[10005]; //boolean value whether allowed to move or not
int n;


void swap(int x,int y)
{
	loc[x] = loc[x] + loc[y] - (loc[y] = loc[x]);
	val[x] = val[x] + val[y] - (val[y] = val[x]);
}

void permute(int low,int high)
{
	int flag = 1;

	for (int i = 0; i <n ; ++i)
	{
		if(!a[i] && loc[i] <= loc[i+1])
			continue;
		else if(a[i] && loc[i] >= loc[i+1])
			continue;

		else
			{flag=0;break;}

	}


	for (int i = low; i <= high ; ++i)
	{
		swap(i,low);
		permute(low+1,high);
		swap(i,low);
	}

	if(low == high && flag == 1)
	{for (int i = 0; i < n; ++i)
		printf("%d ",val[i]);
	printf("\n");
	}
}


int main()
{

	scanf("%d",&n);
	for (int i = 0; i < n; ++i)
		scanf("%d",&a[i]);


	for (int i = 1; i <= n; ++i)
		loc[i-1]=val[i-1]=i;
		
	permute(0,n-1);

	return 0;
}