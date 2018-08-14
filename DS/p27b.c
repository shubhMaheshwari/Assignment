#include <stdio.h> 
#define MAX 2000000009
int n,m,E[100009][2];
long int time,T[100009],dp[1009][1009];


int main()
{
	int i,j,ans=0;
	scanf("%d %d %ld",&n,&m,&time);

	for ( i = 0; i < m; ++i)
	scanf("%d %d %ld",&E[i][0],&E[i][1],&T[i]);

	for(i=1;i<=n;i++)
		for (j = 1; j <=n ; ++j)
			dp[i][j]=MAX;

		dp[1][1]=0;

	for(i=2;i<=n;i++)
		{
			ans=dp[i-1][n]<=time?i-1:ans;
			// printf("ans:%d dp[%d][%d]:%ld\n",ans,i,n,dp[i][n]);

		for (j = 0;j<m ;j++)
			if(dp[i-1][E[j][0]]+T[j]<dp[i][E[j][1]]&&time>=dp[i-1][E[j][0]]+T[j])
				{dp[i][E[j][1]]=dp[i-1][E[j][0]]+T[j];}
		
		for (int r = 1; r <=n ; r++)
			{
				for(int q=1;q<=n;q++)
				printf("%9ld ",dp[r][q]);
					printf("\n");				
			}
			printf("\n");

		// for (int r = 1; r <=n ; r++)
		// 	{
		// 		for(int q=1;q<=n;q++)
		// 		printf("%4d ",P[r][q]);
		// 			printf("\n");				
		// 	}
		// 	printf("\n");


		}
		
		printf("%d\n",ans);
		// int st[5009],len=0;
		// int id=n;
		// for (i=ans; i>=1; --i)
		// {
		// 	st[i]=id;
		// 	id=P[i-1][id];
		// }

		// for (i = 2; i <=ans; ++i)
		// {
		// 	printf("%d ",st[i] );
		// }
		// printf("\n");

	return 0;
}