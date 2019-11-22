//store index in heap
//multiples of x in heap  


#include <stdio.h>

int n,a,b,count2,count1;
long int x[1000009],y[1000009],time1,time2;
long int p[1000009],q[1000009];
int ind1[1000009],ind2[1000009]; 
void swap(int *a,int *b)
{
//	printf("a:%ld b=%ld\n",*a,*b);
	*b= *a+*b-(*a=*b);
}

long int max(long int a,long int b)
{
	return a>b?a:b;
}


void heapify(long int arr[],int ind[],int len)
{
	int i=len;
	while(i>0&&arr[ind[((len+1)>>1)-1]]>arr[ind[len]])
		{
//	printf("a:%ld b=%ld\n",arr[len],arr[((len+1)>>1)-1]);
			swap(&ind[len],&ind[((len+1)>>1)-1]);
//	printf("a:%ld b=%ld\n",arr[len],arr[((len+1)>>1)-1]);
			len=len>>1;
		}
}


void heaper(long int arr[],int ind[],int i,int n)
{
if(2*(i)+1>n)
return;

int l,r;
l=2*i+1;
r=2*i+2;

//printf("i:%d l:%d r:%d\n",i,l,r);

if(r>=n){
if(arr[ind[l]]<=arr[ind[i]])
{swap(&ind[l],&ind[i]);heaper(arr,ind,l,n);}return;}

if(arr[ind[l]]<arr[ind[i]]&&arr[ind[l]]<=arr[ind[r]])
{
//cout<<"1"<<endl;
//printf("l:%d i:%d n:%d\n",l,i,n );/
//printf("case:1\n");
swap(&ind[l],&ind[i]);heaper(arr,ind,l,n);
}

if(arr[ind[r]]<arr[ind[i]]&&arr[ind[l]]>=arr[ind[r]])
{
//cout<<"2"<<endl;
//	printf("r:%d i:%d n:%d\n",r,i,n );
//printf("case:2\n");	
swap(&ind[r],&ind[i]);heaper(arr,ind,r,n);
}

}

int main()
{
int i;
//make 2 heaps 
//time constrain
//count a,b

scanf("%d %d %d",&n,&a,&b);

for(i=0;i<a;i++)
{scanf("%ld",&p[i]);
 ind1[i]=i;
 x[i]=p[i];
 heapify(x,ind1,i);
}

for (i = 0; i <b; ++i)
{
	scanf("%ld",&q[i]);
	ind2[i]=i;
 	y[i]=q[i];
 heapify(y,ind2,i);
}

// for(i=0;i<a;i++)
// 	printf("x[%d]:%ld\n",i,x[i]);

// 	printf("\n");

// for(i=0;i<b;i++)
// 	printf("y[%d]:%ld\n",i,y[i]);

time1=x[ind1[0]];
count1=0;
count2=0;
while(count1<n||count2<n)
{
if(x[ind1[0]]==0||y[ind2[0]]==0)
	break;

//printf("time1:%ld\n",time1);

if((time1-x[ind1[0]]<0&&count1>count2)||count1>=n)
	time2=y[ind2[0]];

else
while(time1-x[ind1[0]]>=0)
{
count1++;


if(time1>x[ind2[0]])
{
x[ind1[0]]+=time1;
time2=x[ind1[0]];
}

else
{
time2=x[ind1[0]];
x[ind1[0]]+=p[ind1[0]];	

}

if(count1>=n)
break;
heaper(x,ind1,0,a);

for (i = 0; i < a;i++)
printf("x[%d]:%ld\n",ind1[i],x[ind1[i]]);
printf("count1:%d time1:%ld\n",count1,time1);
printf("count2:%d time2:%ld\n",count2,time2);

}

printf("time2:%ld y[%d]:%ld\n",time2,ind2[0],y[ind2[0]]);


if(time2-y[ind2[0]]<0||count2>=count1)
	time1=x[ind1[0]];

else
while(time2-y[ind2[0]]>=0&&count2<count1)
{
	//printf("%d\n",y[ind2[0]] );
if(time2>y[ind2[0]])
{
y[ind2[0]]+=time2;
time1=y[ind2[0]];
}

else
{	
	time1=y[ind2[0]];
	y[ind2[0]]+=q[ind2[0]];
	
}
count2++;

if(count2>=n)
{printf("count2:%d\n",count2);
	break;
}

heaper(y,ind2,0,b);

for (i = 0; i < b;i++)
printf("y[%d]:%ld\n",ind2[i],y[ind2[i]]);
printf("count1:%d time1:%ld\n",count1,time1);
printf("count2:%d time2:%ld\n",count2,time2);

}

//printf("count1:%d count2:%d\n",count1,count2 );
//printf("time1:%ld time2:%ld\n",time1,time2 );

}

printf("%ld\n",time1);
	return 0;
}