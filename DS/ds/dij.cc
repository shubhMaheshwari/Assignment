// dijisktras algorithm for shortest path

#include <bits/stdc++.h>
#define N 100009
#define INF 1e9
using namespace std;

// long long int* prim(int n,int m,vector<int> G[],vector<long long int> W[])
// {
// 	int vis[N];
// 	set <pair<long long int,int> > que;
// 	long long int dis[N];
// 	int u,v,len;
// 	long long int w;

// 	for (int i = 0; i <=n; ++i) {vis[i]=0;dis[i]=INF;}

// 	for (int u = 0; u <=n; ++u)
// 	{
// 		len=G[u].size();
// 		for (int j = 0; j <len; ++j)
// 			printf("G[%d][%d]:%d W[%d][%d]:%lld\n",u,j,G[u][j],u,j,W[u][j]);

// 		printf("\n");
// 	}

// 	que.insert(make_pair(0,1));
// 	dis[src]=0;
// 	while(!que.empty())
// 	{

// 		u=(*que.begin()).second;
// 		w=(*que.begin()).first;

// 		printf("u:%d w:%lld\n",u,w);
		
// 		que.erase(que.begin());
// 			vis[u]=1;
// 			len=G[u].size();
// 			for (int i = 0; i <len; ++i)
// 			{	
// 				if(!vis[G[u][i]]&&dis[u]+W[u][i]<dis[G[u][i]])
// 					{dis[G[u][i]]=dis[u]+W[u][i];que.insert(make_pair(dis[G[u][i]],G[u][i]));}	
// 			}
// 	}

// 	for (int i = 0; i <=n; ++i)			
// 		printf("dis[%d]:%lld\n",i,dis[i]);

// 	return dis;

// }




long long int* dij(int src,int n,int m,vector<int> G[],vector<long long int> W[])
{
	int vis[N];
	set <pair<long long int,int> > que;
	long long int dis[N];
	int u,v,len;
	long long int w;

	for (int i = 0; i <=n; ++i) {vis[i]=0;dis[i]=INF;}

	for (int u = 0; u <=n; ++u)
	{
		len=G[u].size();
		for (int j = 0; j <len; ++j)
			printf("G[%d][%d]:%d W[%d][%d]:%lld\n",u,j,G[u][j],u,j,W[u][j]);

		printf("\n");
	}

	que.insert(make_pair(0,src));
	dis[src]=0;
	while(!que.empty())
	{

		u=(*que.begin()).second;
		w=(*que.begin()).first;

		printf("u:%d w:%lld\n",u,w);
		
		que.erase(que.begin());
			vis[u]=1;
			len=G[u].size();
			for (int i = 0; i <len; ++i)
			{	
				if(!vis[G[u][i]]&&dis[u]+W[u][i]<dis[G[u][i]])
					{dis[G[u][i]]=dis[u]+W[u][i];que.insert(make_pair(dis[G[u][i]],G[u][i]));}	
			}
	}

	for (int i = 0; i <=n; ++i)			
		printf("dis[%d]:%lld\n",i,dis[i]);

	return dis;

}



int main()
{
	//no negative weights to make it certain that an edge 
	// of shorter value enters the heap
	
	vector<int> G[N];
	vector<long long int> W[N];

	int u,v,m,n;
	long long int w;

	scanf("%d %d",&n,&m);
	for (int i = 0; i <m; ++i)
	{
		scanf("%d %d %lld",&u,&v,&w);
		G[u].push_back(v);
		G[v].push_back(u);
		W[u].push_back(w);
		W[u].push_back(w);
	}

	int src;
	scanf("%d",&src);

	long long int* dis=dij(src,n,m,G,W);
	long long int* dis=prim(n,m,G,W);



	return 0;
}