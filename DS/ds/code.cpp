//Tanuj Khattar
#include<bits/stdc++.h>
#include<testlib.h>

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
#define FOR(i, a, b) for (int i = (a); i < (b); ++i)
#define REP(i, n) FOR(i, 0, n)

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
const int N = int(1e5)+1;
const int Q = int(1e5)+1;
const int MAX = int(1e9);
const LL MAXV = LL(1e14);
LL BIT[N];
void update(int x,LL add){
  for(;x<N;x+=x^(x&(x-1)))BIT[x]+=add;
}
LL query(int x){
  LL ret = 0;
  for(;x;x=x&(x-1))ret+=BIT[x];
  return ret;
}
LL query(int l,int r){
  return query(r)-query(l-1);
}
int main()
{
  int n,q;
  si(n);si(q);
  ensuref(1 <= n && n < N,"n");
  ensuref(1 <= q && q < Q,"q");
  for(int i=1;i<=n;i++){
    int x;si(x);
    ensuref(1 <= x && x <= MAX,"A[i]");
    update(i,x);
  }
  while(q--){
    int t;si(t);
    ensuref(1 <= t && t <= 2,"t");
    if(t==1){
      int i,x;
      si(i);si(x);
      ensuref(1 <= i && i <= n,"t=1,i");
      ensuref(1 <= x && x <= MAX,"t=1,x");
      update(i,x - query(i,i));
    }
    else{
      int L,R;
      LL V;
      si(L);si(R);sll(V);
      ensuref(1 <= L && L <= n,"t=2,L");
      ensuref(L <= R && R <= n,"t=2,R");
      ensuref(1ll <= V && V <= MAXV,"t=2,V");
      int l = L, r = R, ans = -1;
      while(l <= r){
        int m = (l + r)/2;
        if(query(L,m) >= V){
          ans = m;
          r = m - 1;
        }
        else l = m + 1;
      }
      dout(ans);
    }
  }
	return 0;
}
