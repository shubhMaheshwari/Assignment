#include <stdio.h>
#include <stdlib.h>

#define M 1000000007

long long int ex,ans;
int n,m,ind;
int prime[170],deg[1000009],cnt[1000005],vis[1000009],a[1000009],v[1000009],u[1000009];
int* G[20000009];
int st[1000009],mark[1000009];

int dfs(int x)
{
int i,max=a[x],r;

vis[x]=1;
//printf("x:%d\n",x);

for(i=0;i<deg[x];i++)
{
//	 printf("G[%d][%d]:%d vis[%d]:%d\n",x,i,G[x][i],G[x][i],vis[G[x][i]]);

	if(vis[G[x][i]]==0)
	{

		r=dfs(G[x][i]);
//		 printf("r:%d\n",r);
		if(r>max)
			max=r;
	}

}

return max;

}

int main()
{
int max,prime[]={2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,521,523,541,547,557,563,569,571,577,587,593,599,601,607,613,617,619,631,641,643,647,653,659,661,673,677,683,691,701,709,719,727,733,739,743,751,757,761,769,773,787,797,809,811,821,823,827,829,839,853,857,859,863,877,881,883,887,907,911,919,929,937,941,947,953,967,971,977,983,991,997,1009};
int count,prime_len=sizeof(prime)/sizeof(int);
//printf("%d\n",prime_len);

int t,i,j;
int pow1[prime_len];

for (i = 0; i < 1000009; ++i)
mark[i]=0;
	
	
	scanf("%d",&t);



while(t--)
{
	ind=0;
	scanf("%d %d",&n,&m);
	ans=1;

		
	for(i=1;i<=n;i++)
	{
		scanf("%d",&a[i]);
		deg[i]=0;
		cnt[i]=0;
		vis[i]=0;		
	
	}
	
		

	for(i=0;i<prime_len;i++)
	pow1[i]=0;	

	
	for(i=0;i<m;i++)
	{
		scanf("%d %d",&v[i],&u[i]);
		deg[v[i]]++;
		deg[u[i]]++;
	}

	// for (int i = 0; i <=n; ++i)
	// {
	// 	printf("deg[%d]:%d\n",i,deg[i]);
	// }

	for(i=1;i<=n;i++)
			G[i]=(int*)malloc(sizeof(int)*deg[i]);

	for (i = 0; i < m; ++i)
	{
		
		G[v[i]][cnt[v[i]]++]=u[i];
		G[u[i]][cnt[u[i]]++]=v[i];
	}	
		

// 	for (i = 1; i <=n; ++i)
// 	{
// //		printf("here\n");

// 		for (j = 0; j < deg[i]; ++j)
// 		{
// 			printf("G[%d][%d]:%d\n",i,j,G[i][j]);
// 		}
// 		printf("\n");
// 	}

	for(i=1;i<=n;i++)
		if(vis[i]==0)
		{
			max=dfs(i);
//			printf("max:%d\n",max);

	for(j=0;j<prime_len&&max>1;j++)
	{
		count=0;	
		while(max%prime[j]==0)
		{
//			printf("max:%d prime[%d]:%d\n",max,j,prime[j]);
			count++;
			max/=prime[j];
//		printf("count:%d\n",count);
		}

		if(count>pow1[j])
			pow1[j]=count;
	
	}
	
	if(max>1&&mark[max]==0)
	{
			mark[max]=1;
		st[ind++]=max;

	}

	// for (int z = 0; z < prime_len; ++z)
	// 	if(pow1[z]>0)
	// 	printf("pow1[%d]:%d ",z,pow1[z]);
	// printf("\n");

//	 printf("ans:%ld\n",ans);
		
	}
	
	for (i = 0; i<prime_len; ++i)
	{
		if(pow1[i]<1)
			continue;
//		printf("prime[%d]:%d pow1[%d]:%d\n",i,prime[i],i,pow1[i]);
		ex=1;
		for(j=0;j<pow1[i];j++)
			ex*=prime[i];

		ans*=ex;
		ans%=M;
//	printf("ans:%ld\n",ans);
	}

	for(i=0;i<ind;i++)
	{

		ans*=st[i];
		ans%=M;
		mark[st[i]]=0;
	}
	

	printf("%lld\n",ans);
}

	return 0;
}

