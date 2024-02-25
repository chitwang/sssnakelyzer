cd ../src
bison -d parser.y
flex lexer.l
g++ lex.yy.c parser.tab.c parser.tab.h -o parser
./parser --input=../test/testcases/public1.py

cd ../scripts
rm *.tab.* lex.yy.c parser