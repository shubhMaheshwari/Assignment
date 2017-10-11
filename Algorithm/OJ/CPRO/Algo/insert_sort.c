#include <stdio.h> 

int main()
{
	int arr[100005];
	int len=0,pnt=0,temp;
	for(;scanf("%d",&arr[len]) != EOF;len++)
	{

	for (pnt = len; pnt >=0; pnt--)
		if(arr[pnt] < arr[len])
			break;


	for (int i = pnt+1; i < len ; ++i)
		arr[len] = arr[i] + arr[len] - (arr[i]=arr[len]);
		
	}

	for (int i = 0; i <len; ++i)
		printf("%d ",arr[i]);
	printf("\n");


	return 0;
}