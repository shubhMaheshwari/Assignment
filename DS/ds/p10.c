#include<stdio.h>
int main()
{
int sum[3]={0,0,0};
int j,i,t,a[100009][3],h[3];

scanf("%d",&t);

while(t--)
{
sum[0]=0;
sum[1]=0;
sum[2]=0;

for(j=0;j<3;j++)
{
scanf("%d",&h[j]);

for(i=0;i<h[j];i++)
{
scanf("%d",&a[i][j]);
sum[j]+=a[i][j];
}

}


while(1)
{
//printf("sum[%d]:%d sum[%d]:%d sum[%d]:%d\n",0,sum[0],1,sum[1],2,sum[2]);

if(sum[0]==sum[1]&&sum[1]==sum[2]&&sum[2]==sum[0])
break;

if(sum[0]>=sum[1]&&sum[0]>=sum[2])
{sum[0]-=a[h[0]-1][0];h[0]--;}

else if(sum[1]>=sum[0]&&sum[1]>=sum[2])
{sum[1]-=a[h[1]-1][1];h[1]--;}

else if(sum[2]>=sum[1]&&sum[2]>=sum[0])
{sum[2]-=a[h[2]-1][2];h[2]--;}

}


printf("%d\n",sum[0]);

}
return 0;
}
