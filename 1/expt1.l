%{
#include <stdio.h>
#include <string.h>

#define MAX 100
char *symbolTable[MAX];
int symbolCount = 0;

void addToSymbolTable(char *name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i], name) == 0)
            return;
    }
    symbolTable[symbolCount++] = strdup(name);
}
%}

%option noyywrap

%%

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
    addToSymbolTable(yytext);
}

[0-9]+ {
    printf("Number: %s\n", yytext);
}

[\+\-\*/=<>!&|]+ {
    printf("Operator: %s\n", yytext);
}

\/\/[^\n]* {
    printf("Single-line Comment\n");
}

\/\*([^*]|\*+[^*/])*\*+\/ {
    printf("Multi-line Comment\n");
}

[ \t\n]+    {/* skip whitespace */}

. {
    printf("Other: %s\n", yytext);
}

%%

int main() {
    yylex();
    printf("\n--- Symbol Table ---\n");
    for (int i = 0; i < symbolCount; i++) {
        printf("%s\n", symbolTable[i]);
    }
    return 0;
}