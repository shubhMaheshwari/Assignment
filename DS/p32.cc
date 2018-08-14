#include <bits/stdc++.h>
#define INF 1e9 + 9
using namespace std;

long long int mod=1e9 + 7;
int n,m,src,dest;

vector<int> G[100009];
vector<long long int > W[100009];
vector<pair<pair<int,int>,long long int> > E;
long long int cntsrc[100009],cntdest[100009];	 
long long int dijsrc[100009],dijdest[100009];
int vis[100009];
set <pair<int,long long int> > que; 


void dij(int src,long long int dis[],long long int cnt[])
{
	que.clear();

	for (int i = 1; i <=n; ++i)
	{
		vis[i]=0;
	}
	
	vis[src]=1;

	int u,d,v,len;
	pair<int,long long int> node;
	
	dis[src]=0;
	cnt[src]=1;
	que.insert(make_pair(src,0));

	while(!que.empty())
	{
		node=*(que.begin());
		u=node.first;
		d=node.second;
		que.erase(que.begin());
		
		if(d > dis[u])
			continue;

		len=G[u].size();
		for (int i = 0; i <len; ++i)
		{
			if(vis[G[u][i]]==0)
			{
				v = G[u][i];
			if(dis[u]+W[u][i] < dis[v])
			{
				vis[v]=1;
				dis[v]=dis[u]+W[u][i];
				cnt[v]=cnt[u];				
				
				if(cnt[v]>mod)
					cnt[v]-=mod;

				que.insert(make_pair(v,dis[v]));
				
			}
			
			else if(dis[u]+W[u][i] == dis[v])
			{
				cnt[v]+=cnt[u];								
				if(cnt[v]>mod)
					cnt[v]-=mod;
			}
			}
		}
	}
}


int main()
{

int t,u,v;
long long int w;
scanf("%d",&t);
while(t--)
	{
		scanf("%d %d %d %d",&n,&m,&src,&dest);

		E.resize(0);
		for (int i = 1; i <=n; ++i)
		{
			cntsrc[i]=0;
			cntdest[i]=0;
			dijsrc[i]=INF;
			dijdest[i]=INF;
			G[i].resize(0);		
			W[i].resize(0);
		}

		for (int i = 0; i <m; ++i)
		{
			scanf("%d %d %lld",&u,&v,&w);
			G[u].push_back(v);
			G[v].push_back(u);
			W[u].push_back(w);
			W[v].push_back(w);
			E.push_back(make_pair(make_pair(u,v),w));
		}


		dij(src,dijsrc,cntsrc);
		dij(dest,dijdest,cntdest);


		// for (int i = 1; i<=n; ++i)
		// 	printf("dijsrc[%d]:%lld cntsrc[%d]:%lld\n",i,dijsrc[i],i,cntsrc[i]);

		// printf("\n");

		// for (int i = 1; i<=n; ++i)
		// 	printf("dijdest[%d]:%lld cntdest[%d]:%lld\n",i,dijdest[i],i,cntdest[i]);


		for (int i = 0; i <m; ++i)
		{
			u=E[i].first.first;
			v=E[i].first.second;

			// printf("%d ::dijsrc[%d]:%lld E.second:%lld dijdest[%d]:%lld\n",i,u,dijsrc[u],E[i].second,v,dijdest[v]);
		
			if(dijsrc[u]+ E[i].second +dijdest[v]==dijsrc[dest]||dijsrc[v]+ E[i].second +dijdest[u]==dijsrc[dest])
				printf("%lld ",(cntsrc[E[i].first.first]*cntdest[E[i].first.second])%mod );
			
			else
				printf("0 ");
		}

		printf("\n");
	}

	return 0;
}	