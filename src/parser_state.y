%{
#include<bits/stdc++.h>
using namespace std;
#define YYDEBUG 1

extern int yylineno;

vector<string> nodes;
vector<vector<int>> adj;
int node_count = 0;
vector<string> node_attr;
vector<int> node_numbers;

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

void debug_insert() {
    for(auto s: node_attr) cout << s << "\t";
    cout << endl;
    cout << "NODE COUNT " << node_count << endl;
    cout << "NODE_ATTR SIZE " << node_attr.size() << endl;
    cout << "ADJ SIZE " << adj.size() << endl;
}

void insert_node() {
    for(int i = 0; i < node_attr.size(); i++) {
        nodes.push_back(node_attr[i]);
        adj.push_back(vector<int>());
    }
    // debug_insert();
    for(int i = 0; i < node_numbers.size(); i++) {
        adj[node_count + node_attr.size() - 1].push_back(node_numbers[i]);
    }
}

bool isop(string s)
{
    return s == "+" || s == "-" || s == "*" || s == "**" || s == "/" ||
           s == "//" || s == "%" || s == "@" || s == "<<" || s == ">>" ||
           s == "&" || s == "|" || s == "^" || s == "~" || s == ":=" ||
           s == "<" || s == ">" || s == "<=" || s == ">=" || s == "==" || 
           s == "!=";
}

extern int yylex(void);
void yyerror(const char*);

ast_node* root;

%}

%define parse.error verbose

%union {
    char* strval;
    int intval;
}

%token<strval> KEY_FALSE KEY_ELSE KEY_PASS KEY_NONE KEY_BREAK KEY_EXCEPT KEY_IN KEY_RAISE KEY_TRUE KEY_CLASS KEY_FINALLY KEY_IS KEY_RETURN KEY_AND KEY_CONTINUE KEY_FOR KEY_LAMBDA KEY_TRY KEY_AS KEY_DEF KEY_FROM KEY_NONLOCAL KEY_WHILE KEY_ASSERT KEY_DEL KEY_GLOBAL KEY_NOT KEY_WITH  KEY_ELIF KEY_IF KEY_OR KEY_YIELD OP_ADD OP_SUBTRACT OP_MULTIPLY OP_POWER OP_DIVIDE OP_FLOOR_DIVIDE OP_MODULO OP_AT OP_LEFT_SHIFT OP_RIGHT_SHIFT OP_BITWISE_AND OP_BITWISE_OR OP_BITWISE_XOR OP_BITWISE_NOT OP_ASSIGN OP_LESS_THAN OP_GREATER_THAN OP_LESS_THAN_EQUAL OP_GREATER_THAN_EQUAL OP_EQUAL OP_NOT_EQUAL DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET DELIM_LEFT_CURLY DELIM_RIGHT_CURLY DELIM_COMMA DELIM_COLON DELIM_DOT DELIM_SEMICOLON DELIM_ASSIGN DELIM_ARROW DELIM_ASSIGN_ADD DELIM_ASSIGN_SUBTRACT DELIM_ASSIGN_MULTIPLY DELIM_ASSIGN_DIVIDE DELIM_ASSIGN_FLOOR_DIVIDE DELIM_ASSIGN_MODULO DELIM_ASSIGN_BITWISE_AND DELIM_ASSIGN_BITWISE_OR DELIM_ASSIGN_BITWISE_XOR DELIM_ASSIGN_RIGHT_SHIFT DELIM_ASSIGN_LEFT_SHIFT DELIM_ASSIGN_POWER DELIM_ELLIPSIS NAME INDENT DEDENT NEWLINE FLOAT_NUMBER IMAGINARY_NUMBER INTEGER STRING_LITERAL DUNDER_INIT DUNDER_NAME DUNDER_MAIN ENDMARKER TYPE_INT TYPE_FLOAT TYPE_STRING TYPE_BOOL TYPE_LIST TYPE_DICT WILDCARD_UNDERSCORE KEY_ASYNC KEY_AWAIT KEY_IMPORT

