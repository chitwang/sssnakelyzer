/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "parser.y"

#include<bits/stdc++.h>
using namespace std;
#define YYDEBUG 1

extern int yylineno;

vector<string> nodes;
vector<vector<int>> adj;
int node_count = 0;

typedef struct ast_node {
    char* type;
    char* value;
    struct ast_node* left;
    struct ast_node* right;
} ast_node;

ast_node* new_node(char* type, char* value, ast_node* left, ast_node* right) {
    ast_node* node = (ast_node*)malloc(sizeof(ast_node));
    node->type =  type;
    node->value = value;
    node->left = left;
    node->right = right;
    return node;
}

void print_ast(ast_node* node, FILE* fp) {
    if (node != NULL) {
        fprintf(fp, "\t\"%p\" [label=\"%s\"];\n", node, node->type);
        if (node->left != NULL) {
            fprintf(fp, "\t\"%p\" -> \"%p\";\n", node, node->left);
            print_ast(node->left, fp);
        }
        if (node->right != NULL) {
            fprintf(fp, "\t\"%p\" -> \"%p\";\n", node, node->right);
            print_ast(node->right, fp);
        }
    }
}

extern int yylex(void);
void yyerror(const char*);

ast_node* root;


#line 118 "parser.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif


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
    KEY_PASS = 260,
    KEY_NONE = 261,
    KEY_BREAK = 262,
    KEY_EXCEPT = 263,
    KEY_IN = 264,
    KEY_RAISE = 265,
    KEY_TRUE = 266,
    KEY_CLASS = 267,
    KEY_FINALLY = 268,
    KEY_IS = 269,
    KEY_RETURN = 270,
    KEY_AND = 271,
    KEY_CONTINUE = 272,
    KEY_FOR = 273,
    KEY_LAMBDA = 274,
    KEY_TRY = 275,
    KEY_AS = 276,
    KEY_DEF = 277,
    KEY_FROM = 278,
    KEY_NONLOCAL = 279,
    KEY_WHILE = 280,
    KEY_ASSERT = 281,
    KEY_DEL = 282,
    KEY_GLOBAL = 283,
    KEY_NOT = 284,
    KEY_WITH = 285,
    KEY_ELIF = 286,
    KEY_IF = 287,
    KEY_OR = 288,
    KEY_YIELD = 289,
    OP_ADD = 290,
    OP_SUBTRACT = 291,
    OP_MULTIPLY = 292,
    OP_POWER = 293,
    OP_DIVIDE = 294,
    OP_FLOOR_DIVIDE = 295,
    OP_MODULO = 296,
    OP_AT = 297,
    OP_LEFT_SHIFT = 298,
    OP_RIGHT_SHIFT = 299,
    OP_BITWISE_AND = 300,
    OP_BITWISE_OR = 301,
    OP_BITWISE_XOR = 302,
    OP_BITWISE_NOT = 303,
    OP_ASSIGN = 304,
    OP_LESS_THAN = 305,
    OP_GREATER_THAN = 306,
    OP_LESS_THAN_EQUAL = 307,
    OP_GREATER_THAN_EQUAL = 308,
    OP_EQUAL = 309,
    OP_NOT_EQUAL = 310,
    DELIM_LEFT_PAREN = 311,
    DELIM_RIGHT_PAREN = 312,
    DELIM_LEFT_BRACKET = 313,
    DELIM_RIGHT_BRACKET = 314,
    DELIM_LEFT_CURLY = 315,
    DELIM_RIGHT_CURLY = 316,
    DELIM_COMMA = 317,
    DELIM_COLON = 318,
    DELIM_DOT = 319,
    DELIM_SEMICOLON = 320,
    DELIM_ASSIGN = 321,
    DELIM_ARROW = 322,
    DELIM_ASSIGN_ADD = 323,
    DELIM_ASSIGN_SUBTRACT = 324,
    DELIM_ASSIGN_MULTIPLY = 325,
    DELIM_ASSIGN_DIVIDE = 326,
    DELIM_ASSIGN_FLOOR_DIVIDE = 327,
    DELIM_ASSIGN_MODULO = 328,
    DELIM_ASSIGN_BITWISE_AND = 329,
    DELIM_ASSIGN_BITWISE_OR = 330,
    DELIM_ASSIGN_BITWISE_XOR = 331,
    DELIM_ASSIGN_RIGHT_SHIFT = 332,
    DELIM_ASSIGN_LEFT_SHIFT = 333,
    DELIM_ASSIGN_POWER = 334,
    DELIM_ELLIPSIS = 335,
    NAME = 336,
    INDENT = 337,
    DEDENT = 338,
    NEWLINE = 339,
    FLOAT_NUMBER = 340,
    IMAGINARY_NUMBER = 341,
    INTEGER = 342,
    STRING_LITERAL = 343,
    DUNDER_INIT = 344,
    DUNDER_NAME = 345,
    DUNDER_MAIN = 346,
    ENDMARKER = 347,
    TYPE_INT = 348,
    TYPE_FLOAT = 349,
    TYPE_STRING = 350,
    TYPE_BOOL = 351,
    TYPE_LIST = 352,
    TYPE_DICT = 353,
    WILDCARD_UNDERSCORE = 354
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 51 "parser.y"

    char* strval;
    int intval;

