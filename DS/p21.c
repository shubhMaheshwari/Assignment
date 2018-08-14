#include <stdio.h>
#include <string.h>
	
int maxsize,q,x,xx,len,pos,l1,r1,l2,r2,a[10][270009],c[10],b[10];
char str[100009];
	
void build(int ind,int low,int high)
{
int i,mid=low+(high-low)/2;

if(maxsize<ind)
	maxsize=ind;

if(low==high)
{
//	printf("ind:%d mid:%d\n",ind,mid);
	for(i=0;i<10;i++)
		a[i][ind]=0;

	a[str[mid]-'0'][ind]=1;	
	return;
}


else {

//printf("ind:%d low:%d mid:%d high:%d\n",ind,low,mid,high);



 build(2*ind+1,low,mid);
 

// for(i=0;i<10;i++)
// 	if(a[i][2*ind+1]>0)
// 	printf("a[%d][%d]:%d ",i,2*ind+1,a[i][2*ind+1]);
// 	printf("\n");

build(2*ind+2,mid+1,high);

// for(i=0;i<10;i++)
// 	if(a[i][2*ind+2]>0)
// 	printf("a[%d][%d]:%d ",i,2*ind+2,a[i][2*ind+2]);
// 	printf("\n");

for(i=0;i<10;i++)
	a[i][ind]=a[i][2*ind+1]+a[i][2*ind+2];

// for(i=0;i<10;i++)
// 	if(a[i][ind]>0)
// 	printf("a[%d][%d]:%d ",i,ind,a[i][ind]);
// 	printf("\n");


return;
}

}

void update(int ind,int low,int high,int p,int pos,int val)
{
int i,mid;

//printf("ind:%d low:%d mid:%d high:%d p:%d\n",ind,low,mid,high,p);
while(low<=high)
{
mid=low+(high-low)/2;

	if(mid==p&&low==high)
	{
	//printf("ind2:%d\n",maxsize-len+p);	
		
		while(ind>0)
		{

	 //printf("ind:%d\n",ind);
			a[pos][ind]--;
			a[val][ind]++;
// for(i=0;i<10;i++)
// 	if(a[i][ind]>0)
// 	printf("a[%d][%d]:%d ",i,ind,a[i][ind]);
// 	printf("\n");
// 	printf("\n");
			ind=((ind+1)>>1)-1;		
		}
// printf("ind:%d\n",ind);
			a[pos][0]--;
			a[val][0]++;

// for(i=0;i<10;i++)
// 	if(a[i][0]>0)
// 	printf("a[%d][%d]:%d ",i,ind,a[i][0]);
// 	printf("\n");
// 	printf("\n");

		break;
	}


else if(low<high)
{

// for(i=0;i<10;i++)
// 	if(a[i][ind]>0)
// 	printf("a[%d][%d]:%d ",i,ind,a[i][ind]);
// 	printf("\n");



	if(mid<p)
	{
		update(2*ind+2,mid+1,high,p,pos,val);
		break;
	}

	else if(mid>=p)
	{
		update(2*ind+1,low,mid,p,pos,val);
		break;

	}

}

}

}

void query(int ind,int low,int high,int l,int r,int arr[])
{
int i,mid=low+(high-low)/2;
// printf("ind:%d low:%d mid:%d high:%d l=%d r:%d\n",ind,low,mid,high,l,r);

// for(i=0;i<10;i++)
// 	if(arr[i]>0)
// 	printf("arr[%d]:%d\n",i,arr[i]);

if(l==low&&r==high)
{
// printf("l==low:%d r==high:%d\n",low,high);

	for(i=0;i<10;i++)
		arr[i]+=a[i][ind];


// for(i=0;i<10;i++)
// 	if(arr[i]>0)
// 	printf("arr[%d]:%d\n",i,arr[i]);


return;
}

if(r>mid&&l<=mid)
	{
		query(2*ind+1,low,mid,l,mid,arr);
		query(2*ind+2,mid+1,high,mid+1,r,arr);

	}	


else if(l<=mid&&r<=mid)
{
query(2*ind+1,low,mid,l,r,arr);
}

else if(l>mid&&r>mid)
{
query(2*ind+2,mid+1,high,l,r,arr);
}

}

int main()
{
	int i;

	scanf("%s",str);
	len=strlen(str);
	build(0,0,len-1);

for (int j = 0; j <=maxsize; ++j)
{for(i=0;i<10;i++)
	if(a[i][j]>0)
	printf("a[%d][%d]:%d ",i,j,a[i][j]);

	printf("\n");
}


	scanf("%d",&q);
	while(q--)
	{
		// printf("q:%d\n",q);
		scanf("%d",&x);	

		if(x==1)
		{

			scanf("%d %d",&pos,&xx);
			update(0,0,len-1,pos-1,str[pos-1]-'0',xx);

// for (int j = 0; j <=maxsize; ++j)
// {for(i=0;i<10;i++)
// 	if(a[i][j]>0)
// 	printf("a[%d][%d]:%d ",i,j,a[i][j]);

// 	printf("\n");
	
		str[pos-1]=xx+'0';
		}

	

	// printf("%s\n",str);


		


		else if(x==2)
		{

			for (i = 0; i < 10; ++i)
			{
				c[i]=b[i]=0;
			}

			scanf("%d %d %d %d",&l1,&r1,&l2,&r2);

			query(0,0,len-1,l1-1,r1-1,c);
			query(0,0,len-1,l2-1,r2-1,b);

			for(i=0;i<10;i++)
				if(c[i]!=b[i])
					break;
				if(i==10)
					printf("YES\n");
				else
					printf("NO\n");

		}




	}



	return 0;
}