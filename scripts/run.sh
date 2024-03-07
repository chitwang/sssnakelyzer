
output_file="ast.dot"

for arg in "$@"; do
  if [[ "$arg" == "--output="* ]]; then
		output_file="${arg#*=}"
  fi
done

if [[ "$output_file" != *.dot ]]; then
	echo "Error: Output filename does not have the correct extension (.dot)"
	exit 1
fi

output_file="${output_file%.dot}"

cd ../src
bison -d parser.y
flex lexer.l
g++ lex.yy.c symbtab.cpp threeac.cpp node.cpp parser.tab.c parser.tab.h -o parser
./parser $@
dot -Tpng tree.gv -o AST.png
# dot -Tpdf $output_file.dot -o $output_file.pdf

rm *.tab.* lex.yy.c parser
cd ../scripts
