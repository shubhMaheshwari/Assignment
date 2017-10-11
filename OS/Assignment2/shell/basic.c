// OS Assignment 2 - Interactive Terminal 
// 		-by Shubh Maheshwari 20161170
//          Pratik Kamble 

#include <stdio.h>
#include <stdlib.h> 
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

void single_command(char cmd[])
{
	printf("%s\n",cmd);
	char* arg[100];

	arg[0] = strtok(cmd," ");
	int i;
	for( i=0;arg[i] != NULL;i++)
			arg[i+1] = strtok(NULL," ");

		execvp(arg[0],arg);
}

int make_linked_list(int in, int out, char cmd[])
{
	int pid = fork();
		

	if (pid == 0)
	{

		if(out!=1)
		{
			dup2(out, 1);
			close(out);
		}

		if(in!=0)
		{
			dup2(in, 0);
			close(in);
		}
		single_command(cmd);
		exit(0);
	}

	return pid;
}


void pipe_command(char cmd[]){
	int fd[2],in,x,y; 
	char* arg[100];

	x = dup(0);
	y = dup(1);
	in = 0;
	printf("x:%d, y:%d\n",x,y );

	arg[0] = strtok(cmd,"|");
	for(int i=0;arg[i]!=NULL;i++){
		pipe(fd);
		// printf("%d %d\n",fd[0],fd[1]);
		int pid = fork();
		if(pid ==0)
		{

			if(in!=0)
				{dup2(in,0);close(in);}

			if(fd[1]!=1)
				{dup2(fd[1],1);close(fd[1]);}

			single_command(arg[i]);
			exit(0);
		}

		wait(NULL);
		close(fd[1]);
		in = fd[0];
		arg[i+1] = strtok(NULL,"|");
	
	}

	if(in!=0)
	{
		dup2(in,0);
	}


	dup2(x,0);
	dup2(y,1);

	printf("Hello\n");
}


void execute_command(char cmd[]){

	char* arg[100];

	arg[0] = strtok(cmd,";");

	for(int i=0; arg[i]!= NULL;i++)
		arg[i+1] = strtok(NULL,";");	

	for(int i=0;arg[i]!=NULL;i++)
		{
			int pid = fork();
			if(pid == 0)	
				pipe_command(arg[i]);
			else
				wait(NULL);
		}

}

int main()
{
	char user_name[64],system_name[64],cmd[202],current_directory[1024];

	getlogin_r(user_name,64);
	getcwd(current_directory,1024);
	gethostname(system_name,64);
	
	while(1)
	{	
		int pid = fork();

		if(pid == 0 ){
				printf("%s@%s:%s =>",user_name,system_name,current_directory);
				fgets(cmd,1024,stdin);

				if(!strcmp(strtok(cmd,"\n"),"exit"))
					break;

				execute_command(strtok(cmd,"\n"));
				// execlp(cmd,cmd,(char *)NULL);	
		}

		
		else
			wait(NULL); //parent process is expected to wait otherwise in the parent process the new iteration will begin 
						// before the completion of	child process and thus it would keep on forking.

	}

	return 0;
}