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

VI G[N];

int dsu[N],rank[N];
int find(int u)
{
  if(dsu[u] == u) return u;
  return dsu[u] = find(dsu[u]);
}
void update(int u, int v)
{
  u = find(u); v = find(v);
  if(u==v) return;
  if(rank[u] > rank[v]) swap(u,v);
  dsu[u] = v;
  rank[v] = max(rank[v],rank[u]+1);
}

int main()
{
  int n; si(n); si(m);
  vector< pair<int, pair<int,int> > > E;
  for(int i=1; i<=n; i++) dsu[i] = i, rank[i] = 1;
  for(int i=0; i<m; i++)
  {
    int u,v,w; si(u); si(v); si(w);
    E.push_back(make_pair(w,make_pair(u,v)));
  }
  sort(E.begin(),E.end());
  int ans=0;
  for(int i=0; i<m; i++)
  {
	  int w,u,v;
	  w = E[i].first;
	  u = E[i].second.first;
	  v = E[i].second.second;

	  x = find(u); y = find(v);
	  if(x != y)
	  {
		  ans += w;
		  update(x,y);
	  }
  }
  return 0;
}
