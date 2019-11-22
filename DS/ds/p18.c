#include <stdio.h>

int main()
{
	int i,n,k,t,len,max;
int a[100009],st[100009],which[100009];

 scanf("%d",&t);

 while(t--)
 {
	scanf("%d %d",&n,&k);

	for(i=0;i<n;i++)
	{	scanf("%d",&a[i]);
	which[i]=-1;	
}
	max=0;
	len=0;

	st[0]=0;
	for(i=0;i<n;i++)
	{


		
		if(a[i]>0)
		{
			st[len]=i;
			len++;

		}

		else if(a[i]<0&&len>0)
		{

			if(a[i]==-1*a[st[len-1]])
			{
				if(which[st[len-1]-1]==-1)
{

				which[i]=st[len-1];
				len--;
				if(max<i-which[i]+1)
					max=i-which[i]+1;

}

	else
	{
		which[i]=which[st[len-1]-1];
				len--;
				if(max<i-which[i]+1)
					max=i-which[i]+1;


	}

			}

			else
				len=0;

}
		

		
			
//printf("a[%d]:%d st[%d]:%d len:%d max:%d\n",i,a[i],len-1,st[len-1],len,max);
//printf("last closed bracket:%d\n",which[i] );

	}

	printf("%d\n",max);

}
	return 0;
}