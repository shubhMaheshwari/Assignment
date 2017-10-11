#include <stdio.h>

int fb[100005];
	
int fib(int n){
	int a,b;
	if(fb[n]==0)
		return fb[n] = fib(n-1) + fib(n-2);

	return fb[n];
}




int main()
{
	int n;
	fb[1]=1;
	fb[2]=1;
	while(scanf("%d",&n)!=EOF);

	printf("%d\n",fib(n));

	return 0;
}