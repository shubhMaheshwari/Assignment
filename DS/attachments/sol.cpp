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
int in[N],out[N];

void dfs0(int u, int p=-1)
{
  in[u] = 0;
  for(auto v:G[u])
    if(v!=p)
      dfs0(v,u), in[u] = max(in[u],in[v]+1);
}

void dfs(int u, int p=-1)
{
  int mx[2]; mx[0] = mx[1] = -1;
  for(auto v:G[u])
  {
    if(v==p) continue;
    if(in[v] > mx[0]) mx[1] = mx[0], mx[0] = in[v];
    else if(in[v] > mx[1]) mx[1] = in[v];
  }
  for(auto v:G[u])
  {
    if(v==p) continue;
    int tmp=0;
    if(mx[1] != -1) tmp = 2+(in[v]==mx[0]?mx[1]:mx[0]);
    out[v] = max(out[u]+1,tmp);
    dfs(v,u);
  }
}

int dsu[N],rank[N];
int find(int u)
{
  if(dsu[u] == u) return u;
  return dsu[u] = find(dsu[u]);
}
bool update(int u, int v)
{
  u = find(u); v = find(v);
  if(u==v) return false;
  //if(rank[u] > rank[v]) swap(u,v);
  dsu[u] = v;
  return true;
  //rank[v] = max(rank[v],rank[u]+1);
}

int main()
{
  int n; si(n);
  for(int i=1; i<=n; i++) dsu[i] = i, rank[i] = 1;
  for(int i=0; i<n-1; i++)
  {
    int u,v; si(u); si(v);
    G[u].PB(v); G[v].PB(u);
    assert(update(u,v));
  }
  dfs0(1); dfs(1);
  for(int i=1; i<=n; i++) printf("%d ",max(in[i],out[i]));
  printf("\n");
  return 0;
}
