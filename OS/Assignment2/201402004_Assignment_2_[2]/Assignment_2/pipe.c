#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{
	int fd[2];


	pipe(fd);
	char x[10];


	int pid = fork();
	// while(true)
	// {
	if(pid == 0)
		{
			write(fd[1],"BILE",5);

			// dup2(fd[1],1);
			// close(fd[1]);
			exit(0);
		}

	else{
		wait(NULL);
		close(fd[1]);
		read(fd[0],x,7);
		printf("%s\n",x);
		}

	// }

	return 0;
}