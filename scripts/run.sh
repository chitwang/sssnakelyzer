
cd ../src
rm *.csv
bison -d parser.y
flex lexer.l
g++ lex.yy.c symbtab.cpp helper.cpp parser.tab.c parser.tab.h -o parser
./parser $@

rm *.tab.* lex.yy.c parser
cd ../scripts
