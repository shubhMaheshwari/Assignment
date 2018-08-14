#include <stdio.h>
#include <string.h>

int n,a[10][100009];
char str[100009];

// void print()
// {
// 	for(int j=0;j<=n;j++)
// 		{for(int i=0;i<10;i++)
// 			if(a[i][j]>0)
// 				printf("a[%d][%d]:%d ",i,j,a[i][j]);
// 		printf("\n");
// 	}
// }



void update(int i,int val,int ini)
{
//printf("ini:%d\n",ini);
	while(i<=n&&i>0)
	{
		a[val][i]++;
		a[ini][i]--;
		i+=i&(-1*i);
	}
}



void query(int l,int r,int arr[])
{
	int i;

	while(r>0)
	{
		for(i=0;i<10;i++)
			arr[i]+=a[i][r];
		r-=r&(-1*r);
	}
	l--;
	while(l>0)
	{
		for(i=0;i<10;i++)
			arr[i]-=a[i][l];
		l-=l&(-1*l);
	}

	return;
}




int main()
{
	int q,qq,pos,val,l,r,i;
	int c[10],d[10];
	scanf("%s",str);
	
	n=strlen(str);

	for (i = 0; i < 10; ++i)
	a[i][0]=0;

	int j;
	for(i=1;i<=n;i++)
	{
		j=i;
	while(j<=n&&j>0)
	{
		a[str[i-1]-'0'][j]++;
		j+=j&(-1*j);
	}
//	print();
	}

	scanf("%d",&q);

	
	while(q--)
	{
		scanf("%d",&qq);
		if(qq==1)
		{
			scanf("%d %d",&pos,&val);
//			 printf("pos:%d val:%d\n",pos,val);			
			update(pos,val,str[pos-1]-'0');
			str[pos-1]=val+'0';
//			print();
		}
	
		else
		{
			for (i = 0; i < 10; ++i)
			c[i]=d[i]=0;

			scanf("%d %d",&l,&r);
			//query 1
//			printf("l:%d r:%d\n",l,r);
			query(l,r,c);

			// for(i=0;i<10;i++)
			// 	if(c[i]>0)
			// 		printf("c[%d]:%d\n",i,c[i]);

			scanf("%d %d",&l,&r);
			//query 2
//			printf("l:%d r:%d\n",l,r);			
			query(l,r,d);


			// for(i=0;i<10;i++)
			// 	if(d[i]>0)
			// 		printf("d[%d]:%d\n",i,d[i]);

			for(i=0;i<10;i++)
				if(c[i]!=d[i])
					break;

				if(i==10)
					printf("YES\n");
				else 
					printf("NO\n");
		}


	}



	return 0;
}
