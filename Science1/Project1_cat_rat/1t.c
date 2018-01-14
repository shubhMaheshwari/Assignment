#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
int main()
{
	int l,n,r,t,i;
	scanf("%d %d %d",&l,&r,&t);
	n=(l*l)/(r*r);
	int x1,y1,x2,y2;
	//x1=y1=0;
	//x2=y2=l;
	int j;
	int count[10000];
	for(j=0;j<100;j++)
	{
		x1=0;
		x2=l;
		y1=0;
		y2=l;
		for(i=0;i<t;i++)
		{
			int z=rand();
			if(x1==0 && y1==0)
			{
				if(z%2==0)
				{
					x1=x1+r;
				}
				else if(z%2==1)
				{
					y1=y1+r;
				}
			}
			else if(y1==0 && x1==l)
			{
				if(z%2==0)
					y1=y1+r;
				else if(z%2==1)
					x1=x1-r;
			}
			else if (y1==0)
			{
				if(z%3==0)
				{
					x1=x1+r;
				}
				else if(z%3==1)
				{
					y1=y1+r;
				}
				else if(z%3==2)
				{
					x1=x1-r;
				}
			}
			else if (x1==0 && y1==l)
			{
				if(z%2==0)
				{
					x1=x1+r;
				}
				else if (z%2==1)
				{
					y1=y1-r;
				}
			}
			else if (x1==0)
			{
				if(z%3==0)
				{
					x1=x1+r;
				}
				else if (z%3==1)
				{
					y1=y1+r;
				}
				else if(z%3==2)
				{
					y1=y1-r;
				}
			}
			else if(x1==l && y1==l)
			{
				if(z%2==0)
					x1=x1-r;
				else if(z%2==1)
					y1=y1-r;
			}
			else if(x1==l)
			{
				if(z%3==0)
					y1+=r;
				if(z%3==1)
					y1-=r;
				if(z%3==2)
					x1-=r;

			}
			else if(y1==l)
			{
				if(z%3==0)
					x1+=r;
				if(z%3==1)
					x1-=r;
				if(z%3==2)
					y1-=r;
			}


			else
			{
				if(z%4==0)
				{
					x1=x1+r;
				}
				else if(z%4==1)
				{
					y1=y1+r;
				}
				else if(z%4==2)
				{
					x1=x1-r;
				}
				else if(z%4==3)
				{
					y1=y1-r;
				}
			}
			int z1=rand();
			if(x2==0 && y2==0)
			{
				if(z1%2==0)
				{
					x2=x2+r;
				}
				else if(z1%2==1)
				{
					y2=y2+r;
				}
			}
			else if(y2==0 && x2==l)
			{
				if(z1%2==0)
					y2=y2+r;
				else if(z1%2==1)
					x2=x2-r;
			}
			else if (y2==0)
			{
				if(z1%3==0)
				{
					x2=x2+r;
				}
				else if(z1%3==1)
				{
					y2=y2+r;
				}
				else if(z1%3==2)
				{
					x2=x2-r;
				}
			}
			else if (x2==0 && y2==l)
			{
				if(z1%2==0)
				{
					x2=x2+r;
				}
				else if (z1%2==1)
				{
					y2=y2-r;
				}
			}
			else if (x2==0)
			{
				if(z1%3==0)
				{
					x2=x2+r;
				}
				else if (z1%3==1)
				{
					y2=y2+r;
				}
				else if(z1%3==2)
				{
					y2=y2-r;
				}
			}
			else if(x2==l&& y2==l)
			{
				if(z1%2==0)
				{
					x2=x2-r;
				}
				else if(z1%2==1)
				{
					y2=y2-r;
				}
			}
			else if(x2==l)
			{
				if(z1%3==0)
					y2+=r;
				if(z1%3==1)
					y2-=r;
				if(z1%3==2)
					x2-=r;

			}
			else if(y2==l)
			{
				if(z1%3==0)
					x2+=r;
				if(z1%3==1)
					x2-=r;
				if(z1%3==2)
					y2-=r;
			}

			else
			{
				if(z1%4==0)
				{
					x2=x2+r;
				}
				else if(z1%4==1)
				{
					y2=y2+r;
				}
				else if(z1%4==2)
				{
					x2=x2-r;
				}
				else if(z1%4==3)
				{
					y2=y2-r;
				}
			}
			//printf("%d %d %d %d\n",x1,y1,x2,y2);
			if(x1==x2&&y1==y2)
			{		
				x1=0;
				x2=l;
				y1=0;
				y2=l;
				count[i]+=1;
			}
			//printf("%d",count[t-1]);
		}
	}
	count[0]=0;
	for(j=0;j<t;j++)
		//			printf("%d\n",j);
		printf("%f\n",1-(float)count[j]/(float)100);
	return 0;
}
