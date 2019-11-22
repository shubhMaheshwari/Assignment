#include <stdio.h>

#define max 100000009
int main()
{
int i,j,l,r,len,len1,len2,n,k,a[100009],b[100009],path1[100009],path2[100009],path[100009];

int t;
scanf("%d",&t);

while(t--)
{
//	printf("t:%d\n",t);

	scanf("%d",&n);
	for(i=0;i<n;i++)
		scanf("%d",&a[i]);

	scanf("%d",&k);
	for(i=0;i<k;i++)
		scanf("%d",&b[i]);

//path1
	len1=0;
	l=-1*max;r=max;
	
	for(i=0;i<n;i++)
	{
//		printf("l:%d r:%d b[0]:%d\n",l,r,b[0]);
		if(a[i]>l&&a[i]<b[0])
		{
			l=a[i];
			path1[len1]=a[i];
			len1++;
		}

			else if(a[i]<r&&a[i]>b[0])
			{
				r=a[i];
				path1[len1]=a[i];
				len1++;

			}

			else if (a[i]==b[0])
			{
				path1[len1]=a[i];
				len1++;
				break;
			}

	}

//	for(i=0;i<len1;i++)
//		printf("path1[%d]:%d\n",i,path1[i]);



len2=0;
l=-1*max;
r=max;

for(i=0;i<n;i++)
	{
//		printf("l:%d r:%d b[k-1]:%d\n",l,r,b[k-1]);
		if(a[i]>l&&a[i]<b[k-1])
		{
			l=a[i];
			path2[len2]=a[i];
			len2++;
		}

			else if(a[i]<r&&a[i]>b[k-1])
			{
				r=a[i];
				path2[len2]=a[i];
				len2++;

			}

			else if (a[i]==b[k-1])
			{
				path2[len2]=a[i];
				len2++;
				break;
			}

	}


//	for(i=0;i<len2;i++)
//		printf("path2[%d]:%d\n",i,path2[i]);

i=0;j=0;

for(;i<len1&&j<len2;j++,i++)
	if(path1[i]!=path2[j])
		break;

//printf("i:%d j:%d\n",i,j);


//merge
len=0;
while(i<len1)
{
	path[len]=path1[len1-1];
	len1--;
	len++;
}

if(i>0)
	{path[len]=path1[i-1];len++;}

while(j<len2)
{
	path[len]=path2[j];
	j++;
	len++;
}

//	for(i=0;i<len;i++)
//		printf("path[%d]:%d\n",i,path[i]);

	if(len==k)
		{
			for(i=0;i<len;i++)
			if(path[i]!=b[i])
				break;
			if(i==len)
				printf("Yes\n");
			else
				printf("No\n");
		}

	else 
		{
			printf("No\n");
		}	


}

return 0;
}
