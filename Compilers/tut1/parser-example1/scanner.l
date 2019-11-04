%{
int lineno = 0;
%}

%% 
[ \t] 		{ /* eat white spaces */  }
[a-zA-Z0-9+-]	{ return yytext[0]; }
\n		{ ++lineno; return '\n'; }
.		{ printf("Line No %d: Unrecognized character '%c'\n", lineno, yytext[0]);}
