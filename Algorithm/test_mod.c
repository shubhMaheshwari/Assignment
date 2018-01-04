#include <stdio.h>

int func(int i)
{
	return (i*i*i*i*i*i ) % 7;
}
int	main(int argc, char const *argv[])
{
	int a=0, b=0,x;
	for (int i = 0; i < 1000; ++i)
	{
		if (i%7 == 0)
			continue;
	x = func(i);	
	if( x == 1)
		{a++;printf("%d:%d\n",i,x);}
	else
		b++;
	}
	printf("a:%d b:%d\n",a,b );
	return 0;
}