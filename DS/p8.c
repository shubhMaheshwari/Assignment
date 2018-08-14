#include<stdio.h>
int main()
{
int t,q,c,len,i;
long int x,sum,st[100009],min[100009],m;

scanf("%d",&t);
while(t--)
{
//printf("t:%d\n",t);
scanf("%d",&q);
sum=0;
len=0;
m=0;
while(q--)
{
scanf("%d",&c);

if(c==1)
{
scanf("%ld",&x);

if(m==0)
min[m++]=x;

else if(min[m-1]>x)
{
min[m]=x;
m++;
}


st[len]=x;
sum+=st[len];
len++;
printf("%ld %ld\n",min[m-1],sum);
}


if(c==2)
{
if(len>0)
sum-=st[len-1];

if(m==0||(m==1&&sum==0))
{
printf("-1 %ld\n",sum);
len=0;
m=0;
continue;
}

if(min[m-1]==st[len-1])
m--;

len--;

printf("%ld %ld\n",min[m-1],sum);
}

/*
for(int i=0;i<len;i++)
printf("st[%d]:%ld ",i,st[i]);
printf("\n");
*/
}



}

return 0;
}
