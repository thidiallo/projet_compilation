all:executable
executable:parseur.o lex.yy.o actions.o
	gcc -o $@ $^ -lfl
parseur.tab.o:parseur.tab.c parseur.tab.h
	gcc -o $@ -c parseur.tab.c
parseur.tab.c parseur.tab.h:parseur.y
	bison parseur.y --defines=parseur.tab.h
lex.yy.o:lex.yy.c
	gcc -o $@ -c lex.yy.c
lex.yy.c: lexeur.l parseur.tab.h
	flex lexeur.l
actions.o:actions.c actions.h
	gcc -o $@ -c actions.c
exec:executable
	./executable program.pas
	gedit program.c
clean:
	rm -rf *.o lex.yy.c parseur.tab.c program.c parseur.tab.h executable
