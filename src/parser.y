%{
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

%}

%define parse.error verbose

%union{
    char* strval;
    int intval;
}

%token KEY_FALSE KEY_AWAIT KEY_ELSE KEY_IMPORT KEY_PASS KEY_NONE KEY_BREAK KEY_EXCEPT KEY_IN KEY_RAISE KEY_TRUE KEY_CLASS KEY_FINALLY KEY_IS KEY_RETURN KEY_AND KEY_CONTINUE KEY_FOR KEY_LAMBDA KEY_TRY KEY_AS KEY_DEF KEY_FROM KEY_NONLOCAL KEY_WHILE KEY_ASSERT KEY_DEL KEY_GLOBAL KEY_NOT KEY_WITH KEY_ASYNC KEY_ELIF KEY_IF KEY_OR KEY_YIELD OP_ADD OP_SUBTRACT OP_MULTIPLY OP_POWER OP_DIVIDE OP_FLOOR_DIVIDE OP_MODULO OP_AT OP_LEFT_SHIFT OP_RIGHT_SHIFT OP_BITWISE_AND OP_BITWISE_OR OP_BITWISE_XOR OP_BITWISE_NOT OP_ASSIGN OP_LESS_THAN OP_GREATER_THAN OP_LESS_THAN_EQUAL OP_GREATER_THAN_EQUAL OP_EQUAL OP_NOT_EQUAL DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET DELIM_LEFT_CURLY DELIM_RIGHT_CURLY DELIM_COMMA DELIM_COLON DELIM_DOT DELIM_SEMICOLON DELIM_ASSIGN DELIM_ARROW DELIM_ASSIGN_ADD DELIM_ASSIGN_SUBTRACT DELIM_ASSIGN_MULTIPLY DELIM_ASSIGN_DIVIDE DELIM_ASSIGN_FLOOR_DIVIDE DELIM_ASSIGN_MODULO DELIM_ASSIGN_BITWISE_AND DELIM_ASSIGN_BITWISE_OR DELIM_ASSIGN_BITWISE_XOR DELIM_ASSIGN_RIGHT_SHIFT DELIM_ASSIGN_LEFT_SHIFT DELIM_ASSIGN_POWER DELIM_ELLIPSIS NAME INDENT DEDENT NEWLINE FLOAT_NUMBER IMAGINARY_NUMBER INTEGER STRING_LITERAL DUNDER_INIT DUNDER_NAME DUNDER_MAIN ENDMARKER WILDCARD_UNDERSCORE

%type start_symbol single_input eval_input file_input simple_stmt compound_stmt stmt parameters file_plus func_body_suite test typedarglist tfpdef vfpdef testlist newline_plus small_stmt expr_stmt del_stmt pass_stmt flow_stmt global_stmt nonlocal_stmt assert_stmt small_or_semi argument_s star_expr test_or_star test_or_star_plus break_stmt continue_stmt exprlist return_stmt names dotted_name classdef if_stmt while_stmt funcdef for_stmt namedexpr_test elif_plus or_test suite stmt_plus and_test not_test comparison expr comp_op xor_expr and_expr shift_expr arith_expr term factor power atom_expr atom trailer_plus trailer argument named_or_star named_star_plus number testlist_comp comp_for arglist subscriptlist sliceop test_test_plus common_expr comp_iter sync_comp_for comp_if encoding_decl 

%start start_symbol

%left DELIM_COMMA

%%

start_symbol: single_input
            /* | eval_input */
            /* | file_input */
            /* | func_type_input */

single_input: NEWLINE
            | simple_stmt
            | compound_stmt NEWLINE

file_input: file_plus ENDMARKER
          | ENDMARKER

file_plus: NEWLINE file_plus
         | stmt file_plus
         | NEWLINE
         | stmt

eval_input: testlist newline_plus ENDMARKER
          | testlist ENDMARKER

newline_plus: newline_plus NEWLINE
            | NEWLINE

funcdef: KEY_DEF NAME parameters DELIM_ARROW test DELIM_COLON func_body_suite
       | KEY_DEF NAME parameters DELIM_COLON func_body_suite

parameters: DELIM_LEFT_PAREN typedarglist DELIM_RIGHT_PAREN
          | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN

argument_s : tfpdef DELIM_ASSIGN test
           | tfpdef

typedarglist : argument_s DELIM_COMMA
             | argument_s
             | argument_s DELIM_COMMA typedarglist
    
tfpdef: NAME DELIM_COLON test
      | NAME

vfpdef: NAME

stmt: simple_stmt
    | compound_stmt

simple_stmt: small_or_semi NEWLINE
           /* | small_stmt DELIM_SEMICOLON NEWLINE
           | small_stmt small_stmt_plus NEWLINE
           | small_stmt small_stmt_plus DELIM_SEMICOLON NEWLINE */

small_or_semi: small_stmt
             | small_stmt DELIM_SEMICOLON
             | small_stmt DELIM_SEMICOLON small_or_semi

