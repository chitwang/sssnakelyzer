cd ../src
bison -d parser.y
flex lexer.l
g++ lex.yy.c parser.tab.c parser.tab.h -o parser
./parser $@
dot -Tpdf ast.dot -o ast.pdf

rm *.tab.* lex.yy.c parser
cd ../scripts