//itisalways42
#include <bits/stdc++.h>

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
int rmq[LOGN][N],A[N],P[LOGN],X[N];

int query(int l, int r)
{
	int d = r-l+1;
	int len = P[X[d]];
	int ret = rmq[X[d]][r];
	ret = min(ret, rmq[X[d]][l+len-1]);
	return ret;
}

int main()
{
	P[0] = 1; X[1] = 0;
	for(int i=1; i<LOGN; i++) P[i] = 2*P[i-1];
	for(int i=2; i<N; i++)
	{
		X[i] = X[i-1];
		if(ispowerof2(i)) X[i]++;
	}
	for(int i=1; i<=n; i++) rmq[0][i] = A[i];
	for(int i=1; i<LOGN; i++)
		for(int j=1; j<=n; j++)
		{
			int idx = max(1,j-P[i-1]);
			rmq[i][j] = min(rmq[i-1][j], rmq[i-1][idx]);
		}

  return 0;
}