#line 272 "parser.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);





#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  103
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   926

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  100
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  78
/* YYNRULES -- Number of rules.  */
#define YYNRULES  226
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  337

#define YYUNDEFTOK  2
#define YYMAXUTOK   354


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    66,    66,    71,    72,    73,    89,    90,    93,    94,
      96,    97,    99,   100,   101,   103,   104,   108,   109,   111,
     113,   114,   115,   120,   122,   123,   124,   125,   126,   127,
     129,   131,   132,   133,   134,   136,   137,   138,   140,   141,
     142,   143,   145,   146,   148,   149,   151,   152,   153,   154,
     155,   156,   157,   158,   159,   160,   161,   162,   166,   168,
     169,   170,   173,   175,   177,   178,   185,   187,   188,   190,
     192,   193,   195,   196,   197,   198,   199,   201,   202,   203,
     204,   206,   207,   209,   210,   212,   213,   224,   225,   227,
     228,   230,   231,   233,   234,   236,   238,   239,   241,   242,
     244,   245,   247,   248,   250,   251,   252,   253,   254,   255,
     256,   257,   258,   259,   261,   263,   264,   266,   267,   269,
     270,   272,   273,   274,   276,   277,   278,   280,   281,   282,
     283,   284,   285,   287,   288,   289,   290,   292,   293,   295,
     296,   298,   299,   301,   302,   303,   304,   305,   306,   307,
     308,   309,   310,   311,   313,   314,   315,   317,   318,   320,
     321,   323,   324,   325,   327,   328,   329,   330,   332,   333,
     335,   336,   337,   339,   340,   341,   342,   343,   344,   345,
     346,   347,   349,   350,   352,   353,   355,   356,   357,   359,
     360,   361,   363,   364,   365,   366,   367,   369,   370,   371,
     373,   374,   375,   377,   378,   379,   381,   382,   383,   384,
     385,   386,   388,   389,   391,   392,   394,   396,   397,   402,
     403,   417,   418,   419,   420,   421,   422
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "KEY_FALSE", "KEY_ELSE", "KEY_PASS",
  "KEY_NONE", "KEY_BREAK", "KEY_EXCEPT", "KEY_IN", "KEY_RAISE", "KEY_TRUE",
  "KEY_CLASS", "KEY_FINALLY", "KEY_IS", "KEY_RETURN", "KEY_AND",
  "KEY_CONTINUE", "KEY_FOR", "KEY_LAMBDA", "KEY_TRY", "KEY_AS", "KEY_DEF",
  "KEY_FROM", "KEY_NONLOCAL", "KEY_WHILE", "KEY_ASSERT", "KEY_DEL",
  "KEY_GLOBAL", "KEY_NOT", "KEY_WITH", "KEY_ELIF", "KEY_IF", "KEY_OR",
  "KEY_YIELD", "OP_ADD", "OP_SUBTRACT", "OP_MULTIPLY", "OP_POWER",
  "OP_DIVIDE", "OP_FLOOR_DIVIDE", "OP_MODULO", "OP_AT", "OP_LEFT_SHIFT",
  "OP_RIGHT_SHIFT", "OP_BITWISE_AND", "OP_BITWISE_OR", "OP_BITWISE_XOR",
  "OP_BITWISE_NOT", "OP_ASSIGN", "OP_LESS_THAN", "OP_GREATER_THAN",
  "OP_LESS_THAN_EQUAL", "OP_GREATER_THAN_EQUAL", "OP_EQUAL",
  "OP_NOT_EQUAL", "DELIM_LEFT_PAREN", "DELIM_RIGHT_PAREN",
  "DELIM_LEFT_BRACKET", "DELIM_RIGHT_BRACKET", "DELIM_LEFT_CURLY",
  "DELIM_RIGHT_CURLY", "DELIM_COMMA", "DELIM_COLON", "DELIM_DOT",
  "DELIM_SEMICOLON", "DELIM_ASSIGN", "DELIM_ARROW", "DELIM_ASSIGN_ADD",
  "DELIM_ASSIGN_SUBTRACT", "DELIM_ASSIGN_MULTIPLY", "DELIM_ASSIGN_DIVIDE",
  "DELIM_ASSIGN_FLOOR_DIVIDE", "DELIM_ASSIGN_MODULO",
  "DELIM_ASSIGN_BITWISE_AND", "DELIM_ASSIGN_BITWISE_OR",
  "DELIM_ASSIGN_BITWISE_XOR", "DELIM_ASSIGN_RIGHT_SHIFT",
  "DELIM_ASSIGN_LEFT_SHIFT", "DELIM_ASSIGN_POWER", "DELIM_ELLIPSIS",
  "NAME", "INDENT", "DEDENT", "NEWLINE", "FLOAT_NUMBER",
  "IMAGINARY_NUMBER", "INTEGER", "STRING_LITERAL", "DUNDER_INIT",
  "DUNDER_NAME", "DUNDER_MAIN", "ENDMARKER", "TYPE_INT", "TYPE_FLOAT",
  "TYPE_STRING", "TYPE_BOOL", "TYPE_LIST", "TYPE_DICT",
  "WILDCARD_UNDERSCORE", "$accept", "start_symbol", "single_input",
  "funcdef", "parameters", "argument_s", "typedarglist", "tfpdef", "stmt",
  "simple_stmt", "small_or_semi", "small_stmt", "decl_stmt", "expr_stmt",
  "annassign", "testlist_star_expr", "test_or_star", "test_or_star_plus",
  "augassign", "pass_stmt", "flow_stmt", "break_stmt", "continue_stmt",
  "return_stmt", "global_stmt", "names", "nonlocal_stmt", "assert_stmt",
  "compound_stmt", "if_stmt", "elif_plus", "while_stmt", "for_stmt",
  "stmt_plus", "suite", "namedexpr_test", "test", "test_nocond", "or_test",
  "and_test", "not_test", "comparison", "comp_op", "star_expr", "expr",
  "xor_expr", "and_expr", "shift_expr", "arith_expr", "term", "factor",
  "power", "atom_expr", "string_plus", "atom", "number", "testlist_comp",
  "named_or_star", "named_star_plus", "trailer", "trailer_plus",
  "subscriptlist", "subscript", "sliceop", "common_expr", "exprlist",
  "testlist", "dictorsetmaker", "test_test_plus", "classdef", "arglist",
  "argument", "comp_iter", "sync_comp_for", "comp_for", "comp_if",
  "func_body_suite", "types", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348,   349,   350,   351,   352,   353,   354
};
# endif