%type<intval> start_symbol simple_stmt compound_stmt stmt parameters func_body_suite test typedarglist tfpdef testlist small_stmt expr_stmt pass_stmt flow_stmt global_stmt nonlocal_stmt assert_stmt small_or_semi argument_s star_expr test_or_star test_or_star_plus break_stmt continue_stmt exprlist return_stmt names classdef if_stmt while_stmt funcdef for_stmt namedexpr_test elif_plus or_test suite stmt_plus and_test not_test comparison expr comp_op xor_expr and_expr shift_expr arith_expr term factor power atom_expr atom trailer_plus trailer argument named_or_star named_star_plus number testlist_comp comp_for arglist subscriptlist sliceop test_test_plus common_expr comp_iter sync_comp_for comp_if dictorsetmaker types testlist_star_assign_plus newline_plus file_input file_plus dunder_stmt_main try_stmt except_plus string_plus annassign testlist_star_expr augassign test_nocond subscript type_list

%start start_symbol

%left DELIM_COMMA

%%

start_symbol: file_input {node_attr = {"start_symbol"};  node_numbers = {$1};insert_node();$$ = node_count; node_count += 1;}

file_input: file_plus {node_attr = {"file_input"};  node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;} 
          | newline_plus file_plus {node_attr = {"file_input"}; node_numbers = {$2}; insert_node();  $$ = node_count; node_count += 1;} 

