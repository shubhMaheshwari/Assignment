#include <stdio.h>

int main()
{
	int aa,bb,lca,x,t,n,k,l,r,i,ind;
	long int a[100009],b[100009];
	
	scanf("%d",&t);

	while(t--)
	{

		scanf("%d",&n);

		for(i=0;i<n;i++)
			scanf("%ld",&a[i]);

		scanf("%d",&k);

		for (i = 0; i < k; ++i)
			scanf("%ld",&b[i]);

		l=0;
		r=k-1;

if(b[l]<b[r])
	{aa=b[l];
	bb=b[r];
}

else
{
	aa=b[r];
	bb=b[l];
}

//	printf("aa:%d bb:%d\n",aa,bb);

		for(lca=0;lca<n;lca++)
			if(a[lca]>=aa&&a[lca]<=bb)
				break;
		
			if(lca>=n)
				{printf("No\n");
			continue;}

//		printf("lca:%ld\n",a[lca]);

		l=0;
		r=0;

			for(i=0;i<n&&a[i]!=b[0];i++);
				
				if(k==1)
				{
				if(i==n)
					printf("No\n");
				else 
					printf("Yes\n");

				continue;
				}
		
			
				ind=i;


		for(i=ind+1;i<n;i++)
			if(a[i]==b[1])
			{
				r=1;
				break;
			}


		for(i=ind-1;i>=0;i--)
			if(a[i]==b[1])
			{
				l=1;
				break;
			}

			if(r==1&&l==0)
			{
				x=2;
				for(i=ind+1;i<n&&x<k;i++)
					{if(b[x]==a[i])
						x++;
						if(a[i]==lca)
							break;
					}

				for(i=lca;i>=0&&x<k;i--)
					if(b[x]==a[i])
						x++;
			}


	else if(r==0&&l==1)
			{
				x=2;
				
				for(i=ind-1;i>=0&&x<k;i--)
					{if(b[x]==a[i])
						x++;
					if(a[i]==a[lca])
						break;

						}
						i++;
					for(i=lca;i<n&&x<k;i++)
					if(b[x]==a[i])
						x++;
			}

			if(x==k)
				printf("Yes\n");
			else
				printf("No\n");

	}

	return 0;
}