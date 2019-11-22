#include <bits/stdc++.h>
using namespace std;


int n;
vector<int> G[100009];
long long int sat[100009],incl[100009],excl[100009];


void dfs(int u,int par)
	{

		int x;
		long long int sum1=0,sum2=0;

 		for(int i=0;i<G[u].size();i++)
		{
			x = G[u][i];
 			if(x==par) continue;
			dfs(x,u);
			sum1+=max(incl[x],excl[x]);
			sum2+=excl[x];
		}
			
		incl[u]=sat[u]+sum2;
		excl[u]=sum1;

	}




int main()
{
	scanf("%d",&n);
	int u,v;

	for (int i = 1; i <=n; ++i)
		scanf("%lld",&sat[i]);	

	for (int i = 1; i <n; ++i)
		{
			scanf("%d %d",&u,&v);
			G[u].push_back(v);
			G[v].push_back(u);
		}

	dfs(1,0);

	printf("%lld\n",max(incl[1],excl[1]));

	return 0;
}