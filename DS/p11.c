#include<stdio.h>
#include<stdlib.h>

long long int i,n,len;
long long int time,sum;

struct pair
{
	long long int t;
	long long int l;
};

int cmp(const void *a,const void *b)
{

	struct pair* aa=(struct pair *)malloc(sizeof(struct pair));
	struct pair* bb=(struct pair *)malloc(sizeof(struct pair));
	aa=(struct pair *)a;
	bb=(struct pair *)b;

	if(aa->t > bb->t)
	return 1;
	if(aa->t == bb->t)
	return 0;
	else
	return -1;
}

void swap(struct pair* a,struct pair* b)
{
	struct pair* c=(struct pair*)malloc(sizeof(struct pair));

	*c=*a;
	*a=*b;
	*b=*c;
}


void hin(struct pair heap[],long long int o)
{

	while(o>1&&heap[o>>1].l>=heap[o].l)
	{
//	printf("o:%lld\n",o);
		swap(&heap[o>>1],&heap[o]);
		o=o>>1;
	}

}
/*
void hrem(struct pair heap[])
{
	printf("hrem len:%d\n",len);
	long long int ll,rr;
	long long int o=1;
	swap(&heap[1],&heap[len-1]);
	len--;
	
	while(o<len)
	{

		ll=o<<1;
		rr=ll+1;
	        printf("o:%d ll:%d rr:%d\n",o,ll,rr); 

		if(ll>=len&&heap[ll].l<heap[o].l)
		{swap(&heap[ll],&heap[o]);break;}

		if(heap[ll].l<heap[o].l&&heap[ll].l<=heap[rr].l)
		{printf("case1:\n");swap(&heap[ll],&heap[o]);o=o<<1;continue;}

		if(heap[rr].l<heap[o].l&&heap[ll].l>=heap[rr].l)
		{printf("case2\n");swap(&heap[rr],&heap[o]);o=o<<1;o++;continue;}

		break;	
	}

}
*/


void hrem(struct pair heap[])
{

//printf("hrem\n");

//printf("len:%lld \n",len);
//printf("heap[%lld].l:%lld heap[%lld].l:%lld\n",1,heap[1].l,len-1,heap[len-1].l);
swap(&heap[1],&heap[len-1]);
//printf("heap[%lld].l:%lld heap[%lld].l:%lld\n",1,heap[1].l,len-1,heap[len-1].l);
long long int o=1,ll=2,rr=3;
len--;

//printf("len:%lld o:%lld ll:%lld rr:%lld  \n",len,o,ll,rr);

while(2*o<len)
{

ll=o*2;
rr=ll+1;

//printf("o:%lld ll:%lld rr:%lld len:%lld\n",o,ll,rr,len);

if(rr==len&&heap[ll].l<=heap[o].l)
{
swap(&heap[o],&heap[ll]);
break;
}

else if(heap[ll].l<=heap[o].l&&heap[ll].l<=heap[rr].l&&rr<len)
{
swap(&heap[o],&heap[ll]);
o=o*2;
continue;
}

else if(heap[rr].l<=heap[o].l&&heap[rr].l<=heap[ll].l&&rr<len)
{
swap(&heap[o],&heap[rr]);
o=o*2+1;
}

else
break;
}
}

int main()
{

	scanf("%lld",&n);
	
	if(n==0)
	{
	printf("0\n");
	return 0;	
	}

	if(n==1)
	{
		scanf("%lld %lld",&time,&sum);
		printf("%lld\n",sum);
		return 0;
	}	

	struct pair* p=(struct pair *)malloc(sizeof(struct pair)*n);
	struct pair* heap=(struct pair *)malloc(sizeof(struct pair)*n);



	for(i=0;i<n;i++)
		scanf("%lld %lld",&p[i].t,&p[i].l);


	qsort(p,n,sizeof(struct pair),cmp);

//	for(i=0;i<n;i++)
//		printf(" p[%lld]:: t:%lld l:%lld\n",i,p[i].t,p[i].l);

	i=0;
	sum=0;
	len=1;
	time=0;
	while(i<n)
	{


		while(p[i].t<=time&&i<n)
		{
//			printf("p[%lld].t:%lld time:%lld\n",i,p[i].t,time);
			heap[len]=p[i];
			hin(heap,len);
			len++;
			i++;

//			printf("INserting\n");	
//			for(int j=1;j<len;j++)
//				printf("heap[%lld]:: t:%lld l:%lld\n",j,heap[j].t,heap[j].l);

		}

		if(len>1)		
		{		
			time+=heap[1].l;
			sum+=(time-heap[1].t);
			
			hrem(heap);	
		}

		else
		time=p[i].t;
	

//		for(int j=1;j<len;j++)
//			printf("heap[%lld]:: t:%lld l:%lld\n",j,heap[j].t,heap[j].l);
//			printf("sum:%lld len:%lld time:%lld\n",sum,len,time);

	}


	while(len>1)
	{
		time+=heap[1].l;
		sum+=(time-heap[1].t);
		hrem(heap);
//		for(int j=1;j<len;j++)
//			printf("heap[%lld]:: t:%lld l:%lld\n",j,heap[j].t,heap[j].l);
//		printf("sum:%lld len:%lld time:%lld\n",sum,len,time);
	}
sum=sum/n;
	printf("%lld\n",sum);
	return 0;
}
