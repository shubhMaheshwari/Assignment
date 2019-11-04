%{
#include "parser.tab.h"
int lineno = 0;
%}

%% 
[ \t] 			{ /* eat white spaces */  }
[a-zA-Z][a-zA-Z]* 	{ return ID; }
[0-9][0-9]*		{ return NUMBER; }
[+-]			{ return yytext[0]; }
\n			{ ++lineno; return '\n'; }
.			{ printf("Line No %d: Unrecognized character '%c'\n", lineno, yytext[0]);}