file_plus: stmt file_plus {node_attr = {"file_plus"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1;} 
         | stmt {node_attr = {"file_plus"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;} 

newline_plus: newline_plus NEWLINE {}
            | NEWLINE {}

funcdef: KEY_DEF NAME parameters DELIM_ARROW test DELIM_COLON func_body_suite {node_attr = {"def", string("NAME ( ") + strdup($2) + " )", "->", ":", "funcdef"}; node_numbers = {node_count, node_count+1, $3, node_count+2, $5, node_count+3, $7}; insert_node(); $$ = node_count+4; node_count += 5;} 
       | KEY_DEF NAME parameters DELIM_COLON func_body_suite {node_attr = {"def", string("NAME ( ") + strdup($2) + " )", ":", "funcdef"}; node_numbers = {node_count, node_count+1, $3, node_count+2, $5}; insert_node(); $$ = node_count+3; node_count += 4;} 

parameters: DELIM_LEFT_PAREN typedarglist DELIM_RIGHT_PAREN {node_attr = {"(", ")", "parameters"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2, node_count += 3;}
          | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")","parameters"}; node_numbers = {node_count+0,node_count+1}; insert_node(); $$ = node_count+2; node_count += 3;}

argument_s : tfpdef DELIM_ASSIGN test {node_attr = {"=", "argument_s"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
           | tfpdef {node_attr = {"argument_s"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

typedarglist : argument_s DELIM_COMMA { node_attr = {",", "typedarglist"}, node_numbers = {$1, node_count}; insert_node();$$ = node_count + 1; node_count += 2;}
             | argument_s {node_attr = {"typedarglist"}; node_numbers = {$1}; insert_node(); $$ = node_count;  node_count += 1;}
             | argument_s DELIM_COMMA typedarglist {node_attr = {",", "typedarglist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

tfpdef: NAME DELIM_COLON test {node_attr = {string("NAME ( ") + strdup($1) + " )", ":", "tpdef"}; node_numbers = {node_count, node_count + 1, $3}; insert_node(); $$ = node_count + 2; node_count += 3;}
      | NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "tpdef"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

stmt: simple_stmt {node_attr = {"stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | compound_stmt {node_attr = {"stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

simple_stmt: small_or_semi newline_plus { node_attr = {"simple_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

small_or_semi: small_stmt {node_attr = {"small_or_semi"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1; }
             | small_stmt DELIM_SEMICOLON {node_attr = {";", "small_or_semi"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
             | small_stmt DELIM_SEMICOLON small_or_semi {node_attr = {";", "small_or_semi"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

small_stmt: expr_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | pass_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | flow_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | global_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | nonlocal_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | assert_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        
expr_stmt: testlist_star_expr annassign {node_attr = {"expr_stmt"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1;}
         | testlist_star_expr augassign testlist {node_attr = {"expr_stmt"}; node_numbers = {$1, $2, $3}; insert_node(); $$ = node_count; node_count += 1;}
         | testlist_star_expr {node_attr = {"expr_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | testlist_star_expr testlist_star_assign_plus {node_attr = {"expr_stmt"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1;}

testlist_star_assign_plus: DELIM_ASSIGN testlist_star_expr {node_attr = {"=", "testlist_star_assign_plus"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count+1; node_count += 2;}
                         | DELIM_ASSIGN testlist_star_expr testlist_star_assign_plus {node_attr = {"=", "testlist_star_assign_plus"}; node_numbers = {node_count, $2, $3}; insert_node(); $$ = node_count+1; node_count += 2;}

annassign: DELIM_COLON test {node_attr = {":", "annassign"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_COLON test DELIM_ASSIGN {node_attr = {":", "=", "annassign"}; node_numbers = {node_count, $2, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}
         | DELIM_COLON test DELIM_ASSIGN testlist_star_expr {node_attr = {":", "=", "annassign"}; node_numbers = {node_count, $2, node_count + 1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}

testlist_star_expr: test_or_star test_or_star_plus {node_attr = {"testlist_star_expr"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count + 0; node_count += 1;}
                  | test_or_star test_or_star_plus DELIM_COMMA { node_attr = {",", "testlist_star_expr"}; node_numbers = {$1, $2, node_count + 0}; insert_node(); $$ = node_count + 1; node_count += 2;}
                  | test_or_star {node_attr = {"testlist_star_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count + 0; node_count += 1;}
                  | test_or_star DELIM_COMMA {node_attr = {",", "testlist_star_expr"}; node_numbers = {$1, node_count + 0}; insert_node(); $$ = node_count + 1; node_count += 2;}

test_or_star: test {node_attr = {"test_or_star"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
            | star_expr {node_attr = {"test_or_star"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
            
test_or_star_plus:  DELIM_COMMA test_or_star {node_attr = {",", "test_or_star_plus"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
                 |  DELIM_COMMA test_or_star  test_or_star_plus {node_attr = {",", "test_or_star_plus"}; node_numbers = {node_count, $2, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

augassign: DELIM_ASSIGN_ADD {node_attr = {"+=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_SUBTRACT {node_attr = {"-=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_MULTIPLY { node_attr = {"*=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_DIVIDE {node_attr = {"/=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_MODULO {node_attr = {"%=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_BITWISE_AND {node_attr = {"&=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_BITWISE_OR {node_attr = {"|=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_BITWISE_XOR {node_attr = {"^=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_LEFT_SHIFT {node_attr = {"<<=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_RIGHT_SHIFT {node_attr = {">>=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_POWER {node_attr = {"**=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_FLOOR_DIVIDE {node_attr = {"//=", "augassign"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

pass_stmt: KEY_PASS {node_attr = {"pass", "pass_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

flow_stmt: break_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | continue_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | return_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

break_stmt: KEY_BREAK {node_attr = {"break", "break_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

continue_stmt: KEY_CONTINUE {node_attr = {"continue", "continue_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

return_stmt: KEY_RETURN testlist_star_expr {node_attr = {"return", "return_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
           | KEY_RETURN {node_attr = {"return", "return_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

global_stmt: KEY_GLOBAL names {node_attr = {"global", "global_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
 
names: NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "names"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | NAME DELIM_COMMA names {node_attr = {"NAME", ",", "names"}; node_numbers = {node_count+0,node_count + 1, $3}; insert_node(); $$ = node_count + 2; node_count += 3;}

nonlocal_stmt: KEY_NONLOCAL names {node_attr = {"nonlocal", "nonlocal_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}

assert_stmt: KEY_ASSERT test DELIM_COMMA test {node_attr = {"assert", ",", "assert_stmt"}; node_numbers = {node_count+0, $2,node_count + 1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}
           | KEY_ASSERT test {node_attr = {"assert", "assert_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}

compound_stmt: if_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | while_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | for_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | funcdef {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | classdef {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | dunder_stmt_main {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | try_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
 
dunder_stmt_main: KEY_IF DUNDER_NAME OP_EQUAL DUNDER_MAIN DELIM_COLON suite { node_attr = {"if", "__name__", "==", "__main__", ":", "dunder_stmt_main"}; node_numbers = {node_count, node_count+1, node_count+2, node_count+3, node_count+4, $6}; insert_node(); $$ = node_count+5; node_count += 6;}
    

if_stmt: KEY_IF namedexpr_test DELIM_COLON suite {node_attr = {"if",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | KEY_IF namedexpr_test DELIM_COLON suite elif_plus {node_attr = {"if",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, $5}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | KEY_IF namedexpr_test DELIM_COLON suite KEY_ELSE DELIM_COLON suite {node_attr = {"if",":","else",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, node_count+2,node_count + 3, $7}; insert_node(); $$ = node_count + 4; node_count += 5;}
       | KEY_IF namedexpr_test DELIM_COLON suite elif_plus KEY_ELSE DELIM_COLON suite {node_attr = {"if",":","else",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, $5, node_count+2, node_count + 3, $8}; insert_node(); $$ = node_count + 4; node_count += 5;}

elif_plus: KEY_ELIF namedexpr_test DELIM_COLON suite {node_attr = {"elif",":","elif_plus"}; node_numbers = {node_count, $2, node_count+1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}
         | KEY_ELIF namedexpr_test DELIM_COLON suite elif_plus {node_attr = {"elif",":","elif_plus"}; node_numbers = {node_count, $2, node_count+1, $4, $5}; insert_node(); $$ = node_count + 2; node_count += 3;}

while_stmt: KEY_WHILE namedexpr_test DELIM_COLON suite KEY_ELSE DELIM_COLON suite {node_attr = {"while",":","else",":","while_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, node_count+2, node_count+3, $7}; insert_node(); $$ = node_count + 4; node_count += 5;}
          |  KEY_WHILE namedexpr_test DELIM_COLON suite {node_attr = {"while",":","while_stmt"}; node_numbers = {node_count, $2, node_count+1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}

for_stmt: KEY_FOR exprlist KEY_IN testlist DELIM_COLON suite KEY_ELSE DELIM_COLON suite {node_attr = {"for","in", ":","else",":","for_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, node_count+2, $6, node_count+3, node_count+4, $9}; insert_node(); $$ = node_count + 5; node_count += 6;}
        | KEY_FOR exprlist KEY_IN testlist DELIM_COLON suite {
            node_attr = {"for","in", ":","for_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, node_count+2, $6}; insert_node(); $$ = node_count + 3; node_count += 4;
        }

try_stmt: KEY_TRY DELIM_COLON suite except_plus {node_attr = {"try",":","try_stmt"}; node_numbers = {node_count, node_count+1, $3, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}
        | KEY_TRY DELIM_COLON suite except_plus KEY_ELSE DELIM_COLON suite {node_attr = {"try",":","else",":","try_stmt"}; node_numbers = {node_count, node_count+1, $3, $4, node_count+2, node_count+3, $7}; insert_node(); $$ = node_count + 4; node_count += 5;}
        | KEY_TRY DELIM_COLON suite except_plus KEY_FINALLY DELIM_COLON suite {node_attr = {"try",":","finally",":","try_stmt"}; node_numbers = {node_count, node_count+1, $3, $4, node_count+2, node_count+3, $7}; insert_node(); $$ = node_count + 4; node_count += 5;}
        | KEY_TRY DELIM_COLON suite except_plus KEY_ELSE DELIM_COLON suite KEY_FINALLY DELIM_COLON suite { node_attr = {"try",":","else",":","finally",":","try_stmt"}; node_numbers = {node_count, node_count+1, $3, $4, node_count+2, node_count+3, $7, node_count+4, node_count+5, $10}; insert_node(); $$ = node_count + 6; node_count += 7;}
        | KEY_TRY DELIM_COLON suite KEY_FINALLY DELIM_COLON suite {node_attr = {"try",":","finally",":","try_stmt"}; node_numbers = {node_count, node_count+1, $3, node_count+2, node_count+3, $6}; insert_node(); $$ = node_count + 4; node_count += 5;}

except_plus: KEY_EXCEPT DELIM_COLON suite {node_attr = {"except",":","except_plus"}; node_numbers = {node_count, node_count + 1, $3}; insert_node(); $$ = node_count + 2; node_count += 3;}
           | KEY_EXCEPT DELIM_COLON suite except_plus {node_attr = {"except",":","except_plus"}; node_numbers = {node_count, node_count + 1, $3, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}

stmt_plus : stmt {node_attr = {"stmt_plus"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | stmt stmt_plus {node_attr = {"stmt_plus"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1;}
        
suite: simple_stmt {node_attr = {"suite"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
     | newline_plus INDENT stmt_plus DEDENT {node_attr = {"suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}
     | newline_plus INDENT stmt_plus DEDENT newline_plus{node_attr = {"suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}

namedexpr_test: test {node_attr = {"namedexpr_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
              | test DELIM_ASSIGN test {node_attr = {"=", "namedexpr_test"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    
test: or_test {node_attr = {"test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | or_test KEY_IF or_test KEY_ELSE test {node_attr = {"if", "else", "test"}; node_numbers = {$1, node_count, $3, node_count + 1, $5}; insert_node(); $$ = node_count + 2; node_count += 3;}

test_nocond: or_test {node_attr = {"test_nocond"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

or_test: and_test {node_attr = {"or_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
       | and_test KEY_OR or_test {node_attr = {"or", "or_test"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

and_test: not_test {node_attr = {"and_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | not_test KEY_AND and_test {node_attr = {"and", "and_test"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

not_test: KEY_NOT not_test {node_attr = {"not", "not_test"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | comparison {node_attr = {"not_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        
comparison: expr {node_attr = {"comparison"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | expr comp_op comparison {node_attr = {"comparison"}; node_numbers = {$1, $2, $3}; insert_node(); $$ = node_count + 0; node_count += 1;}

comp_op: OP_LESS_THAN {node_attr = {"<", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_GREATER_THAN {node_attr = {">", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_EQUAL {node_attr = {"==", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_GREATER_THAN_EQUAL {node_attr = {">=", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_LESS_THAN_EQUAL {node_attr = {"<=", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_NOT_EQUAL {node_attr = {"!=", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | KEY_IN {node_attr = {"in", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | KEY_NOT KEY_IN {node_attr = {"not", "in", "comp_op"}; node_numbers = {node_count, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | KEY_IS {node_attr = {"is", "comp_op"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | KEY_IS KEY_NOT {node_attr = {"is", "not", "comp_op"}; node_numbers = {node_count, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}

star_expr: OP_MULTIPLY expr {node_attr = {"*", "star_expr"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}

expr: xor_expr {node_attr = {"expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | expr OP_BITWISE_OR xor_expr {node_attr = {"|", "expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

xor_expr: and_expr {node_attr = {"xor_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | xor_expr OP_BITWISE_XOR and_expr {node_attr = {"^", "xor_expr"}; node_numbers = {$1, node_count + 0, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

and_expr: shift_expr {node_attr = {"and_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | and_expr OP_BITWISE_AND shift_expr {node_attr = {"&", "and_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        
shift_expr: arith_expr {node_attr = {"shift_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | shift_expr OP_LEFT_SHIFT arith_expr {node_attr = {"<<", "shift_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
          | shift_expr OP_RIGHT_SHIFT arith_expr {node_attr = {">>", "shift_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

arith_expr: term {node_attr = {"arith_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | arith_expr OP_ADD term {node_attr = {"+", "arith_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
          | arith_expr OP_SUBTRACT term {node_attr = {"-", "arith_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

term: factor {node_attr = {"term"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | term OP_MULTIPLY factor {node_attr = {"*", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | term OP_AT factor {node_attr = {"@", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | term OP_DIVIDE factor {node_attr = {"/", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | term OP_MODULO factor {node_attr = {"%", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | term OP_FLOOR_DIVIDE factor {node_attr = {"//", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

factor: OP_BITWISE_NOT factor {node_attr = {"~", "factor"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | OP_ADD factor {node_attr = {"+", "factor"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | OP_SUBTRACT factor {node_attr = {"-", "factor"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | power {node_attr = {"factor"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

power: atom_expr {node_attr = {"power"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
     | atom_expr OP_POWER factor {node_attr = {"**", "power"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    
atom_expr: atom {node_attr = {"atom_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | atom trailer_plus {node_attr = {"atom_expr"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1;}
 
string_plus : string_plus STRING_LITERAL {node_attr = {"STRING_LITERAL", "string_plus"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
            | STRING_LITERAL {node_attr = {"STRING_LITERAL", "string_plus"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

atom: DELIM_LEFT_PAREN testlist_comp DELIM_RIGHT_PAREN {node_attr = {"(", ")", "atom"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")", "atom"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_BRACKET testlist_comp DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "atom"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "atom"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_CURLY dictorsetmaker DELIM_RIGHT_CURLY {node_attr = {"{", "}", "atom"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_CURLY DELIM_RIGHT_CURLY {node_attr = {"{", "}", "atom"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | number {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | string_plus {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | DELIM_ELLIPSIS {node_attr = {"...", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | KEY_NONE {node_attr = {"None", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | KEY_TRUE {node_attr = {"True", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | KEY_FALSE {node_attr = {"False", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | types {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    
number: INTEGER {node_attr = {strdup($1), "number"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | FLOAT_NUMBER {node_attr = {strdup($1), "number"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | IMAGINARY_NUMBER {node_attr = {strdup($1), "number"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
      
testlist_comp: named_or_star comp_for {node_attr = {"testlist_comp"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count + 0; node_count += 1;}
             | named_star_plus {node_attr = {"testlist_comp"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

named_or_star: namedexpr_test {node_attr = {"named_or_star"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | star_expr {node_attr = {"named_or_star"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

named_star_plus: named_or_star {node_attr = {"named_star_plus"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
               | named_or_star DELIM_COMMA {node_attr = {",", "named_star_plus"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
               | named_or_star DELIM_COMMA named_star_plus {node_attr = {",", "named_star_plus"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

trailer: DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailer"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailer"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | DELIM_LEFT_BRACKET subscriptlist DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "trailer"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | DELIM_DOT NAME {node_attr = {".", string("NAME ( ") + strdup($2) + " )", "trailer"}; node_numbers = {node_count, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}

trailer_plus: trailer_plus trailer {node_attr = {"trailer_plus"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count + 0; node_count += 1;}
            | trailer {node_attr = {"trailer_plus"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

subscriptlist: subscript {node_attr = {"subscriptlist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | subscript DELIM_COMMA subscriptlist {node_attr = {",", "subscriptlist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
             | subscript DELIM_COMMA {node_attr = {",", "subscriptlist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

subscript: test {node_attr = {"subscript"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | DELIM_COLON {node_attr = {":", "subscript"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_COLON sliceop {node_attr = {":", "subscript"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_COLON test {node_attr = {":", "subscript"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_COLON test sliceop {node_attr = {":", "subscript"}; node_numbers = {node_count, $2, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | test DELIM_COLON {node_attr = {":", "subscript"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | test DELIM_COLON sliceop {node_attr = {":", "subscript"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | test DELIM_COLON test {node_attr = {":", "subscript"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | test DELIM_COLON test sliceop {node_attr = {":", "subscript"}; node_numbers = {$1, node_count, $3, $4}; insert_node(); $$ = node_count + 1; node_count += 2;}

sliceop: DELIM_COLON {node_attr = {":", "sliceop"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | DELIM_COLON test {node_attr = {":", "sliceop"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}

common_expr : expr {node_attr = {"common_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
            | star_expr {node_attr = {"common_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

exprlist: common_expr {node_attr = {"exprlist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | common_expr DELIM_COMMA exprlist {node_attr = {",", "exprlist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | common_expr DELIM_COMMA {node_attr = {",", "exprlist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

testlist: test {node_attr = {"testlist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | test DELIM_COMMA testlist {node_attr = {",", "testlist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | test DELIM_COMMA {node_attr = {",", "testlist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

dictorsetmaker: test DELIM_COLON test comp_for {node_attr = {":", "dictorsetmaker"}; node_numbers = {$1, node_count, $3, $4}; insert_node(); $$ = node_count + 1; node_count += 2;}
              | test_test_plus {node_attr = {"dictorsetmaker"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
              | test_or_star comp_for {node_attr = {"dictorsetmaker"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count + 0; node_count += 1;}
              | test_or_star test_or_star_plus {node_attr = {"dictorsetmaker"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count + 0; node_count += 1;}
              | test_or_star test_or_star_plus DELIM_COMMA {node_attr = {",", "dictorsetmaker"}; node_numbers = {$1, $2, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

test_test_plus: test DELIM_COLON test {node_attr = {":", "test_test_plus"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
              | test DELIM_COLON test DELIM_COMMA {node_attr = {":", ",", "test_test_plus"}; node_numbers = {$1, node_count, $3, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}
              | test DELIM_COLON test DELIM_COMMA test_test_plus {node_attr = {":", ",", "test_test_plus"}; node_numbers = {$1, node_count, $3, node_count + 1, $5}; insert_node(); $$ = node_count + 2; node_count += 3;}

classdef: KEY_CLASS NAME DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN DELIM_COLON suite {node_attr = {"class", string("NAME ( ") + strdup($2) + " )", "(", ")", ":", "classdef"}; node_numbers = {node_count, node_count + 1, node_count + 2, $4, node_count + 3, node_count + 4, $7}; insert_node(); $$ = node_count + 5; node_count += 6;}
        | KEY_CLASS NAME DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_COLON suite {node_attr = {"class", string("NAME ( ") + strdup($2) + " )", "(", ")", ":", "classdef"}; node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4, $6}; insert_node(); $$ = node_count + 5; node_count += 6;}
        | KEY_CLASS NAME DELIM_COLON suite {node_attr = {"class", string("NAME ( ") + strdup($2) + " )", ":", "classdef"}; node_numbers = {node_count, node_count + 1, node_count + 2, $4}; insert_node(); $$ = node_count + 3; node_count += 4;}

arglist: argument {node_attr = {"arglist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
       | argument DELIM_COMMA arglist {node_attr = {",", "arglist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | argument DELIM_COMMA {node_attr = {",", "arglist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

argument: test comp_for {node_attr = {"argument"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1;}
        | test {node_attr = {"argument"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | test DELIM_ASSIGN test {node_attr = {"=", "argument"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | OP_POWER test {node_attr = {"**", "argument"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | OP_MULTIPLY test  {node_attr = {"*", "argument"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}

comp_iter: comp_for {node_attr = {"comp_iter"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | comp_if {node_attr = {"comp_iter"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        
sync_comp_for: KEY_FOR exprlist KEY_IN or_test comp_iter {node_attr = {"for", "in", "sync_comp_for"}; node_numbers = {node_count, $2, node_count + 1, $4, $5}; insert_node(); $$ = node_count + 2; node_count += 3;}
             | KEY_FOR exprlist KEY_IN or_test { node_attr = {"for", "in", "sync_comp_for"}; node_numbers = {node_count, $2, node_count + 1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;}
             
comp_for: sync_comp_for {node_attr = {"comp_for"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

comp_if: KEY_IF test_nocond comp_iter {node_attr = {"if", "comp_if"}; node_numbers = {node_count, $2, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | KEY_IF test_nocond {node_attr = {"if", "comp_if"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}

func_body_suite: simple_stmt {node_attr = {"func_body_suite"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
               |  newline_plus INDENT stmt_plus DEDENT {node_attr = {"func_body_suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}
               |  newline_plus INDENT stmt_plus DEDENT newline_plus {node_attr = {"func_body_suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}
        
types: TYPE_INT {node_attr = {"int", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | TYPE_BOOL {node_attr = {"bool", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | TYPE_DICT {node_attr = {"dict", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | TYPE_FLOAT {node_attr = {"float", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | type_list {node_attr = {"types"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
     | TYPE_STRING {node_attr = {"str", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

type_list: TYPE_LIST DELIM_LEFT_BRACKET types DELIM_RIGHT_BRACKET {node_attr = {"list", "[", "]", "type_list"}; node_numbers = {node_count, node_count + 1, $3, node_count + 2}; insert_node(); $$ = node_count + 3; node_count += 4;}

%%


int main(int argc, char* argv[]) {
    /* int yydebug = 0; */
    int help_flag = 0;
    string input_file = "";
    string output_file = "ast.dot";
    for(int i = 1 ; i < argc; i++) {
        string s = argv[i];
        if(s == "--help") {
            help_flag = 1;
            continue;
        }
        if(s == "--verbose") {
            yydebug = 1;
            continue;
        }
        string flag = s;
        if(s.length() <= 7) {
            cerr << "Wrong usage of flags" << endl;
            return 0;
        }
        flag = flag.substr(0, 8);
        if(flag == "--input=") {
            input_file = s.substr(8, s.length());
            continue;
        }
        flag = s;
        if(s.length() <= 8) {
            cerr << "Wrong usage of flags" << endl;
            return 0;
        }
        flag = flag.substr(0, 9);
        if(flag == "--output=") {
            output_file = s.substr(9, s.length());
            continue;
        }
        cerr << "Wrong flag" << endl;
        return 0;
    }

    if(help_flag) {
        cout << "Usage: ./parser --input=<input_file_path> --output=<output_file_path> [options]" << endl;
        cout << "The following options can be used" << endl;
        cout << "--input=<input_file_path> \t: Input file specification (default is command line)" << endl;
        cout << "--output=<output_file_path> \t: Output file specification (default is ast.dot)" << endl;
        cout << "--help \t\t\t\t: Instruction regarding usage instructions and options" << endl;
        cout << "--verbose \t\t\t: Prints the complete stack trace of the parser execution" << endl;
        return 0;
    }
    /* string input_file = "../test/testcases/public1.py";
    string output_file = "ast.dot"; */

    if(input_file != "") {
        freopen(input_file.c_str(), "r", stdin);
    } 
    yyparse();
    ofstream dotFile(output_file.c_str());
    dotFile << "digraph G {\n  ordering=\"out\"" << endl;
	vector<bool> valid(nodes.size(),true);

    /* for(auto a: adj) {
        for(auto b: a) {
            if(b >= adj.size()) cout << b << endl;
        }
    }*/
    
    for(int i=0;i<nodes.size();i++) {
		for(int j=0; j<adj[i].size();j++) {
			int k = adj[i][j];
			while(adj[k].size() == 1){
                valid[k] = false;
                k = adj[k][0];
            }
			adj[i][j] = k;
		}
	}
    
    map<int,int> mp;
    set<int> op_set;
    for(int i=0;i<nodes.size();i++)
    {
        for(auto it:adj[i])
        {
            if(isop(nodes[it]))
            {
                mp[i] = it;
                op_set.insert(it);
            }
        }
    }

	

    for (int i = 0; i < nodes.size(); i++) {
		if(valid[i] && op_set.find(i) == op_set.end()){
            string tmp = nodes[i];
            if(mp.find(i) != mp.end())
            {
                tmp = nodes[mp[i]];
            }
        	dotFile << "  " << i << " [label=\"" << tmp << "\"];" << endl;
        }
    }

    for (int i = 0; i < adj.size(); i++) {
        int not_cnt = -1;
        if(mp.find(i) != mp.end()){
            not_cnt = mp[i];
        }
        for (int j = 0; j < adj[i].size(); j++) {
			if(valid[i] && adj[i][j] != not_cnt){
            	dotFile << "  " << i << " -> " << adj[i][j] << ";" << endl;
            }
        }
    }

    dotFile << "}" << endl;
    return 0;
}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}
