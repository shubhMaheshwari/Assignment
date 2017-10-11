#include <stdio.h> 
#include <stdlib.h>
#include <pthread.h> 
#include <unistd.h>

void *func(void *);

int n;
pthread_mutex_t mutex;
pthread_cond_t cond;

int main() {
	
	// scanf("%d",&n);
	n = 0; 
	pthread_mutex_init(&mutex, NULL);
	pthread_t tid[100];
	for (int i = 0; i < 100; ++i)
		pthread_create(&tid[i], NULL, func, NULL);

	pthread_mutex_lock(&mutex);
	n++;
	printf("You are in the main document:%d\n",n);
	n--;
	pthread_mutex_unlock(&mutex);



	for (int i = 0; i < 100; ++i)	
		pthread_join(tid[i], NULL);

	return 0;
}


void *func(void *arg){

	pthread_mutex_lock(&mutex);
	n--;
	printf("You created a new thread:%d\n",n);
	n++;
	pthread_mutex_unlock(&mutex);
}