//itisalways42
#include<bits/stdc++.h>

using namespace std;

typedef pair<int,int>   II;
typedef vector< II >      VII;
typedef vector<int>     VI;
typedef vector< VI > 	VVI;
typedef long long int 	LL;

#define PB push_back
#define MP make_pair
#define F first
#define S second
#define SZ(a) (int)(a.size())
#define ALL(a) a.begin(),a.end()
#define SET(a,b) memset(a,b,sizeof(a))

#define si(n) scanf("%d",&n)
#define dout(n) printf("%d\n",n)
#define sll(n) scanf("%lld",&n)
#define lldout(n) printf("%lld\n",n)
#define fast_io ios_base::sync_with_stdio(false);cin.tie(NULL)

#define TRACE

#ifdef TRACE
#define trace(...) __f(#__VA_ARGS__, __VA_ARGS__)
template <typename Arg1>
void __f(const char* name, Arg1&& arg1){
  cerr << name << " : " << arg1 << std::endl;
}
template <typename Arg1, typename... Args>
void __f(const char* names, Arg1&& arg1, Args&&... args){
  const char* comma = strchr(names + 1, ',');cerr.write(names, comma - names) << " : " << arg1<<" | ";__f(comma+1, args...);
}
#else
#define trace(...)
#endif

//FILE *fin = freopen("in","r",stdin);
//FILE *fout = freopen("out","w",stdout);

const int N = int(1e5)+10;
const int LOGN = 20;

VI G[N];
int par[LOGN][N], H[N];

void dfs(int u, int p, int h=0)
{
	par[0][u] = p;
	H[u] = h;
	for(auto v: G[u])
	{
		if(v == u) continue;
		dfs(v,u,h+1);
	}
}

int lca(int u, int v)
{
	if(H[u] > H[v]) swap(u,v);
	int d = H[v]-H[u];
	for(int i=LOGN-1; i>=0; i--)
	{
		if(d&(1<<i)) v = par[i][v];
	}
	if(u == v) return u;
	
	for(int i=LOGN-1; i>=0; i--)
	{
		int p1,p2;
		p1 = par[i][u]; p2 = par[i][v];
		if(p1 != p2)
		{
			u = p1;
			v = p2;
		}
	}
	return par[0][u];
}

int main()
{
  int n; si(n);
  for(int i=0; i<n-1; i++)
  {
    int u,v; si(u); si(v);
    G[u].PB(v); G[v].PB(u);
  }
  dfs(1,1);
  for(int i=1; i<LOGN; i++)
	  for(int j=1; j<=n; j++)
	  {
		  int p = par[i-1][j];
		  par[i][j] = par[i-1][p];
	  }

  for(int i=1; i<=n; i++) printf("%d ",max(in[i],out[i]));
  printf("\n");
  return 0;
}
