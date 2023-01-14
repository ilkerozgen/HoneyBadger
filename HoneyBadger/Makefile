parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315f22_team34.y lex.yy.c
	yacc CS315f22_team34.y
lex.yy.c: CS315f22_team34.l
	lex CS315f22_team34.l
clean:
	rm -f lex.yy.c y.tab.c parser
