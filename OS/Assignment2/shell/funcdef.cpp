#include <bits/stdc++.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <pwd.h>
#include <string>
#include <ctype.h>

#include <dirent.h>

#include "classdef.h"
#include "colormod.h"
using namespace Color;
using namespace std;


char* getInput() {
	int position = 0, len = COMMAND_LENGTH;
	char *buffer = (char*) malloc(sizeof(char) * len);
	int c;

	if (!buffer) {
		fprintf(stderr, "shkell: allocation error\n");
		exit(EXIT_FAILURE);
	}

	while (1) {
	// Read a character
		c = getchar();

	// If we hit EOF, replace it with a null character and return.
		if (c == EOF || c == '\n') {
			buffer[position] = '\0';
			return buffer;
		} 
		else 
			buffer[position] = c;
		position++;

	// If we have exceeded the buffer, reallocate.
		if (position >= len) {
			len += COMMAND_LENGTH;
			realloc(buffer, len);
			if (!buffer) {
				fprintf(stderr, "shkell: allocation error\n");
				exit(EXIT_FAILURE);
			}
		}
	}
}

// stores the details of all the processes
map<pid_t, Process> all_proc;
// stores the home dir
char home_dir[PWD_LENGTH / 2];

// checks for background and prints to terminal
void check_bg() {
	int status, first_time = 1;
	for(auto i: all_proc) {
		waitpid(i.first, &status, WNOHANG);
		if(WIFEXITED(status) || WIFSTOPPED(status)) {
			if(first_time) { cout<<endl; first_time = 0; }
				cout<<status<<" "<<i.first<<" "<<(i.second).get_name()<<endl;
			all_proc.erase(i.first);
		}
	}
}

// stores the pwd aswell as host and username
BaseDetails::BaseDetails() {

	register struct passwd *pw;
	register uid_t uid;
	uid = geteuid();
	pw = getpwuid(uid);
	if (pw)  strcpy(user_name, pw->pw_name);

	// stores the home dir
	/*
	// uncomment this if you want the home_dir to be PC home_dir
	if ((home_dir = getenv("HOME")) == NULL) 
		home_dir = getpwuid(getuid())->pw_dir;
	*/
	// comment this if you want home dir to be PC home_dir
	getcwd(home_dir, PWD_LENGTH / 2);

	getcwd(pwd1, PWD_LENGTH);
	gethostname(host_name, SYSTEM_NAME_LENGTH);
}

// updates the pwd everytime
void BaseDetails::update() { 
	getcwd(pwd1, PWD_LENGTH);
	sub_home();
}

// replaces the home path with '~'
void  BaseDetails::sub_home() {
	bool is_same = (strlen(pwd1) >= strlen(home_dir)) && 
	(!strncmp(pwd1, home_dir, strlen(home_dir)));
	
	if(is_same && strlen(pwd1) > strlen(home_dir)) {
		// - 1 because of ~ repr
		int repl = strlen(home_dir), act = strlen(pwd1);
		for(int i = 1; i <= act - repl; i++) 
			pwd1[i] = pwd1[repl + i];
		pwd1[0] = '~';
		for(int i = act - repl; i < act; pwd1[i++] = '\0');
	}
else if(is_same && strlen(pwd1) == strlen(home_dir))
	strcpy(pwd1, "~");

}
char* BaseDetails::get_user() { return user_name; }
char* BaseDetails::get_host() { return host_name; }
char* BaseDetails::get_cwd()  { return pwd1; 	  }

void BaseDetails::print_term() {
	Modifier bg_green(BG_GREEN);
	Modifier bg_blue(BG_BLUE);
	Modifier fg_green(FG_GREEN);
	Modifier fg_blue(FG_BLUE);

	Modifier fg_def(FG_DEFAULT);
	Modifier bg_def(BG_DEFAULT);
	Modifier fg_black(FG_BLACK);
	cout<<bg_blue<<fg_black<<get_user()<<"@"<<get_host()<<" "<<
	bg_green<<fg_blue<<"▶ "<<fg_black<<get_cwd()<<" "<<
	bg_def<<fg_green<<"▶ "<<bg_def<<fg_def;

	// printf("%s@%s:%s>\n",get_user(),get_host(),get_cwd());
}


