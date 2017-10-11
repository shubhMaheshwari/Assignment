#include <stdio.h>

int arr[100005];
int len;


void merge(int low,int mid,int high)
{
	int a[mid - low +1],b[high-mid];

	for (int i = low; i <=mid ; ++i)
		a[i - low] = arr[i];
	
	for (int i = mid+1; i <=high ; ++i)
		b[i - mid -1] = arr[i];
		

	int i=low,j=0,k=0;
	while(j < mid - low + 1 && k < high - mid)
		arr[i++] = a[j] < b[k]?a[j++]:b[k++];
	
	while(j < mid - low + 1)
		arr[i++] = a[j++];

	while(k < high - mid)
		arr[i++] = b[k++];

}


void merge_sort(int low,int high)
{
	if(low<high)
	{
		int mid = low + (high -low)/2 ; 
		merge_sort(low,mid);
		merge_sort(mid+1,high);
		merge(low,mid,high);
	}


}

int main()
{
	len = 0;
	for(;scanf("%d",&arr[len]) != EOF;len++);


	merge_sort(0,len-1);

	for (int i = 0; i < len; ++i)
		printf("%d ",arr[i]);
	printf("\n");


	return 0;
}
