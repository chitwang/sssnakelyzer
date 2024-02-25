cd ../src
bison -$1 parser.y &> test.txt

rm *.tab.*
