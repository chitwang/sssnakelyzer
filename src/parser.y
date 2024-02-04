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

%type start_symbol file interactive eval statements statement_newline newline_star expressions compound_stmt simple_stmts expression assignment return_stmt raise_stmt del_stmt assert_stmt global_stmt nonlocal_stmt function_def if_stmt class_def for_stmt while_stmt annotated_rhs single_target single_subscript_attribute_target multiple_star_targets augassign star_targets comma_separated_name del_targets dotted_as_name dotted_name dotted_as_names function_def_raw class_def_raw params parameters star_etc class_arguments arguments param_with_default_plus param_no_default_plus block param default named_expression elif_stmt else_block strings disjunction conjunction inversion comparison compare_op_bitwise_or_pair compare_op_bitwise_or_pair_plus bitwise_or eq_bitwise_or gt_bitwise_or in_bitwise_or is_bitwise_or lt_bitwise_or gte_bitwise_or lte_bitwise_or isnot_bitwise_or noteq_bitwise_or notin_bitwise_or bitwise_xor bitwise_and shift_expr sum term factor power primary slices atom slice list 

%start start_symbol

%%

start_symbol: file
    | interactive
    | eval
    /* |func_type */

newline_star: NEWLINE
    | NEWLINE newline_star

file: ENDMARKER
    |statements ENDMARKER

eval: expressions ENDMARKER
    | expressions newline_star ENDMARKER

interactive: statement_newline

/* func_type: DELIM_LEFT_PAREN type_expressions DELIM_RIGHT_PAREN DELIM_ARROW expression newline_star ENDMARKER
    | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_ARROW newline_star ENDMARKER */

statements: statement
    |statement statements

statement: compound_stmt  
    |simple_stmts 
    
statement_newline: compound_stmt NEWLINE 
    | simple_stmts
    | NEWLINE 
    | ENDMARKER     

simple_stmts: simple_stmt NEWLINE
    | simple_stmt DELIM_SEMICOLON NEWLINE
    | simple_stmt DELIM_SEMICOLON simple_stmts

    
simple_stmt: assignment
    /* | type_alias */
    | expressions 
    | return_stmt
    | raise_stmt
    | KEY_PASS 
    /* | del_stmt */
    | assert_stmt
    | KEY_BREAK 
    | KEY_CONTINUE 
    | global_stmt
    | nonlocal_stmt

compound_stmt: function_def
    | if_stmt
    | class_def
    /* | with_stmt */
    | for_stmt
    /* | try_stmt */
    | while_stmt
    
assignment: NAME DELIM_COLON expression
    | NAME DELIM_COLON expression DELIM_ASSIGN annotated_rhs 
    /* | DELIM_LEFT_BRACKET single_target DELIM_RIGHT_PAREN DELIM_COLON expression
    | DELIM_LEFT_BRACKET single_target DELIM_RIGHT_PAREN DELIM_COLON expression DELIM_ASSIGN annotated_rhs
    | single_subscript_attribute_target DELIM_COLON expression
    | single_subscript_attribute_target DELIM_COLON expression DELIM_ASSIGN annotated_rhs */
    /* | multiple_star_targets star_expressions !'=' [TYPE_COMMENT] 
    | single_target augassign ~ star_expressions  */

annotated_rhs: expressions 

multiple_star_targets: star_targets DELIM_ASSIGN
    | star_targets DELIM_ASSIGN multiple_star_targets

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

return_stmt: KEY_RETURN
    | KEY_RETURN expressions  

raise_stmt: KEY_RAISE
    | KEY_RAISE expression KEY_FROM expression
    | KEY_RAISE expression
       
global_stmt: KEY_GLOBAL comma_separated_name

nonlocal_stmt: KEY_NONLOCAL comma_separated_name

comma_separated_name: NAME
    | NAME DELIM_COMMA comma_separated_name

/* del_stmt: KEY_DEL del_targets &(';' | NEWLINE)  */

assert_stmt: KEY_ASSERT expression
    | KEY_ASSERT expression DELIM_COMMA expression

