%{
#include <stdio.h>
%}

%token OP NUMBER ID

%%

Goal:	Expr '\n'

Expr: 	Expr OP Term
	| Term
	;

Term:	NUMBER
	| ID
	;

%%

yyerror(char *s)
{
        fprintf(stderr, "error: %s\n", s);
}


main(int argc, char **argv)
{
        yyparse();
        printf("Parsing Over\n");
}