small_stmt_plus: DELIM_SEMICOLON small_stmt small_stmt_plus
               | DELIM_SEMICOLON small_stmt

small_stmt: expr_stmt 
          | del_stmt 
          | pass_stmt 
          | flow_stmt 
          | global_stmt 
          | nonlocal_stmt 
          | assert_stmt
        
expr_stmt: testlist_star_expr annassign
         | testlist_star_expr augassign
         | testlist_star_expr augassign testlist
         | testlist_star_expr
         
annassign: DELIM_COLON test
         | DELIM_COLON test OP_ASSIGN
         | DELIM_COLON test OP_ASSIGN testlist_star_expr

testlist_star_expr: test_or_star test_or_star_plus 
                  | test_or_star test_or_star_plus DELIM_COMMA
                  | test_or_star
                  | test_or_star DELIM_COMMA

test_or_star: test
            | star_expr
            
test_or_star_plus:  DELIM_COMMA test_or_star
                 |  DELIM_COMMA test_or_star  test_or_star_plus

augassign: DELIM_ASSIGN_ADD 
         | DELIM_ASSIGN_SUBTRACT 
         | DELIM_ASSIGN_MULTIPLY 
         | DELIM_ASSIGN_DIVIDE 
         | DELIM_ASSIGN_MODULO 
         | DELIM_ASSIGN_BITWISE_AND
         | DELIM_ASSIGN_BITWISE_OR
         | DELIM_ASSIGN_BITWISE_XOR
         | DELIM_ASSIGN_LEFT_SHIFT
         | DELIM_ASSIGN_RIGHT_SHIFT
         | DELIM_ASSIGN_POWER
         | DELIM_ASSIGN_FLOOR_DIVIDE

del_stmt: KEY_DEL exprlist

pass_stmt: KEY_PASS

flow_stmt: break_stmt 
         | continue_stmt 
         | return_stmt 
         /* | raise_stmt  */

break_stmt: KEY_BREAK

continue_stmt: KEY_CONTINUE

return_stmt: KEY_RETURN testlist_star_expr
           | KEY_RETURN

/* raise_stmt: 'raise' [test ['from' test]] */

dotted_name: NAME 
           | NAME DELIM_DOT dotted_name

global_stmt: KEY_GLOBAL names
 
names: NAME
     | NAME DELIM_COMMA names

nonlocal_stmt: KEY_NONLOCAL names

assert_stmt: KEY_ASSERT test DELIM_COMMA test
           | KEY_ASSERT test

compound_stmt: if_stmt 
             | while_stmt 
             | for_stmt 
             | funcdef 
             | classdef
 
if_stmt: KEY_IF namedexpr_test DELIM_COLON suite
       | KEY_IF namedexpr_test DELIM_COLON suite elif_plus
       | KEY_IF namedexpr_test DELIM_COLON suite KEY_ELSE DELIM_COLON suite
       | KEY_IF namedexpr_test DELIM_COLON suite elif_plus KEY_ELSE DELIM_COLON suite

elif_plus: KEY_ELIF namedexpr_test DELIM_COLON suite
         | KEY_ELIF namedexpr_test DELIM_COLON suite elif_plus

while_stmt: KEY_WHILE namedexpr_test DELIM_COLON suite KEY_ELSE DELIM_COLON suite
          |  KEY_WHILE namedexpr_test DELIM_COLON suite

for_stmt: KEY_FOR exprlist KEY_IN testlist DELIM_COLON suite KEY_ELSE DELIM_COLON suite
        | KEY_FOR exprlist KEY_IN testlist DELIM_COLON suite

/* try_stmt: ('try' DELIM_COLON suite
           ((except_clause DELIM_COLON suite)+
            [KEY_ELSE DELIM_COLON suite]
            ['finally' DELIM_COLON suite] |
           'finally' DELIM_COLON suite)) */


/* except_clause: 'except' [test ['as' NAME]] */

stmt_plus : stmt
          | stmt stmt_plus
        
suite: simple_stmt 
     | NEWLINE INDENT stmt_plus DEDENT

namedexpr_test: test
              | test OP_ASSIGN test
    
test: or_test 
    | or_test KEY_IF or_test KEY_ELSE test

test_nocond: or_test

or_test: and_test
       | and_test KEY_OR or_test

and_test: not_test
        | not_test KEY_AND and_test

not_test: KEY_NOT not_test
        | comparison
        
comparison: expr
          | expr comp_op comparison

comp_op: OP_LESS_THAN
       | OP_GREATER_THAN
       | OP_EQUAL
       | OP_GREATER_THAN_EQUAL
       | OP_LESS_THAN_EQUAL
       | OP_NOT_EQUAL
       | KEY_IN
       | KEY_NOT KEY_IN
       | KEY_IS
       | KEY_IS KEY_NOT          

star_expr: OP_MULTIPLY expr

