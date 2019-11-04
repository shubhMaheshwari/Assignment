%{
#include <stdio.h>
%}

%%

Goal:	Expr '\n'

Expr: 	Expr Op Term
	| Term
	;

Term:	Number
	| Id
	;

Op:	'+'
	| '-'
	;

Id:	Alpha Id
	| Alpha 
	;

Alpha: 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h'
   	| 'i' | 'j' | 'k' | 'l' | 'm' | 'n' | 'o' | 'p'
	| 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z'
	| 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H'
        | 'I' | 'J' | 'K' | 'L' | 'M' | 'N' | 'O' | 'P'
        | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z'
	;

Number: Number Digit
	| Digit
	;

Digit: '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
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



