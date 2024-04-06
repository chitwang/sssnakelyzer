#!/bin/bash

output_file="test.py"

for arg in "$@"; do
  if [[ "$arg" == "--input="* ]]; then
		output_file="${arg#*=}"
  fi
done

if [[ "$output_file" != *.py ]]; then
	echo "Error: Output filename does not have the correct extension (.py)"
	exit 1
fi

cd ../src
if ls *.csv >/dev/null 2>&1; then
  rm *.csv
fi

bison -d parser.y
flex lexer.l
g++ lex.yy.c symbtab.cpp helper.cpp x86.cpp parser.tab.c parser.tab.h -o parser
./parser $@

rm *.tab.* lex.yy.c parser
cd ../scripts
