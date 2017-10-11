// use gcc threads.c -lpthread

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

int sum;

void *runner(void *param){
	int n = atoi(param);


	for (int i = 0; i < n; ++i)
		sum+= i;

	pthread_exit(0);

}


int main(int argc, char *argv[])
{
 if(argc != 2)
 	return 0;

 pthread_t tid;
 pthread_attr_t attr;

 pthread_attr_init(&attr);
 pthread_create(&tid,&attr,runner,argv[1]);
 pthread_join(tid,NULL);

 printf("%d\n",sum);

	return 0;
}