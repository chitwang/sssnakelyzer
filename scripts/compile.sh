cd src
bison -$1 parser.y 2> test.txt

rm *.tab.*