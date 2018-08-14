#include<stdio.h>
#include<stdlib.h>

long int dp[2009][2009],ci[2009],di[2009];
int n,len;

struct heap
{
long int c;
int ind;
};

void swap(struct heap* a,struct heap* b)
{
        struct heap* c=(struct heap*)malloc(sizeof(struct heap));

        *c=*a;
        *a=*b;
        *b=*c;
}

void hin(struct heap h[],long int o)
{

        while(o>1&&h[o>>1].c>=h[o].c)
        {
//      printf("o:%ld\n",o);
                swap(&h[o>>1],&h[o]);
                o=o>>1;
        }

}

void hrem(struct heap h[])
{

//printf("hrem\n");

//printf("len:%lld \n",len);

//printf("h[%ld].c:%ld h[%ld].c:%d\n",1,h[1].c,len-1,h[len-1].c);
swap(&h[1],&h[len-1]);
//printf("h[%ld].c:%ld h[%ld].c:%d\n",1,h[1].c,len-1,h[len-1].c);

long int o=1,ll=2,rr=3;
len--;

//printf("len:%lld o:%lld ll:%lld rr:%lld  \n",len,o,ll,rr);

while(2*o<len)
{

ll=o*2;
rr=ll+1;

//printf("o:%ld ll:%ld rr:%ld len:%ld\n",o,ll,rr,len);

if(rr==len&&h[ll].c<=h[o].c)
{
swap(&h[o],&h[ll]);
break;
}

else if(h[ll].c<=h[o].c&&h[ll].c<=h[rr].c&&rr<len)
{
swap(&h[o],&h[ll]);
o=o*2;
continue;
}

else if(h[rr].c<=h[o].c&&h[rr].c<=h[ll].c&&rr<len)
{
swap(&h[o],&h[rr]);
o=o*2+1;
}

else
break;
}
}


int main()
{
scanf("%d",&n);

int i,j,k;

struct heap* h=(struct heap *)malloc(sizeof(struct heap)*n);

for(i=0;i<n;i++)
scanf("%ld",&ci[i]);

for(i=0;i<n-1;i++)
scanf("%ld",&di[i]);

for(i=1;i<=n;i++)
for(j=0;j<n;j++)
dp[j][i]=ci[i-1];

for(i=n-2;i>=0;i--)
{
len=1;
for(j=n;j>i;j--)
{
printf("i:%d j:%d len:%d\n ",i,j,len);

if(j<n)
{
while(h[1].ind>di[i]+j&&len>1)
{
printf("h[1].ind:%d di[%d]+%d=%d\n",h[1].ind,i,j,di[i]+j); 
hrem(h);
}

for(int k=1;k<len;k++)
printf("h[%d] :: c:%ld ind:%ld\n",k,h[k].c,h[k].ind);

dp[i][j]+=h[1].c;
printf("dp[%d][%d]:%ld\n",j,i,dp[i][j]);
}

if(i+1<=n-1&&j<=n)
{
h[len].c=dp[i+1][j];
h[len].ind=j;
len++;
hin(h,len-1);
printf("heapinserting\n");
for(int k=1;k<len;k++)
printf("h[%d] :: c:%ld ind:%ld\n",k,h[k].c,h[k].ind);
}


}

for(int k=1;k<=n;k++)
{
for(int r=0;r<n;r++)
printf("%4d ",dp[r][k]);
printf("\n");
}


}

printf("%ld\n",dp[0][1]);


return 0;
}
