#include<stdio.h>
#include<stdlib.h>

int i,j,n,len;
long long int area,ymax;


struct rec{
int ind,c;
long int x,h;
};

int cmp(const void *a,const void *b)
{
struct rec *aa=(struct rec*)a;
struct rec *bb=(struct rec*)b; 

return aa->x - bb->x;
}

void swap(struct rec* a,struct rec* b)
{

struct rec* c=(struct rec*)malloc(sizeof(struct rec));

*c=*a;
*a=*b;
*b=*c;
}

void hinsert(struct rec heap[],struct rec root,int len)
{
int o=len;
heap[o]=root;

while(o>1 &&heap[o>>1].h<heap[o].h)
{
//printf("o:%d\n",o);
swap(&heap[o>>1],&heap[o]);

o=o>>1;
//printf("o:%d\n",o);
}

}

void hrem(struct rec heap[],struct rec root)
{
int o,l,r;
for(o=1;o<len;o++)
{
//printf("heap[%d].ind:%d root.ind:%d\n",o,heap[o].ind,root.ind);
if(heap[o].ind==root.ind)
break;
}
swap(&heap[o],&heap[len-1]);
len--;

hinsert(heap,heap[o],o);

while(o<len)
{
l=o>>1;
r=l+1;

if(r>=len&&heap[l].h>heap[o].h)
{swap(&heap[l],&heap[o]);break;}

if(heap[l].h>heap[o].h&&heap[l].h>=heap[r].h)
{swap(&heap[l],&heap[o]);}

if(heap[l].h>heap[o].h&&heap[l].h>=heap[r].h)
{swap(&heap[l],&heap[o]);}

o=o<<1;
}

}


int main()
{
scanf("%d",&n);

struct rec* r=(struct rec*)malloc(sizeof(struct rec)*2*n);

for(i=0;i<n;i++)
{
scanf("%ld %ld %ld",&r[i].h,&r[i].x,&r[i+n].x);
r[i+n].h=r[i].h;
r[i].c=0;
r[i+n].c=1;
r[i].ind=i;
r[i+n].ind=i;
}

qsort(r,2*n,sizeof(struct rec),cmp);

//for(int i=0;i<2*n;i++)
//printf("i:%d ind:%d x:%ld c:%d h:%ld\n",i,r[i].ind,r[i].x,r[i].c,r[i].h);


//make the  heap

struct rec* heap=(struct rec*)malloc(sizeof(struct rec)*(n+100));
len=1;
ymax=0;
area=0;

for(i=0;i<2*n;i++)
{

if(r[i].c==0)
{
hinsert(heap,r[i],len);
len++;
}

area+=ymax*(r[i].x-r[i-1].x);


if(r[i].c==1)
hrem(heap,r[i]);

if(len>1)
ymax=heap[1].h;
else
ymax=0;

//for(j=1;j<len;j++)
//printf("heap j:%d ind:%d x:%ld c:%d h:%ld\n",j,heap[j].ind,heap[j].x,heap[j].c,heap[j].h);

//printf("ymax:%lld area:%lld len:%d\n",ymax,area,len);
}

printf("%lld\n",area);

return 0;
}
