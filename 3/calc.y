%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}
int result;
%}

%token NUM

%%

stmt_list:
      stmt '\n' { printf("= %d\n", $1); }
    | stmt_list stmt '\n' { printf("= %d\n", $2); }
    ;

stmt:
      stmt '+' stmt { $$ = $1 + $3; }
    | stmt '-' stmt { $$ = $1 - $3; }
    | stmt '*' stmt { $$ = $1 * $3; }
    | stmt '/' stmt { 
          if ($3 == 0) {
              printf("Division by zero error\n");
              exit(1);
          }
          $$ = $1 / $3;
      }
    | '(' stmt ')' { $$ = $2; }
    | NUM
    ;

%%

int main() {
    printf("Enter expressions (Ctrl+D to exit):\n");
    return yyparse();
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}