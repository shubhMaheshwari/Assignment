#include<stdio.h>
#include<stdlib.h>

long int n,m;

int cp(const void *a,const void *b)
{

return *(int*)a-*(int*)b;
}

long int search(long int a[],long int x,long int low,long int high)
{
if(low>=high)
{
if(a[low]<=x)
return n-low-1;
else
return n-low;
}

long int mid=low+(high-low)/2;

if(a[mid]>x)
search(a,x,low,mid);

else if(a[mid]<=x)
search(a,x,mid+1,high);
}

int main()
{
long int i,j;
long int a[100010],b[100010];

scanf("%ld",&n);

for(i=0;i<n;i++)
scanf("%ld",&a[i]);

qsort(a,n,sizeof(long int),cp);

//for(i=0;i<n;i++)
//printf("%ld ",a[i]);
//printf("\n");

scanf("%ld",&m);
for(i=0;i<m;i++)
{
scanf("%ld",&b[i]);
printf("%ld\n",search(a,b[i],0,n-1));
}

return 0;
}
