/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KEY_FALSE = 258,
    KEY_ELSE = 259,
    KEY_NONE = 260,
    KEY_BREAK = 261,
    KEY_IN = 262,
    KEY_TRUE = 263,
    KEY_CLASS = 264,
    KEY_RETURN = 265,
    KEY_AND = 266,
    KEY_CONTINUE = 267,
    KEY_FOR = 268,
    KEY_DEF = 269,
    KEY_WHILE = 270,
    KEY_GLOBAL = 271,
    KEY_NOT = 272,
    KEY_ELIF = 273,
    KEY_IF = 274,
    KEY_OR = 275,
    KEY_RANGE = 276,
    OP_ADD = 277,
    OP_SUBTRACT = 278,
    OP_MULTIPLY = 279,
    OP_POWER = 280,
    OP_DIVIDE = 281,
    OP_FLOOR_DIVIDE = 282,
    OP_MODULO = 283,
    OP_LEFT_SHIFT = 284,
    OP_RIGHT_SHIFT = 285,
    OP_BITWISE_AND = 286,
    OP_BITWISE_OR = 287,
    OP_BITWISE_XOR = 288,
    OP_BITWISE_NOT = 289,
    OP_LESS_THAN = 290,
    OP_GREATER_THAN = 291,
    OP_LESS_THAN_EQUAL = 292,
    OP_GREATER_THAN_EQUAL = 293,
    OP_EQUAL = 294,
    OP_NOT_EQUAL = 295,
    DELIM_LEFT_PAREN = 296,
    DELIM_RIGHT_PAREN = 297,
    DELIM_LEFT_BRACKET = 298,
    DELIM_RIGHT_BRACKET = 299,
    DELIM_COMMA = 300,
    DELIM_COLON = 301,
    DELIM_DOT = 302,
    DELIM_SEMICOLON = 303,
    DELIM_ASSIGN = 304,
    DELIM_ARROW = 305,
    DELIM_ASSIGN_ADD = 306,
    DELIM_ASSIGN_SUBTRACT = 307,
    DELIM_ASSIGN_MULTIPLY = 308,
    DELIM_ASSIGN_DIVIDE = 309,
    DELIM_ASSIGN_FLOOR_DIVIDE = 310,
    DELIM_ASSIGN_MODULO = 311,
    DELIM_ASSIGN_BITWISE_AND = 312,
    DELIM_ASSIGN_BITWISE_OR = 313,
    DELIM_ASSIGN_BITWISE_XOR = 314,
    DELIM_ASSIGN_RIGHT_SHIFT = 315,
    DELIM_ASSIGN_LEFT_SHIFT = 316,
    DELIM_ASSIGN_POWER = 317,
    DELIM_ELLIPSIS = 318,
    NAME = 319,
    INDENT = 320,
    DEDENT = 321,
    NEWLINE = 322,
    FLOAT_NUMBER = 323,
    INTEGER = 324,
    STRING_LITERAL = 325,
    DUNDER_NAME = 326,
    DUNDER_MAIN = 327,
    TYPE_INT = 328,
    TYPE_FLOAT = 329,
    TYPE_STRING = 330,
    TYPE_BOOL = 331,
    TYPE_LIST = 332,
    SELF_DOT = 333
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 602 "parser.y"

    char* strval;
    int intval;

#line 141 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
