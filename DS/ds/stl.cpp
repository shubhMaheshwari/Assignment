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

bool cmp(int a, int b)
{
	return a<b;
}

int main()
{
	vector<int> v;
	v.size();
	v.push_back(10);
	v.pop_back();
	v.resize(20);
	v[i];

	sort(v.begin(),v.end(),cmp);
	lower_bound(v.begin(),v.end(),val) - v.begin();
	upper_bound(v.begin(),v.end(),val) - v.begin();
	binary_search(v.begin(),v.end(),val);

	pair<int,int> p;
	p.first;
	p.second;

	vector< pair<int,int> > vp;
	vp[i];

	priority_queue<int> pq;
	pq.push(10);
	pq.top();
	pq.pop();
	priority_queue<int, vector<int>, greater<int> > min_heap;

	set<int> S;
	multiset<int> MS;
	S.insert(10);
	//S.erase(10);
	S.find(9);
	*S.begin();

	map<int,int> M;
	M[5] = 10;
	*M.find(5);
	pair<int,int> x = *M.begin();// x.first = 5, x.second = 10

	unordered_set<int> H;
	H.insert(10); // O(1)
	H.erase(10);
	H.find(10);

	unordered_map<int,int> HM;
	HM[5] = 10;


	if(S.find(v) != S.end());

	string s = "hello";
	s.push_back('0');
	s += "hello";

	vector<string> VS;
	VS[i][j];




























  return 0;
}
