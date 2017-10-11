#include <bits/stdc++.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pwd.h>
#include <string>
#include <ctype.h>

#include <dirent.h>
#include <getopt.h>
#include <grp.h>
#include <stdbool.h>
#include <string.h>
#include <strings.h>
#include <sysexits.h>
#include <time.h>
#include <langinfo.h>


using namespace std;

static void print_permissions(mode_t mode)
{
    printf("%c",((mode & S_IRUSR) ? 'r' : '-'));
    printf("%c",((mode & S_IWUSR) ? 'w' : '-'));
    printf("%c",((mode & S_IXUSR) ? 'x' : '-'));
    printf("%c",((mode & S_IRGRP) ? 'r' : '-'));
    printf("%c",((mode & S_IWGRP) ? 'w' : '-'));
    printf("%c",((mode & S_IXGRP) ? 'x' : '-'));
    printf("%c",((mode & S_IROTH) ? 'r' : '-'));
    printf("%c",((mode & S_IWOTH) ? 'w' : '-'));
    printf("%c",((mode & S_IXOTH) ? 'x' : '-'));
    printf(" ");
}


static void print_filetype(mode_t mode)
{
    switch (mode & S_IFMT)
    {
        case S_IFREG: printf("-"); break;
        case S_IFDIR: printf("d"); break;
        case S_IFLNK: printf("l"); break;
        case S_IFCHR: printf("c"); break;
        case S_IFBLK: printf("b"); break;
        case S_IFSOCK: printf("s"); break;
        case S_IFIFO: printf("f"); break;
    }
}

void print_ls(char dir[], bool set_a, bool set_l){
	

	DIR *mydir;
	struct dirent *myfile;
	struct stat mystat;

	struct tm  	*tm;
	char buf[512],datestring[256];


	mydir = (opendir(dir));
	if (mydir == NULL) {
            printf ("Cannot open directory '%s'\n", dir);
            return ;
        }


	printf("dir:%s\n",dir);	
	while((myfile = readdir(mydir)) != NULL)
	{
		sprintf(buf, "%s/%s", dir, myfile->d_name);
		stat(buf, &mystat);
		if(set_a && (myfile->d_name)[0]=='.' || (myfile->d_name)[0]!='.'){	
			if(set_l){
				print_filetype(mystat.st_mode);
				print_permissions(mystat.st_mode);
				printf(" %d ", mystat.st_nlink);
				printf("%10s ", getpwuid(mystat.st_uid)->pw_name);
				printf("%10s", getgrgid(mystat.st_gid)->gr_name);

				tm = localtime(&mystat.st_mtime);

	    		/* Get localized date string. */
	    		strftime(datestring, sizeof(datestring), nl_langinfo(D_T_FMT), tm);
	    		printf(" %s ", datestring);

				printf("%jd", (intmax_t)mystat.st_size);

			}

			printf(" %s\n", myfile->d_name);
		}
	}
	closedir(mydir);
}



void ls(vector<char*> tokenized){

	char** args = (char**) malloc(tokenized.size() * sizeof(char*));
	int ic = 0;
	for(auto i: tokenized) args[ic++] = i;

	bool set_a = false, set_l = false,all_param_tokens = true; 

	for (int i = 1; i < tokenized.size(); ++i)
		if(args[i][0] != '-')
			all_param_tokens = false;

	for(int i=1;i < tokenized.size();i++){
		if(args[i][0] == '-')
		{
			for (int j = 1; j < strlen(args[i]); ++j)
				if(args[i][j] == 'a')
					set_a = true;
				else if(args[i][j] == 'l')
					set_l = true; 
		}
	
		else
			print_ls(args[i],set_a,set_l);
	}
			
	if(all_param_tokens)
		print_ls(".",set_a,set_l);

}
