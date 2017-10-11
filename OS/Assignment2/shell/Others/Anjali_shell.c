#include <stdio.h>
#include <stdlib.h>
#include <string.h>  
#include <unistd.h>		//for getXXX() func
#include <sys/types.h>	//For wait
#include <sys/wait.h>	//for wait
#include <signal.h>
#include <setjmp.h>
#include <fcntl.h>	//For file control



char input[100], ipfile[100], opfile[100];
int mflag, njobs=0, jobnumber[1000000], ctrZ_flag, bg_flag;
sigjmp_buf ctrlz_buf;

typedef struct jobs
{
	pid_t pid;
	char name[50];
}jobs;
jobs job[1000000];

// function to remove any extra white spaces from the command 
char* whitespaces(char str[])
{
	char *arr = str;
	int i,j=0;
	for (i=0;i<strlen(str);i++) 
	{
		if (isspace(str[i]) || str[i]=='\t') 
		{
			do 
			{
				i++; 
			}while (isspace(str[i]) || str[i]=='\t');
			--i;
		}
		arr[j++] = str[i];		//To include only 1 space
	}
	arr[j]='\0';
	while(isspace(*arr) || *arr=='\t') 			//Incase any spaces left in the beginning
		arr++;

	for(i=strlen(arr)-1;i>=0; i--)					//trailing spaces at the last part
	{
		//if((isspace(arr[i]) && isspace(arr[i-1])) || arr[i]=='\t')
		if(arr[i]!='\t')
			break;
		else if(arr[i]=='\t')		//remove trailing tabs
		{
			arr[i]='\0';
		}
	}
	for(i=0; i<strlen(arr); i++)
	{
		if(arr[i]=='\t')
		{
			arr[i]=' ';
		}
	}
	if(arr[strlen(arr)-1]=='\t')
		arr[strlen(arr)-1]='\0';
	return arr;
}

int tokeniser(char input3[], char list[][30], char* t)			//To tokenise anything, name misleading
{
	char *token;
	token=strtok(input3,t);
	int i=0;

	while(token)
	{
		strcpy(list[i++],token);
		token=strtok(NULL, t);
	}
	return i;

}
void custom_pwd(char* pwd)									//To tokenise path using /
{
	char *token;
	char dir[30][30], temp[30];
	strcpy(temp, pwd);
	token=strtok(temp,"/");
	int i=0,j,err;

	while(token)
	{
		strcpy(dir[i++],token);
		token=strtok(NULL, "/");
	}

	for(j=strlen(dir[i-1]); j>=0; j--)
		dir[i-1][j+1]=dir[i-1][j];
	dir[i-1][0]=47;
	strcpy(pwd, dir[i-1]);

}

void getPS(char mwd[])
{
	char *uname=malloc(10*sizeof(char));
	char *sysname=malloc(10*sizeof(char));
	char *pwd=malloc(100*sizeof(char));

	uname=getlogin();
	gethostname(sysname, 10);
	getcwd(pwd, 100);

	if(strcmp(mwd,pwd)==0)
		strcpy(pwd, "");
	else
		custom_pwd(pwd);		//Get only directory it is present in


	printf("%s@%s:~%s$ ", uname, sysname,pwd);

}
pid_t multipleCommands(char input[])
{
	char list[10][30];
	pid_t temp_pid, temp2_pid,err;
	int status;

	int n_args=tokeniser(input, list, ";");				//To check for multiple commands

	mflag=0;
	if(n_args>1)
	{
		int k;
		mflag=1;
		for(k=0; k<n_args; k++)
		{
			strcpy(input, list[k]);
			temp_pid=fork();
			if(temp_pid==0)								//child process in multiple command
				return temp_pid;
			if(temp2_pid=wait(&status)<0)
			{
				perror("Error!");
				_exit(1);

			}
			if(temp_pid<0)
				printf("Error forking!\n");
			else if (temp_pid>0)						//Parent process of multiple command
			{
				temp2_pid=wait(&status);
				continue;
			}

		}
	}

	if(n_args>1)
		return -1;				//To tell while loop to continue after all individ. commands are executed
	else
		return -2;

}

