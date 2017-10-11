#include <stdio.h>
#include <stdlib.h> 
#include <unistd.h>

int main(int argc, char const *argv[])
{
	int ret;

	ret = execl("/ls","ls","-l",(char *) NULL);
	printf("Failed to run %d\n", ret);

	return 0;
}