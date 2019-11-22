#include <bits/stdc++.h>
using namespace std;

int  dp[509][509];
long long int ans;

int main()
{
	int u,v,w,n,m;
	scanf("%d %d",&n,&m);

	for (int i = 1; i <=n; ++i)
		for (int j = 1; j <=n; ++j)
			dp[i][i]=0;

	for (int i = 0; i < m; ++i)
	{
		scanf("%d %d %d",&u,&v,&w);
		dp[u][v]=max(dp[u][v],w);
		dp[v][u]=max(dp[v][u],w);
	}


	for (int i = 1; i <=n; ++i)
		{for (int j = 1; j<=n; ++j)
			if(dp[i][j]==0)
			dp[i][j]=100000000;
			dp[i][i]=0;
		}


	for (int i = 1; i <=n; ++i)
		for(int j=1;j<=n;j++)
			for (int k=1; k <=n; ++k)
				dp[j][k]=min(dp[j][k],dp[j][i]+dp[i][k]);


	ans=0;

	for (int i =1; i<=n; ++i)
		for(int j=1;j<=n;j++)
			ans+=dp[j][i];

	printf("%lld\n",ans);		

	return 0;
}