void remove_job(pid_t pid)
{
	int jno=jobnumber[pid]; 		//To get jobnumber of process which got ctr+Z
	int ptr;
	for(ptr=jno; ptr<njobs-1; ptr++)
	{
		job[ptr]=job[ptr+1];
		jobnumber[job[ptr].pid]--;

	}
	njobs--;

}

void sig_handler1(int signo)
{
	if(njobs>0)						//If more than 1 job, ctr Z wil send flag, else ctrl Z is ignored
		ctrZ_flag=1;	

	if(signo==SIGTSTP && bg_flag ==0 && ctrZ_flag == 1) 		//if fg process and SIGTSTP came
	{
		if(input[0]!='\0')							//If you pressed ctrl z on a running process
		{
			printf("ctr Z putting to bg..");
			sleep(0);
			printf("\n");
			siglongjmp(ctrlz_buf, 1);		//To go back to prompt
		}
		else								//If pressed on terminal
		{
			printf("%s with pid:%d killed\n",job[njobs-1].name,job[njobs-1].pid);
			kill(job[njobs-1].pid, 9);
			remove_job(job[njobs-1].pid);
			siglongjmp(ctrlz_buf, 1);		//To go back to prompt
		}

	}


}

void sig_handler(int signo)
{
	if (signo == SIGUSR1)
	{
		sleep(0);
	}
	else if (signo == SIGKILL)
	{
		sleep(0);
	}
	else if (signo == SIGSTOP)
	{	
		sleep(0);
	}
	else if (signo == SIGINT)
	{
		sleep(0);
	}
	else if(signo==SIGTSTP)
	{
		printf("\n");
		sleep(0);

	}
	else if (signo==SIGCHLD)
	{
		sleep(0);
	}

	if(signo != SIGCHLD)				//If it's sigchild, ignore prompt prompt gets printed and SIGCHILD message
		siglongjmp(ctrlz_buf, 1);		//To go back to prompt
}

//To get < inputfile
void getinputfile(char input[])
{
	int len=strlen(input),i;
	for(i=0; input[i]!='\0'; i++)
	{
		if(input[i]=='<')
		{
			while(input[i+1]==' ')
				i++;
			break;
		}
	}

	sscanf(input+i+1, "%[^> \n]", ipfile); 	//Scan into ipfile the string after "<"" but ignoring ">""
}

//To get > outputfile
void getoutputfile(char input[])
{
	int len=strlen(input),i;
	for(i=0; input[i]!='\0'; i++)
	{
		if(input[i]=='>')
		{
			while(input[i+1]==' ')
				i++;
			break;
		}
	}

	sscanf(input+i+1, "%[^< \n]", opfile); 			//scan into opfile the string after ">" but ignoring "<"
}

