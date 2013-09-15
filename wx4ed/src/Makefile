

eins.out: eins.tlt scanner 
	./scanner < eins.tlt > eins.out

lex.yy.o:  lex.yy.c token.h symtab.h
	gcc -c lex.yy.c

lex.yy.c: turtle.l
	flex turtle_wx4ed.l
	
scanner:  lex.yy.o symtab.c
	gcc lex.yy.o symtab.c -lfl -o scanner 

clean:
	rm -f scanner lex.* 

