#include<stdio.h>


int main()
{
int k,n,i,j,count;
long int s[1001],min;
int ind[1001];

scanf("%d",&n);

for(i=0;i<n;i++)
{scanf("%ld",&s[i]);ind[i]=1;}


for(i=0;i<n;i++)
{
min=0;
while(ind[min]==0&&min<n)
min++;

for(j=min+1;j<n;j++)
if(s[j]<s[min]&&ind[j]==1)
min=j;

ind[min]=0;

count=0;
for(j=0;j<n&&count<i;j++)
if(ind[j]==0)
{printf("%d ",j+1);
count++;
}

for(k=j;k<n;k++)
if(ind[k]==0)
{
printf("%d\n",k+1);
break;
}

}

return 0;
}
