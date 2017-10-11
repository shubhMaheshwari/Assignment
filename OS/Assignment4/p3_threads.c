#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h>
#include <pthread.h>

int n;
int arr[100005];

struct arg_struct{
	int low;
	int high;
};

void *merge_sort(void *);
void merge(int low, int mid, int high);
int main()
{

	scanf("%d",&n);

	for (int i = 0; i < n; ++i)
		scanf("%d",&arr[i]);


	pthread_t t;
	struct arg_struct* args= malloc(sizeof(struct arg_struct)); 

	args->low = 0;
	args->high = n-1;

	pthread_create(&t,NULL,merge_sort,(void*)args);

	pthread_join(t, NULL);

	for (int i = 0; i <n ; ++i)
		printf("%d ",arr[i]);	
	printf("\n");

	return 0;
}


void *merge_sort(void *args){

	int low = ((struct arg_struct*)args)->low;
	int high = ((struct arg_struct*)args)->high;


	if(high - low < 5)
	{
		int i,j,min_idx;
		for (i = low; i < high; i++){
        	min_idx = i;
	        for (j = i+1; j <=high; j++)
	          if (arr[j] < arr[min_idx])
	            min_idx = j;
        	arr[min_idx] = arr[min_idx] + arr[i] - (arr[i] = arr[min_idx]);
    	}

	}

	else{
		pthread_t t1,t2;

		struct arg_struct* args1= malloc(sizeof(struct arg_struct)); 
		struct arg_struct* args2= malloc(sizeof(struct arg_struct)); 

		int mid = low + (high - low)/2;

		args1->low = 0;
		args1->high = mid;

		args2->low = mid+1;
		args2->high = high;

		// printf("Before sort\n");
		// for (int i = low; i <=high ; ++i)
		// 	printf("%d ",arr[i]);	
		// printf("\n");

		pthread_create(&t1,NULL,merge_sort,(void*)args1);
		pthread_create(&t2,NULL,merge_sort,(void*)args2);
	
		pthread_join(t1, NULL);
		pthread_join(t2, NULL);
	
		merge(low,mid,high);

		// printf("After sort\n");
		// for (int i = low; i <=high ; ++i)
		// 	printf("%d ",arr[i]);	
		// printf("\n");

	}

}

void merge(int low, int mid, int high){

	int x = mid - low + 1;
	int y = high - mid;

	int arr1[x],arr2[y];

	for (int i = low; i <=mid ; ++i)
		arr1[i - low] = arr[i];	

	for (int i = mid+1; i <=high ; ++i)
		arr2[i - mid - 1] = arr[i];

	int i=0,j=0,k=low;

	while(i < x && j< y)
		if(arr1[i]<arr2[j])
			arr[k++]=arr1[i++];
		else
			arr[k++]=arr2[j++];

	while(i < x)
		arr[k++] = arr1[i++];

	while(j < y)
		arr[k++] = arr2[j++];

}