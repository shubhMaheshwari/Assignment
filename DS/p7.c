#include<stdio.h>
long int j,r,i,t,n,st[1000009],len,max;

long int func(long int a,long int b)
{
//printf("a:%ld b:%ld a|b:%ld a&b:%ld\n",a,b,a|b,a&b);
return ((a|b)*(a|b) - (a&b)*(a&b));
}

int main()
{
scanf("%ld",&t);
while(t--)
{
len=0;
max=0;
scanf("%ld",&n);

for(i=0;i<n;i++)
{
scanf("%ld",&r);


while(len>0&&st[len-1]>=r)
{
if(max<func(r,st[len-1]))
max=func(r,st[len-1]);
len--;
}

if(len>0)
if(max<func(r,st[len-1]))
max=func(r,st[len-1]);

st[len]=r;
len++;

//for(j=0;j<len;j++)
//printf("st[%ld]:%ld ",j,st[j]);
//printf("\nr:%ld max:%ld len:%ld\n",r,max,len);
}

printf("%ld\n",max);

}

return 0;
}