//To execute piped commands
void pipe_commands(char input[])
{
	char list[10][30],parse[100], *token, ptr, temp[10][30];
	char*input2=malloc(100*sizeof(char));
	int i, j,k, num=0, fd[2], argc=0, status, fin,fout, in=0;
	pid_t pid;

	//To tokenise wrt "|"
	num=tokeniser(input, list, "|");

	for(i=0; i<num; i++)
	{
		bg_flag=0;				//For each subpart, bg_flag=0 

		//Checking for ip and op file
		ipfile[0]='\0';
		opfile[0]='\0';
		strcpy(input, list[i]);
		for(k=0; k<strlen(input);k++)
		{
			if(input[k]=='<')
			{
				getinputfile(input);
				break;
			}

		}
		for(k=0; k<strlen(input);k++)
		{
			if(input[k]=='>')
			{
				getoutputfile(input);
				break;
			}

		}
		sscanf(input,"\n%[^<>]", input2);
		input2=whitespaces(input2);
		strcpy(parse,input2);						//Keep extra copy of input in input2

		//Tokenise each subpart of pipe into temp, parse is destroyed by strtok
		argc=tokeniser(parse,temp," ");


		char **argv=malloc(265*sizeof(char*));
		j=0;
		while(j<argc)
		{
			argv[j]=temp[j]; 					//to get argument list for execvp as execvp takes char**
			j++;
		}

		if(strcmp(temp[argc-1], "&")==0)
		{
			bg_flag=1;							//Implies command is a bg
			strcpy(temp[argc-1],"\0");
			argc--;
		}
		else if(temp[argc-1][strlen(temp[argc-1])-1]=='&')
		{
			bg_flag=1;								//Implies command is a bg
			temp[argc-1][strlen(temp[argc-1])-1]='\0';
		}

		pipe(fd);					//Make a pipe

		pid=fork();					

		if(pid==0)
		{
			if(fd<0)
				printf("Pipe error\n");
			else
			{

				if(fd[0]!=0)			//As long as input is not STDIN, duplicate it as read end of the pipe
				{
					dup2(in, 0);
					close(fd[0]);
				}
				if(i!=num-1)
				{
					dup2(fd[1], 1);				//Except for last one, output is to write end of the pipe
					close(fd[1]);
				}



				//If input redirection is there in subpart of pipe
				if(ipfile[0]!='\0')
				{
					if(access(ipfile,F_OK)!=0)
					{
						printf("File %s doesn't exist\n",ipfile);
						continue;
					}
					else if(access(ipfile,R_OK)!=0)
					{
						printf("You dont have permission to access %s\n",ipfile);
						continue;
					}
					else
					{
						fin=open(ipfile,O_RDONLY,0600);			//opening file in RDONLY with permissions
						if(fin<0)
							printf("1 File error\n");
						else if(dup2(fin,0) < 0)
							printf("2 File error\n");
						close(fin);
					}
				}
				//If op redirection is there in subpart of pipe
				if(opfile[0]!='\0')
				{
					if(access(opfile,F_OK)==0 && access(opfile,W_OK)!=0)		//Permission to open in Write mode
					{
						printf("You dont have permission to access %s\n",opfile);
						continue;
					}
					else
					{
						if(access(opfile,F_OK))				//write permissions only for user
							creat(opfile,0600);
						fout=open(opfile,O_WRONLY,0600);
						if(fout<0)
							printf("1 File error\n");
						if(dup2(fout,1)<0)
							printf("2 File error\n");
						close(fout);
					}
				}

				//If subpart of pipe is echo
				if(strcmp(temp[0],"echo")==0)
				{
					int stdout;
					if(opfile[0]!='\0')
					{
						if(access(opfile,F_OK)==0 && access(opfile,W_OK)!=0)		//Permission to open in Write mode
						{
							printf("You dont have permission to access %s\n",opfile);
							break;														//If you cant write, no point going ahead in pipe		
						}
						else
						{
							if(access(opfile,F_OK))				//write permissions only for user
								creat(opfile,0600);
							fout=open(opfile,O_WRONLY,0600);
							stdout=dup(1);							//To keep copy of stdout, to make it point to itself again later
							if(fout<0)
								printf("1 File error\n");
							if(dup2(fout,1)<0)
								printf("2 File error\n");
							close(fout);			//Dont need fout after dup
						}
					}

					if( temp[1][0] != 34)			//ASCII Value of " is 34
					{
						for(k=1; k<argc; k++)
							for(j=0; j<strlen(temp[k]); j++)
								printf("%c", temp[k][j]);
						printf("\n");
					}
					else
					{
						int count=0;
						for(k=1; k<argc; k++)
							for(j=0; j<strlen(temp[k]); j++)
								if(temp[k][j]==34 && temp[k][j-1]!= 92)
									count++;

						if(count%2!=0)
							printf("Error: Incomplete number of \"");
						else
						{
							for(k=1; k<argc; k++)
								for(j=1; j<strlen(temp[k])-1; j++)
									if(temp[k][j]==92 && temp[k][j+1] == 34)			//if p[k][j]==" \ " and next letter at [j+1]==" " "//Not to print /
									{
										;
									} 
									else
										printf("%c", temp[k][j]);
						}
						printf("\n");
					}
					dup2(stdout,1);		//After redirecting output to file, control regained by stdout
					_exit(1);

				}
				else
				{
					execvp(argv[0], argv);			//execute normal subparts in pipe
					_exit(1);
				}

			}		//else of (fd<0)

		}			//end of pid==0	

		else if(pid>0)
		{
			if(fd<0)
				printf("Pipe error\n");
			else
			{
				job[njobs].pid=pid;			//current process pid
				strcpy(job[njobs].name, input2);
				job[njobs].name[strlen(temp[0])]='\0';
				njobs++;
				jobnumber[pid]=njobs-1;

				if(bg_flag!=1)
				{
					ctrZ_flag=0;
					waitpid(pid,&status,WUNTRACED);
					if(pid<0)
					{
						perror("Error!");
						_exit(1);
					}
					if(ctrZ_flag==0)
						remove_job(pid);			//no ctrl Z pressed, job done

				}
				else
					printf("[%d] %s \n",job[njobs-1].pid, job[njobs-1].name);

				close(fd[1]);
				in=fd[0];		
			}
		}
		else
			printf("Fork error\n");

	}	//End of for oop	

}			//End of function

