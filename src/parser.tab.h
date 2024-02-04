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
    KEY_AWAIT = 259,
    KEY_ELSE = 260,
    KEY_IMPORT = 261,
    KEY_PASS = 262,
    KEY_NONE = 263,
    KEY_BREAK = 264,
    KEY_EXCEPT = 265,
    KEY_IN = 266,
    KEY_RAISE = 267,
    KEY_TRUE = 268,
    KEY_CLASS = 269,
    KEY_FINALLY = 270,
    KEY_IS = 271,
    KEY_RETURN = 272,
    KEY_AND = 273,
    KEY_CONTINUE = 274,
    KEY_FOR = 275,
    KEY_LAMBDA = 276,
    KEY_TRY = 277,
    KEY_AS = 278,
    KEY_DEF = 279,
    KEY_FROM = 280,
    KEY_NONLOCAL = 281,
    KEY_WHILE = 282,
    KEY_ASSERT = 283,
    KEY_DEL = 284,
    KEY_GLOBAL = 285,
    KEY_NOT = 286,
    KEY_WITH = 287,
    KEY_ASYNC = 288,
    KEY_ELIF = 289,
    KEY_IF = 290,
    KEY_OR = 291,
    KEY_YIELD = 292,
    OP_ADD = 293,
    OP_SUBTRACT = 294,
    OP_MULTIPLY = 295,
    OP_POWER = 296,
    OP_DIVIDE = 297,
    OP_FLOOR_DIVIDE = 298,
    OP_MODULO = 299,
    OP_AT = 300,
    OP_LEFT_SHIFT = 301,
    OP_RIGHT_SHIFT = 302,
    OP_BITWISE_AND = 303,
    OP_BITWISE_OR = 304,
    OP_BITWISE_XOR = 305,
    OP_BITWISE_NOT = 306,
    OP_ASSIGN = 307,
    OP_LESS_THAN = 308,
    OP_GREATER_THAN = 309,
    OP_LESS_THAN_EQUAL = 310,
    OP_GREATER_THAN_EQUAL = 311,
    OP_EQUAL = 312,
    OP_NOT_EQUAL = 313,
    DELIM_LEFT_PAREN = 314,
    DELIM_RIGHT_PAREN = 315,
    DELIM_LEFT_BRACKET = 316,
    DELIM_RIGHT_BRACKET = 317,
    DELIM_LEFT_CURLY = 318,
    DELIM_RIGHT_CURLY = 319,
    DELIM_COMMA = 320,
    DELIM_COLON = 321,
    DELIM_DOT = 322,
    DELIM_SEMICOLON = 323,
    DELIM_ASSIGN = 324,
    DELIM_ARROW = 325,
    DELIM_ASSIGN_ADD = 326,
    DELIM_ASSIGN_SUBTRACT = 327,
    DELIM_ASSIGN_MULTIPLY = 328,
    DELIM_ASSIGN_DIVIDE = 329,
    DELIM_ASSIGN_FLOOR_DIVIDE = 330,
    DELIM_ASSIGN_MODULO = 331,
    DELIM_ASSIGN_BITWISE_AND = 332,
    DELIM_ASSIGN_BITWISE_OR = 333,
    DELIM_ASSIGN_BITWISE_XOR = 334,
    DELIM_ASSIGN_RIGHT_SHIFT = 335,
    DELIM_ASSIGN_LEFT_SHIFT = 336,
    DELIM_ASSIGN_POWER = 337,
    DELIM_ELLIPSIS = 338,
    NAME = 339,
    INDENT = 340,
    DEDENT = 341,
    NEWLINE = 342,
    FLOAT_NUMBER = 343,
    IMAGINARY_NUMBER = 344,
    INTEGER = 345,
    STRING_LITERAL = 346,
    DUNDER_INIT = 347,
    DUNDER_NAME = 348,
    DUNDER_MAIN = 349,
    ENDMARKER = 350,
    WILDCARD_UNDERSCORE = 351
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 51 "parser.y"

    char* strval;
    int intval;

#line 159 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
