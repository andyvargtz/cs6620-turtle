
%{
#include <stdio.h>
#include "symtab.h"
%}

%union { int i; node *n; double d;}

%token GO TURN VAR JUMP
%token FOR STEP TO DO

%token COPEN CCLOSE
%token SIN COS SQRT
%token <d> FLOAT
%token <n> ID               
%token <i> NUMBER       
%token SEMICOLON PLUS MINUS TIMES DIV OPEN CLOSE ASSIGN

%token UP DOWN
%token NORTH EAST WEST SOUTH
%token IF THEN ELSE

%token GREATER LESS
%token EQUAL GE LE NE

%token WHILE
%token PROCEDURE
%token COMMA
%token CALL
%token PARAM

%type <n> decl
%type <n> decllist

%right ASSIGN
%nonassoc EQUAL NE
%nonassoc GREATER GE LESS LE
%left PLUS MINUS
%left TIMES DIV

//%nonassoc after_if_cond
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%
program: head decllist stmtlist tail;

head: { printf("%%!PS Adobe\n"
               "\n"
	       "newpath 0 0 moveto\n"
	       );
      };

tail: { printf("stroke\n"); };

decllist: ;
decllist: decllist decl;

decl: VAR ID SEMICOLON { printf("/tlt%s 0 def\n",$2->symbol);} ;


stmtlist: ;
stmtlist: stmtlist stmt ;

stmt: ID ASSIGN expr SEMICOLON {printf("/tlt%s exch store\n",$1->symbol);} ;
stmt: GO expr SEMICOLON {printf("0 rlineto\n");};
stmt: JUMP expr SEMICOLON {printf("0 rmoveto\n");};
stmt: TURN expr SEMICOLON {printf("rotate\n");};

stmt: FOR ID ASSIGN expr 
          STEP expr
	  TO expr
	  DO {printf("{ /tlt%s exch store\n",$2->symbol);} 
	     stmt {printf("} for\n");};

stmt: WHILE OPEN {printf("{ ");}
        cond CLOSE {printf("\n{} {exit} ifelse \n");}
        stmt {printf("} loop\n");};
        
// if and if-else conflict, use the first one
after_if_cond: CLOSE {printf("\n{ ");};

stmt: IF OPEN cond after_if_cond//{printf("\n{ \n");}
        stmt ELSE {printf("} {\n");}
        stmt {printf("} ifelse \nclosepath\n");};
        
stmt: IF OPEN cond after_if_cond//{printf("\n{ \n");}
        stmt %prec LOWER_THAN_ELSE {printf("} if \n");};

stmt: PROCEDURE ID {printf("/proc%s { \n", $2->symbol);}
        stmt {printf("} def\n");};

stmt: CALL ID param SEMICOLON {printf("proc%s \nclosepath\n",$2->symbol);};

param: param param_ele;
param: ;
param_ele: expr;
     
stmt: COPEN stmtlist CCLOSE;	 

cond: expr EQUAL expr { printf("eq ");};
cond: expr NE expr { printf("ne ");};
cond: expr GREATER expr { printf("gt ");};
cond: expr GE expr { printf("ge ");};
cond: expr LESS expr { printf("lt ");};
cond: expr LE expr { printf("le ");};
cond: expr {printf("0 ne ");};

expr: expr PLUS term { printf("add ");};
expr: expr MINUS term { printf("sub ");};
expr: term;

term: term TIMES factor { printf("mul ");};
term: term DIV factor { printf("div ");};
term: factor;

factor: MINUS atomic { printf("neg ");};
factor: PLUS atomic;
factor: SIN factor { printf("sin ");};
factor: COS factor { printf("cos ");};
factor: SQRT factor { printf("sqrt ");};
factor: atomic;

atomic: OPEN expr CLOSE;
atomic: NUMBER {printf("%d ",$1);};
atomic: FLOAT {printf("%f ",$1);};
atomic: PARAM;
atomic: ID {printf("tlt%s ", $1->symbol);};


%%
int yyerror(char *msg)
{  fprintf(stderr,"Error: %s\n",msg);
   return 0;
}

int main(void)
{   yyparse();
    return 0;
}