#define YYPACT_NINF (-244)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      38,  -244,  -244,  -244,  -244,  -244,    25,   690,  -244,   779,
      35,    40,   827,   827,    40,   827,   827,   838,   838,   838,
     838,   589,   604,  -244,     6,  -244,  -244,  -244,  -244,  -244,
      71,  -244,  -244,  -244,     8,    26,  -244,  -244,   117,    41,
    -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,    51,  -244,
    -244,  -244,  -244,   104,   105,   125,  -244,  -244,    28,    96,
      98,   101,    -8,    11,    60,  -244,   111,    55,    29,  -244,
    -244,    32,  -244,  -244,  -244,  -244,    88,   142,   108,    92,
    -244,   107,   112,   109,  -244,  -244,   110,  -244,  -244,  -244,
    -244,  -244,  -244,  -244,   113,    14,  -244,  -244,    15,   114,
     106,  -244,    17,  -244,  -244,   432,   827,  -244,  -244,  -244,
    -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,
     827,   690,   119,  -244,   827,   827,   827,  -244,   145,   174,
    -244,  -244,  -244,  -244,  -244,  -244,   838,   838,   838,   838,
     838,   838,   838,   838,   838,   838,   838,   838,   838,   838,
    -244,   503,   202,   103,  -244,    29,   518,   330,   779,   827,
     -27,     5,    40,   330,   827,   827,   330,  -244,   779,   690,
    -244,  -244,   690,   137,  -244,   827,  -244,  -244,  -244,  -244,
    -244,  -244,  -244,  -244,  -244,   151,   139,  -244,  -244,  -244,
     198,  -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,
    -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,   827,
     827,  -244,    -1,   147,   144,   738,   146,   148,   149,  -244,
    -244,   152,   155,   132,  -244,  -244,  -244,   153,  -244,   154,
     156,   162,   157,   416,   827,  -244,   216,  -244,  -244,    30,
     212,   163,  -244,  -244,    22,   690,   827,  -244,   827,  -244,
    -244,   827,   827,  -244,  -244,   675,   827,   161,  -244,   738,
    -244,   202,   330,   164,   295,   330,   827,   165,  -244,   827,
     150,  -244,  -244,   166,   167,   170,   827,   222,   827,   827,
    -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,  -244,   161,
    -244,  -244,  -244,   330,   295,  -244,  -244,   159,   224,  -244,
    -244,  -244,   295,   416,   330,   330,   182,   185,    20,   188,
    -244,  -244,  -244,  -244,  -244,   189,   172,  -244,  -244,  -244,
     330,   330,   827,  -244,  -244,  -244,   827,   330,  -244,   225,
    -244,    20,  -244,   191,  -244,  -244,  -244
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,   153,    58,   151,    62,   152,     0,    65,    63,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   150,   147,     3,   155,   156,   154,   142,
       0,     2,    75,     4,     0,    20,    29,    23,    34,    40,
      24,    25,    59,    60,    61,    26,    27,    28,     0,    72,
      73,    74,    42,    93,    96,    98,   101,    43,   102,   115,
     117,   119,   121,   124,   127,   136,   137,   149,   139,   148,
      76,     0,   147,    64,   185,   184,   186,     0,     0,    67,
      69,     0,    91,    71,    66,   100,     0,   134,   135,   114,
     133,   144,   159,   160,     0,   161,   158,   146,     0,    42,
       0,   193,     0,     1,    19,    21,     0,    46,    47,    48,
      49,    57,    50,    51,    52,    53,    55,    54,    56,    31,
      32,    41,    38,     5,     0,     0,     0,   110,   112,     0,
     104,   105,   108,   107,   106,   109,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     141,     0,     0,     0,   169,   140,     0,     0,   188,     0,
       0,     0,     0,     0,     0,     0,     0,   143,     0,   162,
     216,   157,     0,   195,   194,     0,   145,   221,   224,   226,
     222,   225,   223,    30,    22,    35,   189,    33,    44,    39,
       0,    97,    99,   113,   111,   103,   116,   118,   120,   122,
     123,   125,   126,   128,   130,   132,   131,   129,   138,     0,
       0,   165,   207,     0,   203,   174,   173,     0,   170,   167,
     168,     0,     0,     0,    89,   202,   187,     0,     9,    16,
      13,     0,    11,     0,     0,    68,    84,    92,    70,    77,
       0,   161,   163,   196,   197,    36,   191,    45,     0,   211,
     210,     0,     0,   206,   164,   205,   182,   176,   175,   178,
     166,   172,     0,     0,     0,     0,     0,    12,     8,     0,
       0,   219,     7,     0,     0,     0,     0,    78,     0,   198,
     192,    37,   190,    94,   208,   209,   204,   183,   177,   180,
     179,   171,   201,     0,    87,    17,    18,     0,    86,    15,
      14,    10,     0,     0,     0,     0,     0,     0,   215,     0,
     199,   181,   200,    88,    90,     0,     0,     6,    83,    79,
       0,     0,     0,   214,   212,   213,     0,     0,   220,    81,
      80,   218,    95,   197,    85,    82,   217
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -244,  -244,  -244,  -244,  -244,  -244,    -9,  -244,  -244,     2,
     158,  -244,  -244,  -244,  -244,    -4,   -14,   -83,  -244,  -244,
    -244,  -244,  -244,  -244,  -244,     0,  -244,  -244,   259,  -244,
     -68,  -244,  -244,  -243,  -145,    -5,   -12,  -244,  -112,   143,
     253,   134,  -244,    10,    -3,   135,   133,   -51,   -10,   -17,
       7,  -244,  -244,  -244,  -244,  -244,  -244,   115,   116,   120,
    -244,    13,  -244,  -231,  -244,  -129,  -137,  -244,    -2,  -244,
    -151,  -244,   -55,  -244,   -75,  -244,   -25,  -244
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    30,    31,    32,   161,   230,   231,   232,   294,   224,
      34,    35,    36,    37,   119,    38,    39,   122,   120,    40,
      41,    42,    43,    44,    45,    80,    46,    47,   296,    49,
     277,    50,    51,   297,   225,    92,    52,   331,    53,    54,
      55,    56,   136,    57,    58,    59,    60,    61,    62,    63,
      64,    65,    66,    67,    68,    69,    94,    95,    96,   154,
     155,   217,   218,   258,    76,    77,   187,   100,   101,    70,
     213,   214,   323,   170,   324,   325,   272,   183
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      82,    83,    33,    73,    82,   222,    75,    81,    98,    82,
      99,    86,   190,   191,    84,   173,    89,   168,   236,    74,
     171,   239,   227,   174,    87,    88,   288,    90,   290,   226,
     228,    93,   168,   168,   275,   140,   141,   127,   168,   240,
     168,     1,   128,     2,     3,     4,   142,   143,   251,     5,
       6,   313,   322,     7,   229,     8,     9,   129,   311,   316,
      10,   276,    11,    12,    13,   252,    14,    15,   233,   102,
      16,   103,   234,    17,    18,    19,   169,   172,   130,   131,
     132,   133,   134,   135,   279,   151,    20,   152,   156,   199,
     200,   105,   104,   153,   185,   157,    21,   144,    22,   145,
     146,   147,   148,   121,   286,   247,    71,   188,   186,   282,
     177,   178,   179,   180,   181,   182,    78,   292,    23,    24,
     298,    79,    25,    26,    27,    28,    29,   203,   204,   205,
     206,   207,   201,   202,   196,   123,   124,   253,   125,   212,
     216,   126,   137,   150,   212,   138,   139,   186,   312,   149,
     158,   159,   237,   238,   162,    75,   208,    82,   188,   318,
     319,   164,   235,   244,   160,    75,   308,   176,    74,   280,
     163,   165,   167,   166,   193,   329,   330,   175,    74,    93,
     106,   189,   334,   194,   219,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,   118,   249,   250,   243,
     245,   246,   248,   257,   254,     1,   255,   260,     3,   259,
     332,   261,   263,     5,   264,   262,   265,   266,   267,   268,
     274,   278,   273,   269,   256,   169,   307,   293,   315,   303,
     304,    15,   302,   305,   186,   271,   283,    17,    18,   284,
     285,   281,   314,   212,   287,   320,   229,   289,   321,   216,
      20,   326,   327,   279,   299,   328,   276,   301,   300,    48,
      21,   335,    22,   184,    82,   215,   295,   309,    85,   192,
     195,   306,   198,   197,   291,   220,   336,   310,   317,     0,
       0,     0,    23,    72,   241,   242,     0,    26,    27,    28,
      29,     0,     0,     0,     0,     0,   295,     0,     1,     0,
       2,     3,     4,     0,   295,   271,     5,     6,     0,     0,
       7,     0,     8,     9,   333,     0,     0,    10,     0,    11,
      12,    13,     0,    14,    15,     0,     0,    16,     0,     0,
      17,    18,    19,     1,     0,     2,     3,     4,     0,     0,
       0,     5,     0,    20,     0,     7,     0,     8,     0,     0,
       0,     0,     0,    21,    11,    22,    13,     0,    14,    15,
       0,     0,     0,     0,     0,    17,    18,    19,     0,     0,
       0,     0,     0,     0,     0,    23,    24,     0,    20,     0,
      26,    27,    28,    29,     0,     0,     0,     0,    21,     0,
      22,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      23,    24,     0,     0,   223,    26,    27,    28,    29,     1,
       0,     2,     3,     4,     0,     0,     0,     5,     0,     0,
       0,     7,     0,     8,     0,     1,     0,     2,     3,     4,
      11,     0,    13,     5,    14,    15,     0,     7,     0,     8,
       0,    17,    18,    19,     0,     0,    11,     0,    13,     0,
      14,    15,     0,     0,    20,     0,     0,    17,    18,    19,
       0,     0,     0,     0,    21,     0,    22,     0,     0,     0,
      20,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      21,     0,    22,     0,     0,     0,    23,    24,     0,     0,
     270,    26,    27,    28,    29,     0,     1,     0,     0,     3,
       0,     0,    23,    24,     5,     0,     0,    26,    27,    28,
      29,     1,     0,     0,     3,     0,     0,     0,     0,     5,
       0,     0,    15,     0,     0,     0,     0,     0,    17,    18,
     209,   210,     0,     0,     0,     0,     0,    15,     0,     0,
       0,    20,     0,    17,    18,   209,   210,     0,     0,     0,
     211,    21,     0,    22,     0,     0,    20,     0,     0,     0,
       0,     0,     0,     0,     0,   221,    21,     0,    22,     0,
       0,     0,     0,    23,    72,     0,     0,     0,    26,    27,
      28,    29,     1,     0,     0,     3,     0,     0,    23,    72,
       5,     0,     0,    26,    27,    28,    29,     1,     0,     0,
       3,     0,     0,     0,     0,     5,     0,     0,    15,     0,
       0,     0,     0,     0,    17,    18,    19,     0,     0,     0,
       0,     0,     0,    15,     0,     0,     0,    20,     0,    17,
      18,    19,     0,     0,     0,     0,     0,    21,    91,    22,
       0,     0,    20,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    21,     0,    22,    97,     0,     0,     0,    23,
      72,     0,     0,     0,    26,    27,    28,    29,     1,     0,
       0,     3,     0,     0,    23,    72,     5,     0,     0,    26,
      27,    28,    29,     1,     0,     0,     3,     0,     0,     0,
       0,     5,     0,     0,    15,     0,     0,     0,     0,     0,
      17,    18,   209,   210,     0,     0,     0,     0,     0,    15,
       0,     0,     0,    20,     0,    17,    18,    19,     0,     0,
       0,     0,     0,    21,     0,    22,     0,     0,    20,     0,
       0,     1,     0,     0,     3,     0,     0,     0,    21,     5,
      22,     0,     0,     0,     0,    23,    72,     0,     0,     0,
      26,    27,    28,    29,     0,     0,     0,    15,     0,     0,
      23,    72,     0,    17,    18,    26,    27,    28,    29,     0,
       0,     0,     1,     0,     0,     3,    20,     0,     0,     0,
       5,     0,     0,     0,     0,     0,    21,     0,    22,     0,
       0,   256,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    17,    18,    19,     0,    23,    72,
       0,     0,     0,    26,    27,    28,    29,    20,     0,     0,
       1,     0,     0,     3,     0,     0,     0,    21,     5,    22,
       0,     1,     0,     0,     3,     0,     0,     0,     0,     5,
       0,     0,     0,     0,     0,     0,    15,     0,     0,    23,
      72,     0,    17,    18,    26,    27,    28,    29,     0,     0,
       0,     0,     0,    17,    18,    20,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    21,    20,    22,     0,     0,
       0,     0,     0,     0,     0,     0,    21,     0,    22,     0,
       0,     0,     0,     0,     0,     0,     0,    23,    72,     0,
       0,     0,    26,    27,    28,    29,     0,     0,    23,    72,
       0,     0,     0,    26,    27,    28,    29
};