dotted_as_names: dotted_as_name
    | dotted_as_name DELIM_COMMA dotted_as_names

dotted_as_name: dotted_name 
    | dotted_name KEY_AS NAME

dotted_name: dotted_name DELIM_DOT NAME 
    | NAME

block: NEWLINE INDENT statements DEDENT 
    | simple_stmts

class_def: class_def_raw

class_arguments: DELIM_LEFT_PAREN DELIM_RIGHT_PAREN
            | DELIM_LEFT_PAREN arguments DELIM_RIGHT_PAREN
            
/* class_def_raw: KEY_CLASS NAME [type_params] [DELIM_LEFT_PAREN [arguments] DELIM_RIGHT_PAREN ] DELIM_COLON block  */

class_def_raw: KEY_CLASS NAME DELIM_COLON block
            | KEY_CLASS NAME class_arguments DELIM_COLON block

function_def: function_def_raw

/* function_def_raw: KEY_DEF NAME [type_params] '(' [params] ')' ['->' expression ] ':' [func_type_comment] block 
    | ASYNC KEY_DEF NAME [type_params] '(' [params] ')' ['->' expression ] ':' [func_type_comment] block  */

function_def_raw: KEY_DEF NAME DELIM_LEFT_PAREN params DELIM_RIGHT_PAREN DELIM_COLON block
    | KEY_DEF NAME DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_COLON block
    | KEY_DEF NAME DELIM_LEFT_PAREN params DELIM_RIGHT_PAREN DELIM_ARROW DELIM_COLON block
    | KEY_DEF NAME DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_ARROW DELIM_COLON block   
    
params: parameters

/* parameters: slash_no_default param_no_default* param_with_default* [star_etc] 
    | slash_with_default param_with_default* [star_etc] 
    | param_no_default+ param_with_default* [star_etc] 
    | param_with_default+ [star_etc] 
    | star_etc  */

parameters: param_no_default_plus DELIM_COMMA param_with_default_plus
    | param_with_default_plus
    | param_no_default_plus
    | param_no_default_plus DELIM_COMMA
    | param_with_default_plus DELIM_COMMA
    
/* param_no_default_plus: param_no_default
    |param_no_default param_no_default_plus

param_with_default_plus: param_with_default
    |param_with_default param_with_default_plus */
    
param_no_default_plus : param
    | param DELIM_COMMA param_no_default_plus    

param_with_default_plus: param default 
    | param default DELIM_COMMA param_with_default_plus
    
param: NAME
    | NAME annotation

annotation: DELIM_COLON expression

default: DELIM_ASSIGN expression

if_stmt: KEY_IF named_expression DELIM_COLON block elif_stmt 
    | KEY_IF named_expression DELIM_COLON block 
    | KEY_IF named_expression DELIM_COLON block else_block

elif_stmt: KEY_ELIF named_expression DELIM_COLON block elif_stmt 
    | KEY_ELIF named_expression DELIM_COLON block 
    | KEY_ELIF named_expression DELIM_COLON block else_block 

else_block: KEY_ELSE DELIM_COLON block 

while_stmt: KEY_WHILE named_expression DELIM_COLON block 
    | KEY_WHILE named_expression DELIM_COLON block else_block

for_stmt: KEY_FOR star_targets KEY_IN expressions DELIM_COLON block
    | KEY_FOR star_targets KEY_IN expressions DELIM_COLON block else_block

expressions: expression DELIM_COMMA expressions
    | expression 
    | expression DELIM_COMMA

expression: disjunction KEY_IF disjunction KEY_ELSE expression 
    | disjunction
    
star_named_expressions: star_named_expression
    | star_named_expression DELIM_COMMA
    | star_named_expression DELIM_COMMA star_named_expressions

star_named_expression: named_expression

/* assignment_expression: NAME ':=' ~ expression  */

/* named_expression: assignment_expression
    | expression !':=' */

disjunction: conjunction KEY_OR disjunction
    | conjunction

conjunction: inversion KEY_AND conjunction 
    | inversion

inversion: KEY_NOT inversion 
    | comparison

comparison: bitwise_or compare_op_bitwise_or_pair_plus 
    | bitwise_or

