%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUM

%%

expr:
      expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    | NUM
    ;

%%

int main() {
    printf("Enter an arithmetic expression:\n");
    return yyparse();
}

int yyerror(char *s) {
    printf("Invalid expression\n");
    return 0;
}