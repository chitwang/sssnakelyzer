cd ../src
bison -d parser.y
flex lexer.l
g++ lex.yy.c symbtab.cpp helper.cpp parser.tab.c parser.tab.h -o parser

rm *.tab.* lex.yy.c
