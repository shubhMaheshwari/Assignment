#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char b[100010];

void merge(int low,int mid,int high)
{
int i;
int x[mid-low+1],y[high-mid];
for(i=low;i<=mid;i++)
x[i-low]=b[i];


for(i=mid+1;i<=high;i++)
y[i-mid-1]=b[i];

int j=0,k=low;
i=0;
while(i<mid-low+1&&j<high-mid)
{
if(x[i]<y[j])
{
b[k]=x[i];
k++;
i++;
}

else
{
b[k]=y[j];
k++;
j++;
}

}

while(i>=mid-low+1&&j<high-mid)
{
b[k]=y[j];
k++;
j++;

}


while(i<mid-low+1&&j>=high-mid)
{
b[k]=x[i];
k++;
i++;
}

}

int msort(int low,int high)
{
if(low<high)
{
int mid=low+(high-low)/2;

msort(low,mid); 
msort(mid+1,high); 
merge(low,mid,high);
}
}

int main()
{
int j,i,n,k,len,r;
char a[100010];
scanf("%d %d",&n,&k);
scanf("%s",a);

if(k>=n)
{
printf("%s\n",a);
return 0;
}

for(i=0;i<k;i++)
{
//printf("i:%d\n",i);

len=0;
for(j=i;j<n;j+=k)
{
b[len]=a[j];
len++;
}

//for(j=0;j<len;j++)
//printf("b[%d]:%c\n",j,b[j]);

msort(0,len-1);

//for(j=0;j<len;j++)
//printf("b[%d]:%c\n",j,b[j]);

len--;
for(j=i;j<n&&len>=0;j+=k)
{

a[j]=b[len];
len--;
}


}

printf("%s\n",a);

return 0;
}