static const yytype_int16 yycheck[] =
{
      12,    13,     0,     7,    16,   156,     9,    12,    22,    21,
      22,    16,   124,   125,    14,    98,    19,    18,   163,     9,
      95,   166,   159,    98,    17,    18,   257,    20,   259,   158,
      57,    21,    18,    18,     4,    43,    44,     9,    18,   168,
      18,     3,    14,     5,     6,     7,    35,    36,    49,    11,
      12,   294,    32,    15,    81,    17,    18,    29,   289,   302,
      22,    31,    24,    25,    26,    66,    28,    29,    63,    63,
      32,     0,    67,    35,    36,    37,    62,    62,    50,    51,
      52,    53,    54,    55,    62,    56,    48,    58,    56,   140,
     141,    65,    84,    64,   106,    63,    58,    37,    60,    39,
      40,    41,    42,    62,   255,   188,    81,   121,   120,   246,
      93,    94,    95,    96,    97,    98,    81,   262,    80,    81,
     265,    81,    84,    85,    86,    87,    88,   144,   145,   146,
     147,   148,   142,   143,   137,    84,    32,   212,    33,   151,
     152,    16,    46,    88,   156,    47,    45,   159,   293,    38,
      62,     9,   164,   165,    62,   158,   149,   169,   172,   304,
     305,    49,   162,   175,    56,   168,   278,    61,   158,   244,
      63,    62,    59,    63,    29,   320,   321,    63,   168,   169,
      63,    62,   327,     9,    81,    68,    69,    70,    71,    72,
      73,    74,    75,    76,    77,    78,    79,   209,   210,    62,
      49,    62,     4,   215,    57,     3,    62,    59,     6,    63,
     322,    62,    57,    11,    82,    63,    63,    63,    62,    57,
       4,     9,   234,    66,    63,    62,     4,    63,     4,    63,
      63,    29,    82,    63,   246,   233,   248,    35,    36,   251,
     252,   245,    83,   255,   256,    63,    81,   259,    63,   261,
      48,    63,    63,    62,   266,    83,    31,   269,   267,     0,
      58,   329,    60,   105,   276,    63,   264,   279,    15,   126,
     136,   276,   139,   138,   261,   155,   331,   279,   303,    -1,
      -1,    -1,    80,    81,   169,   169,    -1,    85,    86,    87,
      88,    -1,    -1,    -1,    -1,    -1,   294,    -1,     3,    -1,
       5,     6,     7,    -1,   302,   303,    11,    12,    -1,    -1,
      15,    -1,    17,    18,   326,    -1,    -1,    22,    -1,    24,
      25,    26,    -1,    28,    29,    -1,    -1,    32,    -1,    -1,
      35,    36,    37,     3,    -1,     5,     6,     7,    -1,    -1,
      -1,    11,    -1,    48,    -1,    15,    -1,    17,    -1,    -1,
      -1,    -1,    -1,    58,    24,    60,    26,    -1,    28,    29,
      -1,    -1,    -1,    -1,    -1,    35,    36,    37,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    80,    81,    -1,    48,    -1,
      85,    86,    87,    88,    -1,    -1,    -1,    -1,    58,    -1,
      60,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      80,    81,    -1,    -1,    84,    85,    86,    87,    88,     3,
      -1,     5,     6,     7,    -1,    -1,    -1,    11,    -1,    -1,
      -1,    15,    -1,    17,    -1,     3,    -1,     5,     6,     7,
      24,    -1,    26,    11,    28,    29,    -1,    15,    -1,    17,
      -1,    35,    36,    37,    -1,    -1,    24,    -1,    26,    -1,
      28,    29,    -1,    -1,    48,    -1,    -1,    35,    36,    37,
      -1,    -1,    -1,    -1,    58,    -1,    60,    -1,    -1,    -1,
      48,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      58,    -1,    60,    -1,    -1,    -1,    80,    81,    -1,    -1,
      84,    85,    86,    87,    88,    -1,     3,    -1,    -1,     6,
      -1,    -1,    80,    81,    11,    -1,    -1,    85,    86,    87,
      88,     3,    -1,    -1,     6,    -1,    -1,    -1,    -1,    11,
      -1,    -1,    29,    -1,    -1,    -1,    -1,    -1,    35,    36,
      37,    38,    -1,    -1,    -1,    -1,    -1,    29,    -1,    -1,
      -1,    48,    -1,    35,    36,    37,    38,    -1,    -1,    -1,
      57,    58,    -1,    60,    -1,    -1,    48,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    57,    58,    -1,    60,    -1,
      -1,    -1,    -1,    80,    81,    -1,    -1,    -1,    85,    86,
      87,    88,     3,    -1,    -1,     6,    -1,    -1,    80,    81,
      11,    -1,    -1,    85,    86,    87,    88,     3,    -1,    -1,
       6,    -1,    -1,    -1,    -1,    11,    -1,    -1,    29,    -1,
      -1,    -1,    -1,    -1,    35,    36,    37,    -1,    -1,    -1,
      -1,    -1,    -1,    29,    -1,    -1,    -1,    48,    -1,    35,
      36,    37,    -1,    -1,    -1,    -1,    -1,    58,    59,    60,
      -1,    -1,    48,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    58,    -1,    60,    61,    -1,    -1,    -1,    80,
      81,    -1,    -1,    -1,    85,    86,    87,    88,     3,    -1,
      -1,     6,    -1,    -1,    80,    81,    11,    -1,    -1,    85,
      86,    87,    88,     3,    -1,    -1,     6,    -1,    -1,    -1,
      -1,    11,    -1,    -1,    29,    -1,    -1,    -1,    -1,    -1,
      35,    36,    37,    38,    -1,    -1,    -1,    -1,    -1,    29,
      -1,    -1,    -1,    48,    -1,    35,    36,    37,    -1,    -1,
      -1,    -1,    -1,    58,    -1,    60,    -1,    -1,    48,    -1,
      -1,     3,    -1,    -1,     6,    -1,    -1,    -1,    58,    11,
      60,    -1,    -1,    -1,    -1,    80,    81,    -1,    -1,    -1,
      85,    86,    87,    88,    -1,    -1,    -1,    29,    -1,    -1,
      80,    81,    -1,    35,    36,    85,    86,    87,    88,    -1,
      -1,    -1,     3,    -1,    -1,     6,    48,    -1,    -1,    -1,
      11,    -1,    -1,    -1,    -1,    -1,    58,    -1,    60,    -1,
      -1,    63,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    35,    36,    37,    -1,    80,    81,
      -1,    -1,    -1,    85,    86,    87,    88,    48,    -1,    -1,
       3,    -1,    -1,     6,    -1,    -1,    -1,    58,    11,    60,
      -1,     3,    -1,    -1,     6,    -1,    -1,    -1,    -1,    11,
      -1,    -1,    -1,    -1,    -1,    -1,    29,    -1,    -1,    80,
      81,    -1,    35,    36,    85,    86,    87,    88,    -1,    -1,
      -1,    -1,    -1,    35,    36,    48,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    58,    48,    60,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    58,    -1,    60,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    80,    81,    -1,
      -1,    -1,    85,    86,    87,    88,    -1,    -1,    80,    81,
      -1,    -1,    -1,    85,    86,    87,    88
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     5,     6,     7,    11,    12,    15,    17,    18,
      22,    24,    25,    26,    28,    29,    32,    35,    36,    37,
      48,    58,    60,    80,    81,    84,    85,    86,    87,    88,
     101,   102,   103,   109,   110,   111,   112,   113,   115,   116,
     119,   120,   121,   122,   123,   124,   126,   127,   128,   129,
     131,   132,   136,   138,   139,   140,   141,   143,   144,   145,
     146,   147,   148,   149,   150,   151,   152,   153,   154,   155,
     169,    81,    81,   115,   143,   144,   164,   165,    81,    81,
     125,   135,   136,   136,   125,   140,   135,   150,   150,   144,
     150,    59,   135,   143,   156,   157,   158,    61,   116,   136,
     167,   168,    63,     0,    84,    65,    63,    68,    69,    70,
      71,    72,    73,    74,    75,    76,    77,    78,    79,   114,
     118,    62,   117,    84,    32,    33,    16,     9,    14,    29,
      50,    51,    52,    53,    54,    55,   142,    46,    47,    45,
      43,    44,    35,    36,    37,    39,    40,    41,    42,    38,
      88,    56,    58,    64,   159,   160,    56,    63,    62,     9,
      56,   104,    62,    63,    49,    62,    63,    59,    18,    62,
     173,   174,    62,   117,   174,    63,    61,    93,    94,    95,
      96,    97,    98,   177,   110,   136,   136,   166,   116,    62,
     138,   138,   139,    29,     9,   141,   144,   145,   146,   147,
     147,   148,   148,   149,   149,   149,   149,   149,   150,    37,
      38,    57,   136,   170,   171,    63,   136,   161,   162,    81,
     159,    57,   170,    84,   109,   134,   165,   166,    57,    81,
     105,   106,   107,    63,    67,   125,   134,   136,   136,   134,
     165,   157,   158,    62,   136,    49,    62,   117,     4,   136,
     136,    49,    66,   174,    57,    62,    63,   136,   163,    63,
      59,    62,    63,    57,    82,    63,    63,    62,    57,    66,
      84,   109,   176,   136,     4,     4,    31,   130,     9,    62,
     174,   115,   166,   136,   136,   136,   170,   136,   163,   136,
     163,   161,   134,    63,   108,   109,   128,   133,   134,   136,
     106,   136,    82,    63,    63,    63,   135,     4,   138,   136,
     168,   163,   134,   133,    83,     4,   133,   176,   134,   134,
      63,    63,    32,   172,   174,   175,    63,    63,    83,   134,
     134,   137,   138,   136,   134,   130,   172
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,   100,   101,   102,   102,   102,   103,   103,   104,   104,
     105,   105,   106,   106,   106,   107,   107,   108,   108,   109,
     110,   110,   110,   111,   111,   111,   111,   111,   111,   111,
     112,   113,   113,   113,   113,   114,   114,   114,   115,   115,
     115,   115,   116,   116,   117,   117,   118,   118,   118,   118,
     118,   118,   118,   118,   118,   118,   118,   118,   119,   120,
     120,   120,   121,   122,   123,   123,   124,   125,   125,   126,
     127,   127,   128,   128,   128,   128,   128,   129,   129,   129,
     129,   130,   130,   131,   131,   132,   132,   133,   133,   134,
     134,   135,   135,   136,   136,   137,   138,   138,   139,   139,
     140,   140,   141,   141,   142,   142,   142,   142,   142,   142,
     142,   142,   142,   142,   143,   144,   144,   145,   145,   146,
     146,   147,   147,   147,   148,   148,   148,   149,   149,   149,
     149,   149,   149,   150,   150,   150,   150,   151,   151,   152,
     152,   153,   153,   154,   154,   154,   154,   154,   154,   154,
     154,   154,   154,   154,   155,   155,   155,   156,   156,   157,
     157,   158,   158,   158,   159,   159,   159,   159,   160,   160,
     161,   161,   161,   162,   162,   162,   162,   162,   162,   162,
     162,   162,   163,   163,   164,   164,   165,   165,   165,   166,
     166,   166,   167,   167,   167,   167,   167,   168,   168,   168,
     169,   169,   169,   170,   170,   170,   171,   171,   171,   171,
     171,   171,   172,   172,   173,   173,   174,   175,   175,   176,
     176,   177,   177,   177,   177,   177,   177
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     1,     2,     7,     5,     3,     2,
       3,     1,     2,     1,     3,     3,     1,     1,     1,     2,
       1,     2,     3,     1,     1,     1,     1,     1,     1,     1,
       3,     2,     2,     3,     1,     2,     3,     4,     2,     3,
       1,     2,     1,     1,     2,     3,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     2,     1,     2,     1,     3,     2,
       4,     2,     1,     1,     1,     1,     1,     4,     5,     7,
       8,     4,     5,     7,     4,     9,     6,     1,     2,     1,
       4,     1,     3,     1,     5,     1,     1,     3,     1,     3,
       2,     1,     1,     3,     1,     1,     1,     1,     1,     1,
       1,     2,     1,     2,     2,     1,     3,     1,     3,     1,
       3,     1,     3,     3,     1,     3,     3,     1,     3,     3,
       3,     3,     3,     2,     2,     2,     1,     1,     3,     1,
       2,     2,     1,     3,     2,     3,     2,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     2,     1,     1,
       1,     1,     2,     3,     3,     2,     3,     2,     2,     1,
       1,     3,     2,     1,     1,     2,     2,     3,     2,     3,
       3,     4,     1,     2,     1,     1,     1,     3,     2,     1,
       3,     2,     4,     1,     2,     2,     3,     3,     4,     5,
       7,     6,     4,     1,     3,     2,     2,     1,     3,     3,
       2,     2,     1,     1,     5,     4,     1,     3,     2,     1,
       4,     1,     1,     1,     1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {

#line 1852 "parser.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 424 "parser.y"



int main() {
    yyparse();
    return 0;
}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}