compare_op_bitwise_or_pair_plus : compare_op_bitwise_or_pair compare_op_bitwise_or_pair_plus

compare_op_bitwise_or_pair: eq_bitwise_or
    | noteq_bitwise_or
    | lte_bitwise_or
    | lt_bitwise_or
    | gte_bitwise_or
    | gt_bitwise_or
    | notin_bitwise_or
    | in_bitwise_or
    | isnot_bitwise_or
    | is_bitwise_or

eq_bitwise_or: OP_EQUAL bitwise_or
 
noteq_bitwise_or: OP_NOT_EQUAL bitwise_or 
lte_bitwise_or: OP_LESS_THAN_EQUAL bitwise_or 
lt_bitwise_or: OP_LESS_THAN bitwise_or 
gte_bitwise_or: OP_GREATER_THAN_EQUAL bitwise_or 
gt_bitwise_or: OP_GREATER_THAN bitwise_or 
notin_bitwise_or: KEY_NOT KEY_IN bitwise_or 
in_bitwise_or: KEY_IN bitwise_or 
isnot_bitwise_or: KEY_IS KEY_NOT bitwise_or 
is_bitwise_or: KEY_IS bitwise_or 

bitwise_or: bitwise_or OP_BITWISE_OR bitwise_xor 
    | bitwise_xor

bitwise_xor: bitwise_xor OP_BITWISE_XOR bitwise_and 
    | bitwise_and

bitwise_and: bitwise_and OP_BITWISE_AND shift_expr 
    | shift_expr

shift_expr: shift_expr OP_LEFT_SHIFT sum 
    | shift_expr OP_RIGHT_SHIFT sum 
    | sum

sum: sum OP_ADD term 
    | sum OP_SUBTRACT term 
    | term

term: term OP_MULTIPLY factor 
    | term OP_DIVIDE factor 
    | term OP_FLOOR_DIVIDE factor 
    | term OP_MODULO factor 
    | term OP_AT factor 
    | factor

factor: OP_ADD factor 
    | OP_SUBTRACT factor 
    | OP_BITWISE_NOT factor 
    | power

power: primary OP_POWER factor 
    | primary

primary: primary DELIM_DOT NAME 
    | primary DELIM_LEFT_PAREN DELIM_RIGHT_PAREN 
    | primary DELIM_LEFT_PAREN arguments DELIM_RIGHT_PAREN 
    | primary DELIM_LEFT_BRACKET slices DELIM_RIGHT_BRACKET
    | atom

slices: slice
    | expression
    | slice DELIM_COMMA
    | expression DELIM_COMMA
    | slice DELIM_COMMA slices
    | expression DELIM_COMMA slices
    /* slice !','  */    

slice: DELIM_COLON
    | expression DELIM_COLON
    | DELIM_COLON expression
    | expression DELIM_COLON expression
    | DELIM_COLON DELIM_COLON
    | expression DELIM_COLON DELIM_COLON
    | DELIM_COLON expression DELIM_COLON
    | expression DELIM_COLON expression DELIM_COLON
    | DELIM_COLON DELIM_COLON expression
    | expression DELIM_COLON DELIM_COLON expression
    | DELIM_COLON expression DELIM_COLON expression
    | expression DELIM_COLON expression DELIM_COLON expression
    | named_expression 

atom: NAME
    | KEY_TRUE 
    | KEY_FALSE 
    | KEY_NONE 
    | strings
    | FLOAT_NUMBER
    | IMAGINARY_NUMBER
    | INTEGER
    | list
    | DELIM_ELLIPSIS

string: STRING_LITERAL 
strings: string strings 

list: DELIM_LEFT_BRACKET star_named_expressions DELIM_RIGHT_BRACKET
    | DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET

star_targets: KEY_AWAIT

named_expression: KEY_ASYNC

arguments: KEY_TRY

/* arguments: args &')'
    | args DELIM_COMMA &')' 

args: ','.(starred_expression | ( assignment_expression | expression !':=') !'=')+ */

%%


int main() {
    yyparse();
}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}
