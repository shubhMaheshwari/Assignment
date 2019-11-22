#include <stdio.h>

#define M1 31
#define M 1000000007


long long int pow1[100009],x;
long long int a[100009],ar[100009],hash1,hash2;
int ll[200009],rr[200009];
char str[100009];

long long int inv(long long x, long long int y)
{
	long long sum = 1%M;
	while(y>0)
	{
		//if b is odd
		if(y&1) sum = (sum*x)%M;
		x = (x*x)%M;
		y >>= 1; // b = b/2
	}
	return sum;
}

int main()
{
	int i,j,n,q,k,ind;

	scanf("%d %d",&n,&q);

	scanf("%s",str);

	pow1[0]=1;
	for ( i = 1; i < 100009; ++i)
	{pow1[i]=M1*pow1[i-1];pow1[i]%=M;if(pow1[i]<0)pow1[i]+=M;}
	
//	for ( i = 0; i < n; ++i)
	//printf("pow1[%d]:%lld\n",i,pow1[i]);

	a[0]=str[0]-'a';
	ar[0]=str[n-1]-'a';
	for ( i = 1; i < n; ++i)
	{
		x=(str[i]-'a')*pow1[i];
		x%=M;
		a[i]=a[i-1]+x;
		a[i]%=M;
		if(a[i]<0)
			a[i]+=M;
		//printf("a[%d]:%lld str[%d]:%d\n",i,a[i],i,str[i]-'a');
	
		x=(str[n-i-1]-'a')*pow1[i];
		x%=M;
		ar[i]=ar[i-1]+x;
		if(ar[i]<0)
			ar[i]+=M;
		//printf("ar[%d]:%lld str[%d]:%d\n",i,a[i],n-i-1,str[n-i-1]-'a');

	}

	while(q--)
	{
		scanf("%d",&k);
		for (i = 0; i < k; ++i)
		{scanf("%d %d",&ll[i],&rr[i]);
			ll[i]--;
			rr[i]--;
		}

		hash1=0;
		ind=0;
		for ( i = 0; i < k; ++i)
		{
//			printf("ll[%d]:%d rr[%d]:%d\n",i,ll[i],i,rr[i]);
	
			x=a[rr[i]];
			if(ll[i]>0)
				x-=a[ll[i]-1];
			x%=M;
			if(x<0)
				x+=M;
			x*=pow1[ind];
			x%=M;
			if(x<0)
				x+=M;

			x*=inv(pow1[ll[i]],M-2);
			x%=M;
			if(x<0)
				x+=M;
//			printf("x:%lld\n",x);

			hash1+=x;
//			printf("hash1:%lld\n",hash1);
			ind+=rr[i]-ll[i]+1;
		}


		hash2=0;
		ind=0;
		for ( i = k-1; i >=0; --i)
		{	x=ll[i];
			ll[i]=n-rr[i]-1;
			rr[i]=n-x-1;

//			printf("ll[%d]:%d rr[%d]:%d\n",i,ll[i],i,rr[i]);
	
			x=ar[rr[i]];
			if(ll[i]>0)
				x-=ar[ll[i]-1];
			x%=M;
			if(x<0)
				x+=M;
			x*=pow1[ind];
			x%=M;
			if(x<0)
				x+=M;
			
			x*=inv(pow1[ll[i]],M-2);
			x%=M;
			if(x<0)
				x+=M;

//			printf("x:%lld\n",x);
			hash2+=x;
//			printf("hash2:%lld\n",hash2);

			ind+=rr[i]-ll[i]+1;
		}

		if(hash1==hash2)
			printf("YES\n");
		else
			printf("NO\n");

	}


	return 0;
}
