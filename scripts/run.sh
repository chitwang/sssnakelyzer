#!/bin/bash

input_file="test.py"
output_file="code.s"
no_save_temps=false
input=false
execute=false

for arg in "$@"; do
  if [[ "$arg" == "--input="* ]]; then
    input_file="${arg#*=}"
    input=true
  fi

  if [[ "$arg" == "--output="* ]]; then
    output_file="${arg#*=}"
  fi

  if [[ "$arg" == "--no-save-temps" ]]; then
    no_save_temps=true
  fi

  if [[ "$arg" == "--execute" ]]; then
    execute=true
  fi
done

if [[ "$input_file" != *.py ]]; then
  echo "Error: Input filename does not have the correct extension (.py)"
  exit 1
fi

if [[ "$output_file" != *.s ]]; then
  echo "Error: Output assembly filename does not have the correct extension (.s)"
  exit 1
fi

output_file="${output_file%.s}"

cd ../src
if ls *.csv >/dev/null 2>&1; then
  rm *.csv
fi

bison -d parser.y
flex lexer.l
if ! g++ lex.yy.c symbtab.cpp helper.cpp parser.tab.c parser.tab.h -o parser; then
  exit 1
fi

if ! ./parser "$@"; then
  exit 1
fi

if [[ $input == "true" ]]; then
  if ! gcc -c "$output_file".s -o "$output_file".o; then
    exit 1
  fi

  if ! gcc "$output_file".o -o "$output_file"; then
    exit 1
  fi

  if [[ $execute == "true" ]]; then
    ./"$output_file"
  fi

  if [[ $no_save_temps == "true" ]]; then
    rm "$output_file".s "$output_file".o
  fi
fi

rm *.tab.* lex.yy.c parser

if [[ $execute != "true" ]]; then
  cp "$output_file" ../scripts/
fi

cd ../scripts