char* remove_padding(char cmd[]) {

	vector<char> sequence;
	bool is_init = true, space_taken = false;
	
	for(int i = 0; i < strlen(cmd); i++) {
		if(is_init && isspace(cmd[i]))
			continue;
		else if (cmd[i]!=' ' && isspace(cmd[i]))
			continue;
		else if(is_init && !isspace(cmd[i])) {
			is_init = false;
			sequence.push_back(cmd[i]);
		}
		else if(!is_init && !space_taken && isspace(cmd[i])) {
			space_taken = true;
			sequence.push_back(' ');
		}
		else if(!is_init && space_taken && !isspace(cmd[i])) {
			sequence.push_back(cmd[i]);
			space_taken = false;
		}
		else if(!is_init && !space_taken && !isspace(cmd[i])) {
			sequence.push_back(cmd[i]);
		}
	}	
	
	char *new_cmd = (char*) malloc(sizeof(char) * sequence.size());
	int j = 0;
	if(sequence.back() == ' ') sequence.pop_back();
	for(auto i: sequence) new_cmd[j++] = i;

		return new_cmd;
}


int one_statement(char* cmd[], bool is_bg = false) {
	pid_t pid, wpid;
	int status;
	Process p;

	pid = fork();
	p.set_pid(pid);
	p.set_job(CHILD);
	p.set_name(cmd[0]);
	all_proc[pid] = p;
	
	if (pid == 0) {
		if (execvp(cmd[0], cmd) == -1) perror("shkell");
		exit(EXIT_FAILURE);
	} 
	else if (pid < 0) perror("shkell");
	else if(!is_bg) {
		do 
		wpid = waitpid(pid, &status, WUNTRACED);
		while (!WIFEXITED(status) && !WIFSIGNALED(status));
		all_proc.erase(pid);
	}
}

int single_command(char cmd[]) {
	Modifier red(FG_RED);
	Modifier def(FG_DEFAULT);

	vector<char*> tokenized;
	char *temp = strtok(cmd, " ");
	tokenized.push_back(temp);
	while(tokenized.back()) {
		temp = strtok(NULL, " ");
		if(!temp) break;
		tokenized.push_back(temp);
	}
	if(!tokenized.back()) tokenized.pop_back();

	char** args = (char**) malloc(tokenized.size() * sizeof(char*));
	int ic = 0;
	for(auto i: tokenized) args[ic++] = i;

	/* handling for the sigle type of command*/
	// handling of pipe cd etc should be taken care of here

		if(strcmp(args[0], "cd") == 0) {
		// cd to the home directory set
			if(tokenized.size() == 1)
			// chdir(getpwuid(getuid())->pw_dir);
				chdir(home_dir);
		// cd to the other dir
			else if((ic = chdir(args[1])) < 0) {
				cout<<red<<" Error 'cd'-ing into dir "<<args[1]<<def<<endl;
				perror("shkell");
			}
		}

		else if(strcmp(args[0],"ls")==0)
			ls(tokenized);	

		else if(strcmp(args[tokenized.size() - 1], "&") == 0) {
			cout<<"Background process"<<endl;
			args[tokenized.size() - 1] = NULL;
			one_statement(args, true);
			return BACKGROUND;
		}
		else {
			bool is_pipe = false, is_redirect = false;
			for(auto i: tokenized) {
				if(!is_pipe && strcmp(i, "|") == 0) is_pipe = true;
				else if(!is_redirect && (strcmp(i, "<") == 0 
					|| strcmp(i, ">") == 0)) is_redirect = true;
					if(is_pipe || is_redirect) break;
			}
			if(is_pipe) {
				cout<<"Piped command";
			// tokenize further and handle here
			// add a function here
				return PIPED;
			}
			else if(is_redirect) {
				cout<<"Redirection";
			// add a function here 	
				return REDIRECT;
			}
		// at the end check for normal command
			else one_statement(args);
		}

	return CHILD;
}

int exe_cmds(char cmd[]) {

	vector<char*> init_args;
	while(cmd) {
		char* temp = strsep(&cmd, ";");
		init_args.push_back(temp);
	}

	bool return_type = CHILD;
	int ic = 0;
	pid_t pid, wpid;
	int status;
	for(auto cmd: init_args) {

		if(strstr(cmd,"exit") || strstr(cmd,"quit")) { exit(0); break; } // exit shell on quit
		else if(strcmp(cmd, "pinfo") == 0) {
			cout<<"PID\t"<<"Name"<<endl;
			for(auto i: all_proc)
				cout<<i.first<<"\t"<<i.second.get_name()<<endl;
			continue;
		}
		
		return_type = single_command(cmd); 
	}
	
	return CHILD; 
}