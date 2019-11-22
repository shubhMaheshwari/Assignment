#include <stdio.h>
#include <string.h>

#define M 1000009
#define M1 1000159
#define M2 1000969

int n;
unsigned long long int a[100009],check[1000009];
int hash[1000009];

// void print_bin(long long int x)
// {
// printf("x:%lld\n",x);

// for(;x>0;x=x>>1)
// {
// //	printf("x:%lld\n",x);
// 	if(x&1)
// 		printf("1");
// 	else
// 		printf("0");

// }

// printf("\n");

// }



int main()
{
	int i,j,t,len,ch[128];
unsigned long long int pos[64],r;
	char s[100009];

for(i=0;i<10;i++)
	ch[i+'0']=i;

for(j=0;j<26;j++,i++)
	ch[j+'A']=i;

for(j=0;j<26;j++,i++)
	ch[j+'a']=i;

//for (i = 0;i<128; ++i)
//	printf("ch[%d]:%d\n",i,ch[i]);

pos[0]=1;
for (i = 1; i <64; ++i)
pos[i]=pos[i-1]<<1;

//for (i = 0;i<64; ++i)
//	printf("pos[%d]:%llu\n",i,pos[i]);


scanf("%d",&t);


while(t--)
{
	for(i=0;i<1000009;i++)
		{hash[i]=0;check[i]=-1;}

	scanf("%d",&n);
	for(i=0;i<n;i++)
		{scanf("%s",s);
		len=strlen(s);
		a[i]=0;
		for(j=0;j<len;j++)
		{
//			printf("j:%d i:%d s[%d]:%d ch[%d]:%d pos[%d]:%llu\n",j,i 
//				,j,s[j],s[j],ch[s[j]],ch[s[j]],pos[ch[s[j]]]);

			if(!(a[i]&pos[ch[s[j]]]))
				a[i]+=pos[ch[s[j]]];
//			print_bin(a[i]);	
					
		}

		r=a[i]%M1;
		r=r%M;


		while(check[r]!=a[i])
		{
			if(check[r]==-1)
				{check[r]=a[i];break;}

			r+=a[i]%M2;
			r=r%M;
		}
		hash[r]++;
//		printf("hash[%d]:%d\n",a[i]%M1,hash[a[i]%M13]);
		}

	 for(i=0;i<n;i++)
	 	{

r=a[i]%M1;
		r=r%M;

		while(check[r]!=a[i])
		{
			r+=a[i]%M2;
			r=r%M;
		}
	 	printf("%d ",hash[r]);

	 	}
		printf("\n");
}


	return 0;
}