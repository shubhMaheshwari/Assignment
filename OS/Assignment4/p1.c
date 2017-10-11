#include <stdio.h> 
#include <stdlib.h>
#include <pthread.h> 
#include <unistd.h>

// Mutex and cond
pthread_mutex_t mutex;
pthread_mutex_t mutexATM;
pthread_mutex_t mutexServe;
pthread_cond_t cond;
pthread_cond_t condATM;
pthread_cond_t condServe;

// Queue and Car threads
int queLow,queHigh,queLength;
int id[100];	
int carLength,carCompleted;
int serving;
pthread_t que[100];

// Attenders threads
int freeAttenders;
pthread_t attenders[3];

// ATM 
int ATM;
int ATMBUSY;

// car thread functions
void enterStation(int);
void *car(void *);
void waitInLine(int);
void goToPump(int);
void pay(int);
void exitStation(int);

// //attender thread functions 
void *attender(void *);
void serveCar(int);
void acceptPayment(int attenderId, int amount);

int main() {
	
	pthread_mutex_init(&mutex, NULL);
	pthread_mutex_init(&mutexATM, NULL);
	pthread_mutex_init(&mutexServe, NULL);
	pthread_cond_init(&cond,NULL);
	pthread_cond_init(&condATM,NULL);
	pthread_cond_init(&condServe,NULL);

	int carLength;
	printf("Enter no of cars:");
	scanf("%d",&carLength);

	queHigh = 0;
	queLow = 0;
	ATM = 0;
	carCompleted =-1;
	serving = 0;

	int attenderId[3]={0,1,2};
	for (int i = 0; i < 3; ++i)
		pthread_create(&attenders[i], NULL, attender, (void*)(attenderId + i));

	enterStation(carLength);

	for (int i = 0; i < queHigh; ++i)	
		pthread_join(que[i], NULL);

	return 0;
}


void enterStation(int carLength){

	for( carCompleted=0; carCompleted < carLength;){
		if(queHigh - queLow < 4 && queHigh - queLow >= 0)
		{
			id[queHigh] = queHigh;	
			printf("%d entering to Que\n",id[queHigh]+1);
			pthread_create(&que[queHigh], NULL, car, (void *)(id + queHigh));
			carCompleted++;
			queHigh++;
			sleep(rand()%3);
		}

		else{
			printf("Que Full(Wait for some time)\n");
			// printf("queLow:%d queHigh:%d\n",queLow,queHigh);
			
			pthread_cond_wait(&cond,&mutex);
		}
	}

	pthread_cond_broadcast(&cond);
	while(queLow !=queHigh)
		pthread_cond_wait(&cond,&mutex);
}

void *car(void *arg){

	int* id = (int*)arg; 

	pthread_mutex_lock(&mutex);
	waitInLine(*id);
	goToPump(*id);
	pthread_mutex_unlock(&mutex);
	pay(*id);
	exitStation(*id);
}

void waitInLine(int id){

	while(id != queLow)
		pthread_cond_wait(&cond,&mutex);
}


void goToPump(int id){

	printf("%d Getting Served\n",id+1);
	while(serving == 3){
		pthread_cond_broadcast(&cond);
		pthread_cond_wait(&cond,&mutex);
	}

	serving++;
	sleep(1);

	queLow++;
}

void pay(int id){

pthread_mutex_lock(&mutexATM);
printf("Car:%d Giving the card to pay\n",id+1);

while(ATMBUSY != 0){
	pthread_cond_broadcast(&condATM);	
	pthread_cond_wait(&condATM,&mutexATM);
}

ATMBUSY = 1;
pthread_cond_broadcast(&condATM);

while(ATMBUSY !=2){
	pthread_cond_broadcast(&condATM);		
	pthread_cond_wait(&condATM,&mutexATM);
}
ATMBUSY = 0;
printf("Car:%d Payment Successful\n",id+1);
pthread_mutex_unlock(&mutexATM);
}


void exitStation(int id){

	printf("%d Exiting Station\n",id+1);
	pthread_cond_broadcast(&cond);

	if(carLength == carCompleted)
		for (int i = 0; i < 3; ++i)	
			pthread_join(attenders[i], NULL);


}


void *attender(void *arg){

	int* id = (int*)arg;

	while(1){
		// printf("Attender: %c is free ATMBUSY:%d\n",'a'+ *id,ATMBUSY);
		
		serveCar(*id);
		acceptPayment(*id,100);
	}

	printf("%c leaving\n",'a'+ *id);
}


void serveCar(int id){

	pthread_mutex_lock(&mutexServe);
	if(serving > 0){
	printf("%c Serving Car\n",'a' + id);
	serving--;
	}
	pthread_mutex_unlock(&mutexServe);


}


void acceptPayment(int id,int amount){

pthread_mutex_lock(&mutexATM);

while(ATMBUSY!=1){
	pthread_cond_broadcast(&condATM);	
	pthread_cond_wait(&condATM,&mutexATM);
}

printf("Attender: %c is entering card to pay\n",'a'+ id);
sleep(0.5);
ATM+=amount;
ATMBUSY = 2;
printf("ATM:%d\n",ATM);
pthread_cond_broadcast(&condATM);
pthread_mutex_unlock(&mutexATM);
}

