#include <bits/stdc++.h> 
using namespace std;

vector <int> G[100009],Gt[100009];
int n,m,tim;
int vis[100009];
pair <int,int> fin[100009]; 
unsigned long long int mod,ans,sum;


bool cmp(pair <int,int> a,pair <int,int> b)
{
	return b.second < a.second; 
}

unsigned long long int big_mod(unsigned long long int a,unsigned long long int b)
{
	// printf("a:%llu b:%llu\n",a,b);
	if(b==1)
		return a;

	unsigned long long int  res=0,x;

			x=big_mod(a,b/2);
		res+=2*x;
		
		if(b%2==1)
			res+=a;

		res%=mod;

		// printf("res:%llu\n",res);
		return res%mod;
}


unsigned long long int dfs2(int u)
{
	vis[u]=1;
	unsigned long long int sum=1,x;

	// printf("u:%d\n",u);
	for (int i = 0; i <Gt[u].size() ; ++i)
	{
		if(vis[Gt[u][i]]==0)
		{
			x=dfs2(Gt[u][i]);
					sum=big_mod(sum,x);
			// printf("Gt[%d][%d]:%d x:%llu sum:%llu\n",u,i,Gt[u][i],x,sum);
		}
		
		else
			continue;
	}

	return big_mod(sum,u);
}

void dfs(int u)
{
	tim++;
// printf("start u:%d tim:%d\n",u,tim);
	vis[u]=1;

	for (int i = 0;i<G[u].size(); ++i)
	if(vis[G[u][i]]==0)
		{
			// printf("u:%d %d",u,G[u][i]);
			dfs(G[u][i]);
		}

	fin[u].first=u;
	fin[u].second=++tim;
	// printf("finish u%d tim:%d\n",u,tim);
}



int main()
{
	int t,u,v;

	scanf("%d",&t);
	while(t--)
	{
		scanf("%d %d %llu",&n,&m,&mod);

		for(int i=0;i<=n;i++)
			{G[i].resize(0);
			Gt[i].resize(0);
			}

		memset(vis,0,sizeof(int)*(n+3));
		
		for (int i = 0; i <m; ++i)
		{
			scanf("%d %d",&u,&v);
			G[u].push_back(v);		
			Gt[v].push_back(u);
		}

		tim=0;
		for (int i = 1; i<=n ; ++i)
		{
			if(vis[i]==0)
				dfs(i);
		}

		sort(fin+1,fin+n+1,cmp);

		// for(int i=1;i<=n;i++)
		// 	printf("fin[%d]: %d , %d\n",i,fin[i].first,fin[i].second);

		memset(vis,0,sizeof(int)*(n+3));		

		ans=1;
		for (int i = 1; i <=n; ++i)
		{		
			sum=1;	
			if(vis[fin[i].first]==0)
				sum=dfs2(fin[i].first);

			else 
				continue;
			if(sum!=fin[i].first)
					{	
					// printf("sum:%llu\n",sum);
					// printf("before big modans:%llu sum:%llu\n",ans,sum);
					ans=big_mod(ans,sum);
					// printf("ans:%llu\n",ans);
					}
		}
 
		if(ans==1)
			printf("-1\n");
		else
		printf("%llu\n",ans);


	}

	
	return 0;
}