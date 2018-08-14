#include <bits/stdc++.h>
using namespace std;

int n,m,q;
vector< pair<pair<int,long long int>,int> >Q,E;
long long int ans[100009],dsu[100009];

bool cmp( pair<pair<int,long long int>,int> a,pair<pair<int,long long int>,int> b)
{
	return a.first.second < b.first.second;
}


int find1(int u)
{
	if (dsu[u] <=0) return u;

	return dsu[u]=find1(dsu[u]);
}


long long int find2(int u)
{
	if (dsu[u] <=0) return dsu[u];

	return find2(dsu[u]);
}

int update(pair<pair<int,long long int>,int> e)
{
int x=find1(e.first.first);
int y=find1(e.second);

	// printf("x:%d y:%d\n",x,y);

	if(x==y)
	{
		if(y<=0) swap(x,y);
		dsu[x]-=e.first.second;
	}

	else
	{
		if(x > y) swap(x,y);
		dsu[x]+=dsu[y]-e.first.second;
		dsu[y]=x;
	}


}

int main()
{
	int k,t,u,v;
	long long int w;
	scanf("%d",&t);
	while(t--)
	{
		scanf("%d %d %d",&n,&m,&q);

		for (int j = 1; j <=n; ++j)
			dsu[j]=0;

		Q.resize(0);
		E.resize(0);		

		// for (int j = 1; j <=n; ++j)
		// 	printf("dsu[%d]:%lld\n",j,dsu[j]);

		for (int i = 0; i <m; ++i)
		{
			scanf("%d %d %lld",&u,&v,&w);
			E.push_back(make_pair(make_pair(u,w),v));
		}


		for(int i=0;i<q;i++)
		{
			scanf("%d %lld",&u,&w);
			Q.push_back(make_pair(make_pair(u,w),i));
		}
	
		sort(Q.begin(),Q.end(),cmp);
		sort(E.begin(),E.end(),cmp);
		// for (int i = 0; i <q; ++i)
		// 	printf("Q[%d]:: src:%d wmin:%lld ind:%d\n",i,Q[i].first.first,Q[i].first.second,Q[i].second);

		// for (int i = 0; i <m; ++i)
		// 	printf("E[%d]:: src:%d w:%lld dest:%d\n",i,E[i].first.first,E[i].first.second,E[i].second);
			
		k=0;
		for(int i=0;i<q;i++)
		{
			for(;E[k].first.second<=Q[i].first.second&&k<m;k++)
				update(E[k]);
			
			// for (int j = 1; j <=n; ++j)
			// 	printf("dsu[%d]:%lld\n",j,dsu[j]);

			ans[Q[i].second]=-1*find2(Q[i].first.first);		
		}

		for (int i = 0; i <q; ++i)
			printf("%lld\n",ans[i]);

	}
	
	return 0;
}