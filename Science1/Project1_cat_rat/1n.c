#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
int main()
{
	int l,n,r,t,i;
	scanf("%d %d",&l,&r);
	n=(l*l)/(r*r);
	t=100;
	int x1,y1,x2,y2;
	//x1=y1=0;
	//x2=y2=l;
	int j,k;
	int count[10000];
	for(j=0;j<1000;j++)
	{
		for(k=0;k<=l;k++)
		{
			x1=y1=0;
			x2=y2=k;
			for(i=0;i<t;i++)
			{
				int z=rand();
				if(x1==0 && y1==0)
				{
					if(z%2==0)
					{
						if(x1+r<=k)
						{
							x1=x1+r;
						}
					}
					else if(z%2==1)
					{
						if(y1+r<=k)
						{
							y1=y1+r;
						}
					}
				}
				else if(y1==0 && x1==k)
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
				else if (x1==0 && y1==k)
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
				else if(x1==k && y1==k)
				{
					if(z%2==0)
						x1=x1-r;
					else if(z%2==1)
						y1=y1-r;
				}
				else if(x1==k)
				{
					if(z%3==0)
						y1=y1+r;
					else if(z%3==1)
						x1=x1-r;
					else if(z%3==2)
						y1=y1+r;
				}
				else if ( y1==k)
				{
					if(z%3==0)
						y1=y1-r;
					else if(z%3==1)
						x1=x1+r;
					else if( z%3==2)
						x1=x1-r;
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
						if(x2+r<=k)
							x2=x2+r;
					}
					else if(z1%2==1)
					{
						if(y2+r<=k)
							y2=y2+r;
					}
				}
				else if(y2==0 && x2==k)
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
				else if (x2==0 && y2==k)
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
				else if(x2==k && y2==k)
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
				else if(x2==k)
				{
					if(z1%3==0)
						y2=y2+r;
					else if(z1%3==1)
						x2=x2-r;
					else if(z1%3==2)
						y2=y2+r;
				}
				else if ( y1==k)
				{
					if(z1%3==0)
						y2=y2-r;
					else if(z1%3==1)
						x2=x2+r;
					else if( z1%3==2)
						x2=x2-r;
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
				if(x1==x2 && y1==y2)
					break;
			}
			if(x1==x2 && y1==y2)
				count[k]+=1;
		}
		//printf("%d",count[t-1]);
	}
	int o;
	for(o=0;o<=l;o++)
	{
		printf("%f\n",1-(float)count[o]/(float)1000);
	}
	return 0;
}
