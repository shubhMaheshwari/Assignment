//#########################################
//#			AMEYA PRABHU				#
//#			  201402004				    #
//#########################################

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/utsname.h>
#include <string.h>
#include <stdlib.h>
#include <sys/utsname.h>
#include <signal.h>
#include <fcntl.h>

#define MAX_LINE 100

char pathVar[1000] = "~", *initPath;
pid_t child = 0;
pid_t parent;
int prevpath=0;
void wait_handler()
{
	wait(NULL);
}

int cd(char *path)
{
	char *temp = strtok(path, " \n");
	int a = chdir(temp);

	if(a==-1)
	{
		printf("Error: %s\n", path); 
	}
	if(a==0)
	{
		char cwd[1024], newPath[1024]; 
		int i = 0, j = 0;

		getcwd(cwd, sizeof(cwd));
		strcpy(pathVar, cwd);
		
		int len_initpath = strlen(initPath);
		int len_pathVar = strlen(pathVar);
		for(i=0; i<len_initpath && i<len_pathVar; i++)
		{
			if(initPath[i] != pathVar[i])
			{
				break;
			}
		}
		if(i==len_initpath)
		{
			newPath[0] = '~';
			for(j=len_initpath; j<len_pathVar; j++)
			{
				newPath[j-len_initpath+1] = pathVar[j];
			}
			
			newPath[j-len_initpath+len_pathVar] = '\0';
			strcpy(pathVar, newPath);
		}
		
	}

}

void terminal_display()
{
	struct utsname buf;
	uname(&buf);
	printf("<%s@%s:%s>", buf.nodename, buf.sysname, pathVar);
}

int execute_unpiped_command(char *str, char **args, char bg_proc)
{
	pid_t pid;
	char **next = args;
	int input = 0, output = 0, in, out; 
	char infile[100], outfile[100];
	int x = dup(0), y = dup(1);
	str = strtok(str, " ");
	
	if(strlen(infile)!=0)
	{
		printf("Reading from: %s\n", infile);
		in = open(infile, O_RDONLY);
		dup2(in, 0);
		close(in);
	}
		
	else if(strlen(outfile)!=0)
	{
		printf("Writing to: %s\n", outfile);
		out = open(outfile,O_WRONLY | O_TRUNC | O_CREAT, S_IRUSR | S_IRGRP | S_IWGRP | S_IWUSR);
		dup2(out, 1);
		close(out);
	}

	while(str!=NULL)
	{
			if(input==1)
			{
				strcpy(infile, str); 
				input = 0;
			}
			else if(strcmp(str, "<")==0)
			{
				input = 1;
			}
			else if(output==1)
			{
				strcpy(outfile, str); 
				output=0;
			}
			else if(strcmp(str, ">")==0)
			{
				output = 1;
			}
			else
			{
				*next++ = str;	
			} 
			
			str = strtok(NULL, " \n");
	}
	
	*next = NULL;
	pid = fork();

	if(pid==0)
	{
		child = getpid();
		if(bg_proc==1)
		{
			printf("Child: %d\n", child);
		}

		if(strcmp(args[0], "exit") == 0)
		{
			exit(0);
		} 

        if(strcmp(args[0], "cd") !=0 )
    	{
        	int res = execvp(args[0], args);
    	}
        else
		{
        	cd(args[1]);
        	char* error = strerror(errno);
        	return 1;
		}

		if(errno == ENOENT)
		{
			_exit(-2);
		}
				
		_exit(-1);
	}
		
	else if(pid>0)
	{
		child = getpid();
		int status;
		if(bg_proc==0)
		{
			if(wait(&status) == -1)
			{
				perror("wait()");
			}
			else
			{
				if(WIFEXITED(status))
				{
					if(WEXITSTATUS(status)==254)
					{
						printf("Command %s Not Found\n", str);
					}
					wait(NULL);
				}
			}
		}
	}

	dup2(x, 0);
	dup2(y, 1);
	return 0;
}

void execute_basic_command(char *str, char **args, int bg_proc)
{
	str = strtok(str, " ");
	char **next = args;
	
	while(str!=NULL)
	{
		*next++ = str;
		str = strtok(NULL, " \n");
	}
	
	*next = NULL;

	if(strcmp(args[0], "exit") == 0)
	{
		exit(0);
	} 

    if(strcmp(args[0],"cd")==0)
    {
        chdir(args[1]);
    }
	else 
		execvp(args[0], args);

	printf("Done");
}

int make_linked_list(int in, int out, char *str, char **args, int bg_proc)
{
	pid_t pid;
	
	if ((pid = fork()) == 0)
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
		
		execute_basic_command(str, args, bg_proc);
		exit(0);
	}

	return pid;
}

void sig_handler(int signo)
{
}

int run_single_command(char *pch)
{
	char *first, *args[100];
	char copy[100];
	char *delim = " ";
	int n, i;
	int x, y;
	int bg_proc;
	
	n=bg_proc=0;
	x=dup(0);
	y=dup(1);

	if(strlen(pch)==1)
	{
		return -1;
	}
		
	strcpy(copy, pch);
	strtok(copy, "\n");
	
	if(copy[strlen(copy)-1]=='&')
	{
		bg_proc = 1;
	}

	strtok(copy, " ");

	pid_t pid;
	signal(SIGCHLD, sig_handler);	

	char **next = args;
	pch = strtok(pch, "&");
	char *str = strtok(pch, "\n");

	int no_commands=0;
	for(i=0; i<strlen(str); i++)
	{
		if(str[i]=='|')
		{
			no_commands++;
		}
	}
	
	int in=0, fd[2];
	pid_t pid1;
		
	str = strtok(str, "|");

	for(i=0; i<no_commands; i++)
	{
		pipe(fd);
		make_linked_list(in, fd[1],str, args, bg_proc);
		wait(NULL);
		close(fd[1]);
		in = fd[0];
		str = strtok(NULL, "|");
	}
		
	if(in!=0)
	{
		dup2(in, 0);
	}
	
	execute_unpiped_command(str, args, bg_proc);
	dup2(x, 0);
	dup2(y, 1);
	return 0;

}

void init()
{
	char cwd[2000];

	if (getcwd(cwd, sizeof(cwd)) != NULL)
	{
		initPath = getcwd(cwd, sizeof(cwd));
		printf("Current working dir: %s\n", cwd);
	}

}

void get_main_command()
{
	int i=0, n=0;
	char  str[100], *pch, meh[100], delim[] = ";", commands[200][100];
	fgets(str, 100, stdin);

	if(strlen(str)==1)
	{
		return;
	}

	pch = strtok(str, delim);
		
	while(pch!=NULL)
	{
		if(pch!=NULL)
		{
			strcpy(commands[n++], pch);
		}

		pch = strtok(NULL, delim); 
	}

	for(i=0; i<n; i++)
	{
		run_single_command(commands[i]);
	}

}

void loop()
{
	terminal_display();
	get_main_command();
}

int main()
{
	init();

	child = parent = getpid();
	
	while (1)
	{
		loop();
	}
	return 0;
}
