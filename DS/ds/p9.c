#include<stdio.h>

long int min(long int a,long b,long int c)
{
if(a<=b&&a<=c)
return a;

if(b<=a&&b<=c)
return b;

if(c<=b&&c<=a)
return c;
}

int main()
{
int i,n,a,b,c;
long int x[1009];
scanf("%d",&n);

x[0]=1;
a=0;
b=0;
c=0;

for(i=1;i<n;i++)
{
x[i]=min(3*x[a],5*x[b],7*x[c]);

if(x[i]==3*x[a])
a++;

if(x[i]==5*x[b])
b++;

if(x[i]==7*x[c])
c++;

//printf("x[%d]:%ld\n",i,x[i]);
}

printf("%ld",x[n-1]);


return 0;
}
