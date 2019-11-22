#include <stdio.h>

long int min(long int a,long int b)
{
	return a<b?a:b;
}

long int max(long int a,long int b)
{
	return a>b?a:b;
}

int size(int r)
{
	int log=0;
	while(r>0)
	{
		r=r>>1;
		log++;
	}
	log++;
int len=1;
	for(;log>0;log--)
		len=len<<1;
	
	return len-1;
}



int n;
long int x[100009],stg1[270009],stg2[270009];

long int build1(long int x[],int low,int high,long int stg[],int ind)
{
	int mid=low + (high-low)/2;
	if(low>=high)
	{
		return stg[ind]=x[low];
	}

	return stg[ind]=min(build1(x,low,mid,stg,2*ind+1),build1(x,mid+1,high,stg,2*ind+2));
}

long int build2(long int x[],int low,int high,long int stg[],int ind)
{
	int mid=low + (high-low)/2;
	if(low>=high)
	{
		return stg[ind]=x[low];
	}

	return stg[ind]=max(build2(x,low,mid,stg,2*ind+1),build2(x,mid+1,high,stg,2*ind+2));
}

void update1(long int x[],int low,int high,long int stg[],int ind,int pos,long int val) 
{
	int mid=low+(high-low)/2;
	// printf("ind:%d mid:%d pos:%d\n",ind,mid,pos);
	if(low==high&&mid==pos)
	{
		stg[ind]=val;
		while(ind>0&&(stg[((ind+1)>>1)-1]>stg[ind]||stg[((ind+1)>>1)-1]==x[pos]))
		{
			if(ind%2==0)
			stg[((ind+1)>>1)-1]=min(stg[ind],stg[ind-1]);
			else
			stg[((ind+1)>>1)-1]=min(stg[ind],stg[ind+1]);

			ind=((ind+1)>>1)-1;
		}

		return;

	}

else if(low<high&&mid==pos)
	update1(x,low,mid,stg,2*ind+1,pos,val);

else if(low<high&&mid>pos)
	update1(x,low,mid,stg,2*ind+1,pos,val);

else if(low<high&&mid<pos)
	update1(x,mid+1,high,stg,2*ind+2,pos,val);


}
void update2(long int x[],int low,int high,long int stg[],int ind,int pos,long int val) 
{
	int mid=low+(high-low)/2;
	//printf("ind:%d mid:%d pos:%d\n",ind,mid,pos);

	if(low==high&&mid==pos)
	{
		stg[ind]=val;
		while(ind>0&&(stg[((ind+1)>>1)-1]<stg[ind]||stg[((ind+1)>>1)-1]==x[pos]))
		{
			if(ind%2==0)
			stg[((ind+1)>>1)-1]=max(stg[ind],stg[ind-1]);
			else
			stg[((ind+1)>>1)-1]=max(stg[ind],stg[ind+1]);

			ind=((ind+1)>>1)-1;
		}

		return;

	}

else if(low<high&&mid==pos)
	update2(x,low,mid,stg,2*ind+1,pos,val);

else if(low<high&&mid>pos)
	update2(x,low,mid,stg,2*ind+1,pos,val);

else if(low<high&&mid<pos)
	update2(x,mid+1,high,stg,2*ind+2,pos,val);

}


long int query1(long int arr[],int l,int r,long int stg[],int ind,int low,int high)
{
int mid=low+(high-low)/2;
// printf("low:%d mid:%d high:%d l:%d r:%d ind:%d\n",low,mid,high,l,r,ind);

if(l==low&&r==high)
	return stg[ind];

if(l<=mid&&r>mid)
	return min(query1(arr,l,mid,stg,2*ind+1,low,mid),query1(arr,mid+1,r,stg,2*ind+2,mid+1,high));

else if(l<=mid&&r<=mid)
	return query1(arr,l,r,stg,2*ind+1,low,mid);

else if(l>mid&&r>mid)
	return query1(arr,l,r,stg,2*ind+2,mid+1,high);
}


long int query2(long int arr[],int l,int r,long int stg[],int ind,int low,int high)
{
int i,mid=low+(high-low)/2;

// printf("low:%d mid:%d high:%d l:%d r:%d ind:%d\n",low,mid,high,l,r,ind);

if(l==low&&r==high)
	return stg[ind];

if(l<=mid&&r>mid)
	return max(query2(arr,l,mid,stg,2*ind+1,low,mid),query2(arr,mid+1,r,stg,2*ind+2,mid+1,high));

else if(l<=mid&&r<=mid)
	return query2(arr,l,r,stg,2*ind+1,low,mid);

else if(l>mid&&r>mid)
	return query2(arr,l,r,stg,2*ind+2,mid+1,high);
}

int main()
{
	int i,m,len,ind,l,r;
	long int val,ans;
	char qq;
scanf("%d %d",&n,&m);

for (i = 0; i < n; ++i)
scanf("%ld",&x[i]);

build1(x,0,n-1,stg1,0);
build2(x,0,n-1,stg2,0);

// len=size(n);
// 	printf("len:%d\n",len);

// for(i=0;i<len;i++)
// 	printf("stg1[%d]:%ld\n",i,stg1[i]);

// 	printf("\n");
// for(i=0;i<len;i++)
// 	printf("stg2[%d]:%ld\n",i,stg2[i]);

	for(;m>0;m--)
	{		
		scanf(" %c",&qq);
			// printf("m:%d qq:%c\n",m,qq);
			if(qq=='r')
			{
				scanf("%d %ld",&ind,&val);
				update1(x,0,n-1,stg1,0,ind-1,val);
				update2(x,0,n-1,stg2,0,ind-1,val);
				x[ind-1]=val;

				// for(i=0;i<len;i++)
				// 	printf("stg1[%d]:%ld\n",i,stg1[i]);

				// printf("\n");

				// for(i=0;i<len;i++)	
				// 	printf("stg2[%d]:%ld\n",i,stg2[i]);
			}

			else if(qq=='t')
			{
				scanf("%d %d",&l,&r);
				ans=query2(x,l-1,r-1,stg2,0,0,n-1)-query1(x,l-1,r-1,stg1,0,0,n-1);
//				printf("%ld %ld\n",query2(x,l-1,r-1,stg2,0,0,n-1),query1(x,l-1,r-1,stg1,0,0,n-1));
				if(r-l+1<ans)
					printf("Yes\n");
				else
					printf("No\n");

			}
	}

	return 0;
}