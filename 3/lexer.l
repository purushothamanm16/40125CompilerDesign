%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%

[ \t]+               ;             // ignore whitespace
\n                   return '\n';  // return newline to parser
[0-9]+               { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* return ID;
"="                  return ASSIGN;
"+"                  return PLUS;
"-"                  return MINUS;
"*"                  return MUL;
"/"                  return DIV;
"("                  return LPAREN;
")"                  return RPAREN;
";"                  return SEMICOLON;
.                    return yytext[0]; // catch all other chars

%%

int yywrap() {
    return 1;
}
