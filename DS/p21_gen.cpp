#include <bits/stdc++.h>

using namespace std;

vector<pair<int,int> > v;

int main(){
	int a,b,n=100000,q=500000;
	srand(time(NULL));
	for(int i=1;i<=n;++i){
		cout<<(rand())%2;		
	}
	cout<<endl;
	cout<<q<<endl;
	for(int i=1;i<=n;++i){
		if(i+10000>n) break;
		v.push_back({i,i+10000});
	}

	random_shuffle(v.begin(), v.end());
	for(int i=1;i<=q;++i){
		if(rand()&1){
			cout<<"2 ";
			a=(rand()%(v.size()));
			b=(rand()%(v.size()));
			cout<<v[a].first<<" "<<v[a].second<<" ";
			cout<<v[b].first<<" "<<v[b].second<<endl;
		}
		else{
			cout<<"1 ";
			cout<<1+((rand())%n)<<" "<<(rand()%10)<<endl;
		}
	}
	return 0;
}