int main()
{

	char *input2=malloc(265*sizeof(char));
	char mwd[100], pwd[100], p[10][30];
	pid_t pid, cpid,err;
	int i,len,j,status,k,a,argc, fin,fout;

	getcwd(mwd, 100);

	if (signal(SIGUSR1, sig_handler) == SIG_ERR)
		sleep(0);
	if (signal(SIGKILL, sig_handler) == SIG_ERR)	
		sleep(0);	
	if (signal(SIGSTOP, sig_handler) == SIG_ERR)
		sleep(0);
	if (signal(SIGINT, sig_handler) == SIG_ERR)
		sleep(0);
	if (signal(SIGCHLD, sig_handler) == SIG_ERR)
	{
		printf("\n");
		sleep(0);
	}

	signal(SIGTSTP,sig_handler);
	if (signal(SIGTSTP, sig_handler1))			//To check if any command like "firefox" had a ctr+Z so that it terminates
	{;}

	while ( sigsetjmp( ctrlz_buf, 1 ) != 0 );		//To catch prompt after child is killed

	while(1)
	{	
		getPS(mwd);						//Prints prompt

		input[0]='\0';
		ipfile[0]='\0';
		opfile[0]='\0';

		scanf(" %[^\n]s",input);
		strcpy(input2, input);				  //copy of input
		len=strlen(input);

		pid_t mpid=multipleCommands(input);
		if (mpid==-1)								//indiv. commands are executed, so continue taking input
			continue;


		//Piper check comes here 
		int piper=0;
		for(i=0;i<strlen(input); i++)
		{
			if(input[i]=='|')
			{
				piper=1;
				pipe_commands(input);
				break;
			}
		}
		if(piper==1 && mpid==0 && mflag==1)			//If pipe in multiple commands
			exit(16);

		else if(piper==1 && mflag==0)				//0 Multiple commands and piping involved
			continue;

		ipfile[0]='\0';
		opfile[0]='\0';
		for(i=0; i<strlen(input);i++)
		{
			if(input[i]=='<')
			{
				getinputfile(input);			//handles whitespaces by itself
				break;
			}

		}
		for(i=0; i<strlen(input);i++)
		{
			if(input[i]=='>')
			{
				getoutputfile(input);			//handles whitespace by itself
				break;
			}

		}

		sscanf(input,"\n%[^<>]", input2);			//extract command without < and >
		input2=whitespaces(input2);
		strcpy(input,input2);						//Keep extra copy of input in input2

		if(strcmp(input,"exit")==0 || strcmp(input,"quit")==0)				//exit shell
			break;

		if(input[0]=='\0' || input[0]=='\n')					//To handle Ctrl+D signal
		{
			printf("\n");
			continue;
		}

		if(strcmp(input, "pwd")==0)
		{
			if(opfile[0]!='\0')
			{
				if(access(opfile,F_OK)==0 && access(opfile,W_OK)!=0)		//Permission to open in Write mode
				{
					printf("You dont have permission to access %s\n",opfile);
					continue;
				}
				else
				{
					if(access(opfile,F_OK))				//write permissions only for user
						creat(opfile,0600);
					fout=open(opfile,O_WRONLY,0600);
					if(fout<0)
						printf("1 File error\n");
					if(dup2(fout,1)<0)
						printf("2 File error\n");
					close(fout);
				}
			}

			getcwd(pwd,100);
			printf("%s\n", pwd);
		}
		else							
		{
			argc=tokeniser(input,p, " ");			//For argument list

			//checking for bg
			bg_flag=0;
			if(strcmp(p[argc-1], "&")==0)
			{
				bg_flag=1;							//Implies command is a bg
				strcpy(p[argc-1],"\0");
				argc--;
			}
			else if(p[argc-1][strlen(p[argc-1])-1]=='&')
			{
				bg_flag=1;								//Implies command is a bg
				p[argc-1][strlen(p[argc-1])-1]='\0';

			}

			//cd
			if(strcmp(p[0], "cd")==0)
			{
				if(argc>1 && mkdir(p[1])==-1)
					chdir(p[1]);				//Assuming path has no spaces
				else if(argc==1)
					chdir(mwd);
				else
					printf("No such directory exists\n");
				getcwd(pwd, 100);

			}

			//echo
			else if(strcmp(p[0], "echo")==0)			//checks if echo is with quotes or without quotes
			{
				int stdout;
				if(opfile[0]!='\0')
				{
					if(access(opfile,F_OK)==0 && access(opfile,W_OK)!=0)		//Permission to open in Write mode
					{
						printf("You dont have permission to access %s\n",opfile);
						continue;
					}
					else
					{
						if(access(opfile,F_OK))				//write permissions only for user
							creat(opfile,0600);
						fout=open(opfile,O_WRONLY,0600);
						stdout=dup(1);							//To keep copy of stdout, to make it point to itself again later
						if(fout<0)
							printf("1 File error\n");
						if(dup2(fout,1)<0)
							printf("2 File error\n");
						close(fout);			//Dont need fout after dup
					}
				}

				if( p[1][0] != 34)			//ASCII Value of " is 34
				{
					for(k=1; k<argc; k++)
						for(j=0; j<strlen(p[k]); j++)
							printf("%c", p[k][j]);
					printf("\n");
				}
				else
				{
					int count=0;
					for(k=1; k<argc; k++)
						for(j=0; j<strlen(p[k]); j++)
							if(p[k][j]==34 && p[k][j-1]!= 92)
								count++;

					if(count%2!=0)
						printf("Error: Incomplete number of \"");
					else
					{
						for(k=1; k<argc; k++)
							for(j=1; j<strlen(p[k])-1; j++)
								if(p[k][j]==92 && p[k][j+1] == 34)			//if p[k][j]==" \ " and next letter at [j+1]==" " "//Not to print /
								{
									;
								} 
								else
									printf("%c", p[k][j]);
					}
					printf("\n");
				}
				dup2(stdout,1);
			}

			//jobs
			else if (strcmp(p[0], "jobs")==0)
			{
				if(njobs>0)
				{
					for(i=0; i<njobs; i++)
						printf("[%d] %s [%d] \n",i+1, job[i].name, job[i].pid);
				}
				else
					printf("No jobs to show\n");
			}

			//kjob
			else if (strcmp(p[0],"kjob")==0)
			{
				printf("argc=%d\n",argc);
				if(argc!=3)
					printf("Wrong usage of kjob\n");
				else
				{
					int sig=(p[2][0])-'0';
					int j_no=(p[1][0])-'0' -1;
					if(j_no>=njobs)
						printf("No such job exists such as %d\n", j_no);
					else
					{
						kill(job[j_no].pid, sig);
						remove_job(job[j_no].pid);
					}					

				}
			}


			//overkill
			else if (strcmp(p[0], "overkill")==0)
			{
				int stdout;
				if(opfile[0]!='\0')
				{
					if(access(opfile,F_OK)==0 && access(opfile,W_OK)!=0)		//Permission to open in Write mode
					{
						printf("You dont have permission to access %s\n",opfile);
						continue;
					}
					else
					{
						if(access(opfile,F_OK))				//write permissions only for user
							creat(opfile,0600);
						fout=open(opfile,O_WRONLY,0600);
						stdout=dup(1);							//To keep copy of stdout, to make it point to itself again later
						if(fout<0)
							printf("1 File error\n");
						if(dup2(fout,1)<0)
							printf("2 File error\n");
						close(fout);			//Dont need fout after dup
					}
				}

				if(njobs>0)
				{
					for(i=0; i<njobs; i++)
					{
						printf("[%d] %s [%d] killed \n", i+1, job[i].name, job[i].pid);
						kill(job[i].pid, 9);
						remove_job(job[i].pid);

					}
					sleep(300);
				}
				else
					printf("No jobs to kill\n");

				dup2(stdout,1);
			}

			//fg
			else if (strcmp(p[0], "fg")==0)
			{
				if(argc!=2)
					printf("Wrong usage of fg\n");
				else
				{
					int j_no=p[1][0]-'0'-1;
					if(j_no>=njobs)
						printf("No such job exists\n");
					else
					{
						int status;
						ctrZ_flag=0;
						kill(job[p[1][0]-'0'-1].pid,SIGCONT);
						pid_t pid=waitpid(job[p[1][0]-'0'-1].pid,&status,WUNTRACED);

						if(ctrZ_flag==1)
						{
							printf("%s with pid:%d killed\n",job[j_no].name,pid);
							remove_job(job[i].pid);
							sleep(0);
						}
					}
				}
			}

			//Need to use exec
			else						
			{ 
				pid=fork();
				char **argv=malloc(265*sizeof(char*));
				j=0;
				while(j<argc)
				{
					argv[j]=p[j]; 					//to get argument list
					j++;
				}
				if(pid>0)
				{						
					job[njobs].pid=pid;			//current process pid
					strcpy(job[njobs].name, input2);
					job[njobs].name[strlen(p[0])]='\0';
					njobs++;
					jobnumber[pid]=njobs-1;

					if(bg_flag!=1)
					{
						ctrZ_flag=0;
						waitpid(pid,&status,WUNTRACED);
						if(pid<0)
						{
							perror("Error!");
							_exit(1);
						}

						if(ctrZ_flag==0)
						{
							//printf("ctrZ_flag is 0\n");
							//printf("[%d] %s done\n", jobnumber[pid], job[njobs-1].name);
							remove_job(pid);			//no ctrl Z presses, job done
							kill(pid,9);

						}
					}
					else
						printf("[%d] %s \n",job[njobs-1].pid, job[njobs-1].name);
				}
				else if (pid==0)
				{
					if(ipfile[0]!='\0')
					{
						if(access(ipfile,F_OK)!=0)
						{
							printf("File %s doesn't exist\n",ipfile);
							continue;
						}
						else if(access(ipfile,R_OK)!=0)
						{
							printf("You dont have permission to access %s\n",ipfile);
							continue;
						}
						else
						{
							fin=open(ipfile,O_RDONLY,0600);			//opening file in RDONLY with permissions
							if(fin<0)
								printf("1 File error\n");
							else if(dup2(fin,0) < 0)
								printf("2 File error\n");
							close(fin);
						}

					}
					if(opfile[0]!='\0')
					{
						if(access(opfile,F_OK)==0 && access(opfile,W_OK)!=0)		//Permission to open in Write mode
						{
							printf("You dont have permission to access %s\n",opfile);
							continue;
						}
						else
						{
							if(access(opfile,F_OK))				//write permissions only for user
								creat(opfile,0600);
							fout=open(opfile,O_WRONLY,0600);
							if(fout<0)
								printf("1 File error\n");
							if(dup2(fout,1)<0)
								printf("2 File error\n");
							close(fout);
						}
					}
					execvp(argv[0], argv);						//removed err
					_exit(1);
				}
				else
				{
					printf("Error forking!\n");
				}
			}	
		}
		if(mpid==0 && mflag==1)			//in multiple command, if child is done, return to its parent for loop
		{
			exit(16);
		}
	}

	return 0;
}
