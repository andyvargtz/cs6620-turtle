
%{
#include <stdio.h>
#include "symtab.h"
#include "token.h"
%}

int [0-9]+
float [0-9]+\.[0-9]++
identifier [a-zA-Z][a-zA-Z0-9_]*

%%

\/\/.*          ;
\/\*            {   char ch;
                    int finished = 0;
                    while (!finished){
                        while ((ch=input()) != '*');
                        while ((ch=input()) == '*');
                        if (ch == '/') finished = 1;
                    }
                }
[[:space:]]     ;

GO              return GO;
TURN            return TURN; 
VAR             return VAR;
JUMP            return JUMP;
FOR             return FOR;
STEP            return STEP;
TO              return TO;
DO              return DO;
BEGIN|"{"       {scope_open(); return COPEN;}
END|"}"         {scope_close(); return CCLOSE;}

UP              return UP;
DOWN            return DOWN;
NORTH           return NORTH;
EAST            return EAST;
WEST            return WEST;
SOUTH           return SOUTH;

IF              return IF;
THEN            return THEN;
ELSE            return ELSE;

WHILE           return WHILE;

PROCEDURE       return PROCEDURE;

sin             return SIN;
cos             return COS;
sqrt            return SQRT;

;               return SEMICOLON;
"+"             return PLUS;
"-"             return MINUS;
"*"             return TIMES;
"/"             return DIV;
"("             return OPEN;
")"             return CLOSE;
=               return ASSIGN;

,               return COMMA;
"<"             return LESS;
">"             return GREATER;
"=="            return EQUAL;
"<="            return LE;
">="            return GE;
"!="            return NE;

{identifier}    { yylval.n = lookup(yytext);
                  if (yylval.n==NULL)
                    yylval.n = insert(yytext);
                  return ID;
                }
    
{float}         yylval.d = atof(yytext);  return FLOAT;
{int}           yylval.i = atoi(yytext);  return NUMBER;

.               fprintf(stderr,"Unexpected character %c (%2X)\n",yytext[0],yytext[0]);

%%
// for test
/*
main()
{
    char* token_table[400];
    int i=0;
    for (; i++; i < 400) {
        token_table[i] = NULL;
    }
    token_table[258] = "GO";
    token_table[259] = "TURN";
    token_table[260] = "VAR";
    token_table[261] = "JUMP";
    token_table[262] = "FOR";
    token_table[263] = "STEP";
    token_table[264] = "TO";
    token_table[265] = "DO";
    token_table[266] = "COPEN";
    token_table[267] = "CCLOSE";
    token_table[268] = "SIN";
    token_table[269] = "COS";
    token_table[270] = "SQRT";
    token_table[271] = "FLOAT";
    token_table[272] = "ID";
    token_table[273] = "NUMBER";
    token_table[274] = "SEMICOLON";
    token_table[275] = "PLUS";
    token_table[276] = "MINUS";
    token_table[277] = "TIMES";
    token_table[278] = "DIV";
    token_table[279] = "OPEN";
    token_table[280] = "CLOSE";
    token_table[281] = "ASSIGN";
    token_table[282] = "UP";
    token_table[283] = "DOWN";
    token_table[284] = "NORTH";
    token_table[285] = "EAST";
    token_table[286] = "WEST";
    token_table[287] = "SOUTH";
    token_table[288] = "IF";
    token_table[289] = "THEN";
    token_table[290] = "ELSE";
    token_table[291] = "GREATER";
    token_table[292] = "LESS";
    token_table[293] = "EQUAL";
    token_table[294] = "GE";
    token_table[295] = "LE";
    token_table[296] = "WHILE";
    token_table[297] = "PROCEDURE";
    token_table[298] = "COMMA";
    
    int t;
    while (t = yylex()) {
        if (token_table[t]) { printf(" %-9s [%3d]: %-9s\n", token_table[t], t, yytext); }
        else { printf("[Undefined token] %d: %s\n", t, yytext);}
    }
}
*/
