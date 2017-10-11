#include <bits/stdc++.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string>

#include "classdef.h"
#include "colormod.h"
using namespace std;
using namespace Color;

signed main() {
	
	BaseDetails b;
	char *cmd = (char*) malloc(COMMAND_LENGTH * sizeof(char));
	
	// main process execution loop
	do {
		
		// updates to the pwd
		b.update();
		// checks for background ends
		// check_bg();
		// prints the PS1
		b.print_term();


		cmd = getInput();

		cmd = remove_padding(cmd); // removing the leading and trailing spaces
		
		/* EXECUTION OF PROCESS */
		exe_cmds(cmd);

	} while(true);
}
