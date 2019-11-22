#include <bits/stdc++.h>
using namespace std;

int n,m;
vector<int> G[100009];
vector<long long int> sat;
vector<int> vis;
long long int sum1,sum2;

void bfs(int u)
{	
	int x;

	queue<int> q;
	vis[u]=1;
	q.push(u);
	while(!q.empty())
	{
		x=q.front();
		// printf("x:%d\n",x);
		q.pop();
		if(vis[x]==1)
			sum1+=sat[x];
		else
			sum2+=sat[x];

		// printf("sum1:%lld sum2:%lld\n",sum1,sum2);

		for(int i=0;i<G[x].size();i++)
			if(vis[G[x][i]]==-1)
			{q.push(G[x][i]);vis[G[x][i]]=1-vis[x];}

	}


}

int main()
{

	scanf("%d",&n);
	sat.resize(n+4);
	vis.resize(n+4);

	int u,v;

	for (int i = 1; i <=n; ++i)
			{scanf("%lld",&sat[i]);vis[i]=-1;}

		// for (int i = 1; i<=n; ++i)
		// 	printf("%lld\n",sat[i]);

		for (int i = 1; i <n; ++i)
		{
			scanf("%d %d",&u,&v);
			G[u].push_back(v);
			G[v].push_back(u);
		}

		sum1=0;
		sum2=0;


		for (int i = 1; i<=n; ++i)
			if(vis[i]==-1)
			bfs(i);		

		printf("%lld\n",sum1>sum2?sum1:sum2);


	return 0;
}