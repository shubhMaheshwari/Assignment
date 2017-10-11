#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/shm.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<sys/ipc.h>

int n;
int *arr;

key_t key = IPC_PRIVATE;

void merge_sort(int low, int high);
void merge(int low, int mid, int high);
int main()
{

	scanf("%d",&n);
	int shmid = shmget(key, sizeof(int)*n, IPC_CREAT| 0666);
	if(shmid == -1){
		perror("Shmget failed");
		exit(1);
	}

	arr = shmat(shmid, 0, 0);
	if(arr == (void *)-1) {
		perror("Shmat failed");
		exit(1);
	}

	for (int i = 0; i < n; ++i)
		scanf("%d",&arr[i]);


	merge_sort(0,n-1);

	printf("After sort\n");
	for (int i = 0; i <n ; ++i)
		printf("%d ",arr[i]);	
	printf("\n");

	return 0;
}


void merge_sort(int low, int high){

	if(high - low < 2)
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

		printf("Before sort\n");
		for (int i = low; i <=high ; ++i)
			printf("%d ",arr[i]);	
		printf("\n");

		int mid = low + (high-low)/2;

		pid_t pid = fork();

		if(pid<0) {
		perror("fork Failed");
		exit(1);
		} 


		if(pid == 0){
			merge_sort(low,mid);
			exit(0);
		}

		else{
			wait(NULL);
			merge_sort(mid+1,high);
		}


		merge(low,mid,high);

		printf("After sort\n");
		for (int i = low; i <=high ; ++i)
			printf("%d ",arr[i]);	
		printf("\n");

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