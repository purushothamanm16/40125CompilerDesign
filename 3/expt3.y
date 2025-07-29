%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token ID NUMBER
%token PLUS MINUS MUL DIV ASSIGN SEMICOLON
%token LPAREN RPAREN

%left PLUS MINUS
%left MUL DIV

%%

program:
    /* empty */
  | program statement
  ;

statement:
    declaration
  | assignment SEMICOLON
  ;

declaration:
    ID SEMICOLON
  ;

assignment:
    ID ASSIGN expr
  ;

expr:
    expr PLUS expr
  | expr MINUS expr
  | expr MUL expr
  | expr DIV expr
  | NUMBER
  | ID
  | LPAREN expr RPAREN
  ;

%%

void yyerror(const char *s) {
  fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
  printf("Enter statements:\n");
  yyparse();
  return 0;
}