expr: xor_expr
    | xor_expr OP_BITWISE_OR expr

xor_expr: and_expr
        | and_expr OP_BITWISE_XOR xor_expr

and_expr: shift_expr
        | shift_expr OP_BITWISE_AND and_expr
        
shift_expr: arith_expr
          | arith_expr OP_LEFT_SHIFT shift_expr
          | arith_expr OP_RIGHT_SHIFT shift_expr

arith_expr: term
          | term OP_ADD arith_expr
          | term OP_SUBTRACT arith_expr

term: factor
    | factor OP_MULTIPLY term
    | factor OP_AT term
    | factor OP_DIVIDE term
    | factor OP_MODULO term
    | factor OP_FLOOR_DIVIDE term

factor: OP_BITWISE_NOT factor
      | OP_ADD factor
      | OP_SUBTRACT factor
      | power

power: atom_expr 
     | atom_expr OP_POWER factor
    
atom_expr: atom
         | atom trailer_plus

string_plus : string_plus STRING_LITERAL
            | STRING_LITERAL

atom: DELIM_LEFT_BRACKET testlist_comp DELIM_RIGHT_BRACKET
    | DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET
    /* | DELIM_LEFT_CURLY dictorsetmaker DELIM_RIGHT_CURLY */
    | DELIM_LEFT_CURLY DELIM_RIGHT_CURLY
    | NAME 
    | number
    | string_plus 
    | DELIM_ELLIPSIS
    | KEY_NONE 
    | KEY_TRUE 
    | KEY_FALSE
    
number: INTEGER
      | FLOAT_NUMBER
      | IMAGINARY_NUMBER
      
testlist_comp: named_or_star comp_for
             | named_star_plus

named_or_star: namedexpr_test
             | star_expr

named_star_plus: named_or_star
               | named_or_star DELIM_COMMA
               | named_or_star DELIM_COMMA named_star_plus

trailer: DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN
       | DELIM_LEFT_PAREN  DELIM_RIGHT_PAREN
       | DELIM_LEFT_BRACKET subscriptlist DELIM_RIGHT_BRACKET
       | DELIM_DOT NAME

trailer_plus: trailer_plus trailer
            | trailer

subscriptlist: subscript
             | subscript DELIM_COMMA subscriptlist
             | subscript DELIM_COMMA

subscript: test
         | DELIM_COLON
         | DELIM_COLON sliceop
         | DELIM_COLON test
         | DELIM_COLON test sliceop
         | test DELIM_COLON
         | test DELIM_COLON sliceop
         | test DELIM_COLON test
         | test DELIM_COLON test sliceop

sliceop: DELIM_COLON
       | DELIM_COLON test

common_expr : expr
            | star_expr

exprlist: common_expr 
        | common_expr DELIM_COMMA exprlist
        | common_expr DELIM_COMMA

testlist: test 
        | test DELIM_COMMA testlist
        | test DELIM_COMMA

/* dictorsetmaker: test DELIM_COLON test comp_for
              | test DELIM_COLON test test_test_plus
              | test DELIM_COLON test test_test_plus DELIM_COMMA
              | test_or_star comp_for
              | test_or_star_plus
              | test_or_star comp_for
              | test_or_star_plus DELIM_COMMA */

test_test_plus: test DELIM_COLON test
              | test DELIM_COLON test DELIM_COMMA test_test_plus

classdef: KEY_CLASS NAME DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN DELIM_COLON suite
        | KEY_CLASS NAME DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_COLON suite
        | KEY_CLASS NAME DELIM_COLON suite

arglist: argument 
       | argument DELIM_COMMA arglist
       | argument DELIM_COMMA

argument: test comp_for 
        | test  
        | test OP_ASSIGN test 
        | test DELIM_ASSIGN test 
        | OP_POWER test
        | OP_MULTIPLY test 

comp_iter: comp_for 
         | comp_if
        
sync_comp_for: KEY_FOR exprlist KEY_IN or_test comp_iter
             | KEY_FOR exprlist KEY_IN or_test

comp_for: sync_comp_for

comp_if: KEY_IF test_nocond comp_iter
       | KEY_IF test_nocond

// not used in grammar, but may appear in "node" passed from Parser to Compiler
encoding_decl: NAME

func_body_suite: simple_stmt 
               |  NEWLINE INDENT stmt_plus DEDENT

/* func_type_input: func_type ENDMARKER
               | func_type newline_plus ENDMARKER

func_type: DELIM_LEFT_PAREN typelist DELIM_RIGHT_PAREN DELIM_ARROW test
         |  DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_ARROW test

//  typelist is a modified typedargslist (see above)

typelist: test (',' test)* [',' ['*' [test] (',' test)* [',' '**' test] | '**' test]]
        | '*' [test] (',' test)* [',' '**' test]
        | OP_POWER test */

%%


int main() {
    yyparse();
    return 0;
}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}
