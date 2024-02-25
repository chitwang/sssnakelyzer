cd src
bison -d parser.y
flex lexer.l
g++ lex.yy.c parser.tab.c parser.tab.h -o parser
./parser < ../test/test.py

# rm *.tab.* lex.yy.c parser