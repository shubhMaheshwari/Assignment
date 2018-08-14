#include<stdio.h>

void swap(long int arr[],int a,int b)
{
int t;
t=arr[b];
arr[b]=arr[a];
arr[a]=t;
}

void heapify(long int arr[],int i,int n)
{
if(2*(i)+1>n)
return;

int l,r;
l=2*i+1;
r=2*i+2;


//printf("i:%d l:%d r:%d\n",i,l,r);


if(r>n)
if(arr[l]>arr[i])
{swap(arr,l,i);heapify(arr,l,n);}

if(arr[l]>arr[i]&&r<=n&&arr[l]>=arr[r])
{
//cout<<"1"<<endl;
swap(arr,l,i);heapify(arr,l,n);
}

if(arr[r]>arr[i]&&r<=n&&arr[l]<arr[r])
{
//cout<<"2"<<endl;
swap(arr,r,i);heapify(arr,r,n);
}

}

int main()
{
int i,n;
long int arr[100010];

n=0;

char w;
while(1<2)
{
scanf("%c",&w);

if(w=='#')
break;

else if(w=='-')
{
if(n==0)
{printf("-1\n");continue;}

//printf("n:%d\n",n);

printf("%ld\n",arr[0]);
swap(arr,n-1,0);
n--;
heapify(arr,0,n-1);
}

else if(w=='+')
{
scanf("%ld",&arr[n]);

for(i=n/2;i>=0;i--)
heapify(arr,i,n);

n++;
}


//for(int i=0;i<n;i++)
//printf("arr[%d]:%ld ",i,arr[i]);
//printf("\n");
}
return 0;
}
