%{
#include<bits/stdc++.h>
#include "../include/node.hpp"
using namespace std;
#define YYDEBUG 1

extern int yylineno;
vector <string> nodes;
vector <vector <int>> adj;
int node_count = 0;
vector <string> node_attr;
vector <int> node_numbers;
bool our_debug = false;
node* root_node = NULL; 
vector<node *> all_nodes;

symbol_table_global* global_table;
symbol_table* current_table;
symbol_table* temp_table;

void debug_insert() {
    cout << "PRODUCTION:\t";
    for(auto s: node_attr) cout << s << "\t";
    cout << endl;
    cout << "NODE COUNT " << node_count << endl;
    cout << "NODE_ATTR SIZE " << node_attr.size() << endl;
    cout << "ADJ SIZE " << adj.size() << endl;
}

bool isop(string s) {
    return (s == "+" || s == "-" || s == "*" || s == "**" || s == "/" ||
            s == "//" || s == "%" || s == "@" || s == "<<" || s == ">>" ||
            s == "&" || s == "|" || s == "^" || s == "~" || s == ":=" ||
            s == "<" || s == ">" || s == "<=" || s == ">=" || s == "==" || 
            s == "!=" || s == "+=" || s == "-=" || s == "*=" || s == "/=" ||
            s == "//=" || s == "%=" || s == "&=" || s == "|=" || s == "<<=" ||
            s == ">>=" || s == "^=" || s == "**=" ||  s == "=");
}

bool isdelim(string s) {
    return (s == "(" || s == ")" || s == "[" || s == "]" || s == "{" ||
            s == "}" || s == "," || s == ":" || s == "." || s == ";" ||
            s == "->" || s == "...");
}

bool iskeyword(string s) {
    return (s == "False" || s == "await" || s == "else" || s == "import" ||
            s == "pass" || s == "None" || s == "break" || s == "except" ||
            s == "in" || s == "raise" || s == "True" || s == "class" || s == "finally" ||
            s == "is" || s == "return" || s == "and" || s == "continue" || s == "for" ||
            s == "as" || s == "try" || s == "def" || s == "from" || s == "nonlocal" ||
            s == "while" || s == "assert" || s == "del" || s == "global" || s == "not" ||
            s == "with" || s == "async" || s == "elif" || s == "if" || s == "or" || s == "yield");
}

node* adj_to_nodes(string tmp) {
        node* new_node = NULL;
        int isterm = true;
        if(isdelim(tmp)) {
            new_node = new node(tmp, true, "DELIMITER");
        }
        else if(isop(tmp)) {
            new_node = new node(tmp, true, "OPERATOR");
        }
        else if(iskeyword(tmp)) {
            new_node = new node(tmp, true, "KEYWORD");
        }
        else if(tmp.substr(0,3) == "INT") {
            new_node = new node(tmp, true, "LITERAL");
            new_node -> datatype = "int";
        }
        else if(tmp.substr(0,3) == "FLT") {
            new_node = new node(tmp,true,"LITERAL");
            new_node -> datatype = "float";
        }
        else if(tmp.substr(0,3) == "BOL") {
            new_node = new node(tmp,true,"LITERAL");
            new_node-> datatype = "bool";
        }
        else if(tmp.substr(0,3) == "STR") {
           new_node = new node(tmp,true,"LITERAL");
            new_node-> datatype = "str";
        }
        else if(tmp.substr(0, 4) == "NAME") {
            new_node = new node(tmp, true, "NAME");
        }
        else {
            isterm = false;
            new_node = new node(tmp);
        }
        if(isterm) {
            new_node->terminal = true;
        }
        else {
            new_node->terminal = false;
        }
        return new_node;
}

void insert_node() {
    for(int i = 0; i < node_attr.size(); i++) {
        all_nodes.push_back(adj_to_nodes(node_attr[i]));
        //adj.push_back(vector<int>());
    }
    if(our_debug) {
        debug_insert();
    }
    for(int i = 0; i < node_numbers.size(); i++) {
        // adj[node_count + node_attr.size() - 1].push_back(node_numbers[i]);
        all_nodes[node_count + node_attr.size() - 1]->add_child(all_nodes[node_numbers[i]]);
    }
}

void print_help() {
    cout << "Usage: ./run.sh --input=<input_file_path> [options]" << endl;
    cout << "The following options can be used" << endl;
    cout << endl;
    cout << "--output=<output_file_path> \t: Output file specification (default is ast.dot)" << endl;
    cout << "--colorop=<color> \t\t: Color for operator nodes in the AST" << endl;
    cout << "--colordelim=<color> \t\t: Color for delimiter nodes in the AST" << endl;
    cout << "--colorkey=<color> \t\t: Color for keyword nodes in the AST" << endl;
    cout << "--help \t\t\t\t: Instruction regarding usage instructions and options" << endl;
    cout << "--verbose1 \t\t\t: Prints our custom debug statements while reducing a production" << endl;
    cout << "--verbose2 \t\t\t: Prints the complete stack trace of the parser execution" << endl;
    cout << endl;
    exit(1);
}

void make_new_class_symbtab(string s, string parent = "") {
    temp_table = new symbol_table_class(s);
    if(current_table->symbol_table_category == 'G') {
        symbol_table_class *if_exist = global_table -> look_up_class(s);
        if(if_exist) {
            cout << "Redeclaration of class in same scope at line " << yylineno << endl;
            exit(1);
        }
        ((symbol_table_global *) current_table)->add_entry((symbol_table_class *) temp_table);
    }
    else {
        cout << "Illegal class definition at line " << yylineno << endl;
        exit(1);
    }
    
    if(parent != "") {
        symbol_table_class *par = ((symbol_table_global *)current_table) -> look_up_class(parent);
        if(par == NULL) {
            cout << "Parent class does not exist at line " << yylineno << endl;
            exit(1);
        }
        else {
            ((symbol_table_class *)temp_table) -> parent_class = par;
        }
    }
    current_table->add_scope(temp_table);
    current_table->children_st.push_back(temp_table);
    current_table = temp_table;
    // cout<<current_table->symbol_table_category<<endl;
}

void make_new_func_symbtab(string func_name, vector<st_entry *> &params, string ret_type) {
    temp_table = new symbol_table_func(func_name, params, ret_type);
    if(current_table->symbol_table_category == 'C') {
        symbol_table_func *if_exist = ((symbol_table_class *)current_table) -> look_up_function(func_name);
        if(if_exist) {
            cout << "Redeclaration of function in same class at line " << yylineno << endl;
            exit(1);
        }
        ((symbol_table_class *) current_table)->add_func((symbol_table_func *) temp_table);
    } else if(current_table->symbol_table_category == 'G') {
        symbol_table_func *if_exist = global_table -> look_up_func(func_name);
        if(if_exist) {
            cout << "Redeclaration of function in global scope at line " << yylineno << endl;
            exit(1);
        }
        ((symbol_table_global *) current_table)->add_entry((symbol_table_func *) temp_table);
    }
    else {
        cout<< "Invalid function declaration at line " << yylineno << endl;
        exit(1);
    }
    current_table->add_scope(temp_table);
    current_table->children_st.push_back(temp_table);
    current_table = temp_table;
}

extern int yylex(void);
void yyerror(const char*);

%}

%define parse.error verbose

%union {
    char* strval;
    int intval;
}

%token<strval> KEY_FALSE KEY_ELSE  KEY_NONE KEY_BREAK KEY_IN KEY_TRUE KEY_CLASS  KEY_IS KEY_RETURN KEY_AND KEY_CONTINUE KEY_FOR KEY_DEF KEY_WHILE KEY_GLOBAL KEY_NOT KEY_ELIF KEY_IF KEY_OR OP_ADD OP_SUBTRACT OP_MULTIPLY OP_POWER OP_DIVIDE OP_FLOOR_DIVIDE OP_MODULO OP_AT OP_LEFT_SHIFT OP_RIGHT_SHIFT OP_BITWISE_AND OP_BITWISE_OR OP_BITWISE_XOR OP_BITWISE_NOT OP_LESS_THAN OP_GREATER_THAN OP_LESS_THAN_EQUAL OP_GREATER_THAN_EQUAL OP_EQUAL OP_NOT_EQUAL DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET DELIM_LEFT_CURLY DELIM_RIGHT_CURLY DELIM_COMMA DELIM_COLON DELIM_DOT DELIM_SEMICOLON DELIM_ASSIGN DELIM_ARROW DELIM_ASSIGN_ADD DELIM_ASSIGN_SUBTRACT DELIM_ASSIGN_MULTIPLY DELIM_ASSIGN_DIVIDE DELIM_ASSIGN_FLOOR_DIVIDE DELIM_ASSIGN_MODULO DELIM_ASSIGN_BITWISE_AND DELIM_ASSIGN_BITWISE_OR DELIM_ASSIGN_BITWISE_XOR DELIM_ASSIGN_RIGHT_SHIFT DELIM_ASSIGN_LEFT_SHIFT DELIM_ASSIGN_POWER DELIM_ELLIPSIS NAME INDENT DEDENT NEWLINE FLOAT_NUMBER IMAGINARY_NUMBER INTEGER STRING_LITERAL DUNDER_NAME DUNDER_MAIN TYPE_INT TYPE_FLOAT TYPE_STRING TYPE_BOOL TYPE_LIST 

%type<intval> start_symbol single_stmt compound_stmt blocks parameters func_body_suite test typedarglist tfpdef testlist small_stmt expr_stmt flow_stmt global_stmt semicolon_stmt break_stmt continue_stmt exprlist return_stmt names classdef if_stmt while_stmt funcdef for_stmt namedexpr_test elif_plus or_test suite stmt_plus and_test not_test comparison expr comp_op xor_expr and_expr shift_expr arith_expr term factor power atom_expr atom trailer_plus trailer argument named_star_plus number arglist types newline_plus file_input file_plus program_start string_plus augassign type_list type_declaration func_header class_header type_or_name

%start start_symbol

%left DELIM_COMMA

%%

start_symbol: file_input {node_attr = {"start_symbol"};  node_numbers = {$1};insert_node();$$ = node_count; node_count += 1;}

file_input: file_plus {node_attr = {"file_input"};  node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;} 
          | newline_plus file_plus {node_attr = {"file_input"}; node_numbers = {$2}; insert_node();  $$ = node_count; node_count += 1;} 
          | newline_plus {node_attr = {"file_input"}; node_numbers = {}; insert_node();  $$ = node_count; node_count += 1;}

file_plus: file_plus blocks {$$ = $1; /* adj[$$].push_back($2);*/  all_nodes[$$]->add_child(all_nodes[$2]);} 
         | blocks {$$ = $1;} 

newline_plus: newline_plus NEWLINE {}
            | NEWLINE {}

funcdef: func_header func_body_suite {node_attr = {"funcdef"}; node_numbers = {$2}; insert_node(); $$ = node_count; node_count += 1; current_table = current_table->parent_st;} 

func_header: KEY_DEF NAME parameters DELIM_ARROW test DELIM_COLON {
    node_attr = {"def", string("NAME ( ") + strdup($2) + " )", "->", ":" "func_header"};
    node_numbers = {node_count, node_count + 1, $3, node_count + 2, $5, node_count + 3};
    insert_node();
    $$ = node_count + 2;
    node_count += 3;
    make_new_func_symbtab(strdup($2), all_nodes[$3]->entry_list, all_nodes[$5]->datatype);
}
    | KEY_DEF NAME parameters DELIM_COLON {
    node_attr = {"def", string("NAME ( ") + strdup($2) + " )", ":", "func_header"};
    node_numbers = {node_count, node_count + 1, $3, node_count + 2};
    insert_node();
    $$ = node_count + 3; 
    node_count += 4;
    make_new_func_symbtab(strdup($2), all_nodes[$3]->entry_list, "None");
    
}

parameters: DELIM_LEFT_PAREN typedarglist DELIM_RIGHT_PAREN {
    node_attr = {"(", ")", "parameters"}; node_numbers = {node_count, $2, node_count+1}; insert_node();
    $$ = node_count + 2;
    node_count += 3;
    all_nodes[$$]->entry_list = all_nodes[$2]->entry_list;
}
| DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {
    node_attr = {"(", ")","parameters"}; 
    node_numbers = {node_count+0,node_count+1};
    insert_node();
    $$ = node_count + 2;
    node_count += 3;
}

typedarglist: tfpdef DELIM_COMMA {
    node_attr = {",", "typedarglist"};
    node_numbers = {$1, node_count};
    insert_node();
    $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->entry_list = all_nodes[$1]->entry_list;
}
| tfpdef {
    node_attr = {"typedarglist"};
    node_numbers = {$1};
    insert_node();
    $$ = node_count;
    node_count += 1;
    all_nodes[$$]->entry_list = all_nodes[$1]->entry_list;
}
| tfpdef DELIM_COMMA typedarglist {
    node_attr = {",", "typedarglist"};
    node_numbers = {$1, node_count, $3};
    insert_node();
    $$ = node_count + 1; 
    node_count += 2;
    all_nodes[$$]->entry_list = all_nodes[$1]->entry_list; 
    all_nodes[$$]->entry_list.insert(all_nodes[$$]->entry_list.end(), all_nodes[$3]->entry_list.begin(), all_nodes[$3]->entry_list.end());
}

tfpdef: NAME DELIM_COLON type_or_name {
    node_attr = {string("NAME ( ") + strdup($1) + " )", ":", "tpdef"};
    node_numbers = {node_count, node_count + 1, $3};
    insert_node();
    $$ = node_count + 2;
    st_entry *new_entry = new st_entry(strdup($1), yylineno, yylineno, all_nodes[$3]->datatype);
    all_nodes[$$]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = all_nodes[$3]->datatype;
    //all_nodes[node_count]->type_checked = true;
    if(all_nodes[$3]->datatype.length() >= 4 && all_nodes[$3]->datatype.substr(0,4) == "list"){
        all_nodes[$$]->entry_list[0]->dimensions = 1;
    }
    node_count += 3;
}
| NAME {
    node_attr = {string("NAME ( ") + strdup($1) + " )", "tpdef"};
    node_numbers = {node_count};
    insert_node();
    $$ = node_count + 1;
    if(string(strdup($1)) != "self" || current_table -> symbol_table_category != 'C') {
        cout << "Parameter not statically typed at line " << yylineno << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup($1), yylineno, yylineno, current_table->name);
    all_nodes[$$]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = current_table->name;
    node_count += 2;
} 

blocks: single_stmt {node_attr = {"blocks"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
      | compound_stmt {node_attr = {"blocks"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

single_stmt: semicolon_stmt newline_plus { node_attr = {"single_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

semicolon_stmt: small_stmt {node_attr = {"semicolon_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1; }
             | small_stmt DELIM_SEMICOLON {node_attr = {";", "semicolon_stmt"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
             | small_stmt DELIM_SEMICOLON semicolon_stmt {node_attr = {";", "semicolon_stmt"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

small_stmt: expr_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | flow_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
          | global_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        
expr_stmt: type_declaration {node_attr = {"expr_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | type_declaration DELIM_ASSIGN test {node_attr = {"=", "expr_stmt"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | test augassign testlist {node_attr = {"expr_stmt"}; node_numbers = {$1, $2, $3}; insert_node(); $$ = node_count; node_count += 1;}        
         | test DELIM_ASSIGN test {node_attr = {"=","expr_stmt"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | test {node_attr = {"expr_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

type_declaration: NAME DELIM_COLON type_or_name {
    node_attr = {string("NAME ( ") + strdup($1) + " )", ":", "type_declaration"};
    node_numbers = {node_count, node_count + 1, $3};
    insert_node(); 
    $$ = node_count + 2;
    st_entry *entry = current_table -> look_up_local(strdup($1));
    if(entry) {
        cout << strdup($1) << " already declared at " << entry->line_no << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup($1), yylineno, yylineno, all_nodes[$3]->datatype);
    // all_nodes[$$]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = all_nodes[$3]->datatype;
    if(all_nodes[$3]->datatype.length() >= 4 && all_nodes[$3]->datatype.substr(0,4) == "list"){
        new_entry->dimensions = 1;
    }
    new_entry -> table = current_table;
    current_table -> add_entry(new_entry);
    node_count += 3;
}

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

flow_stmt: break_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | continue_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
         | return_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

break_stmt: KEY_BREAK {node_attr = {"break", "break_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

continue_stmt: KEY_CONTINUE {node_attr = {"continue", "continue_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

return_stmt: KEY_RETURN test {node_attr = {"return", "return_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
           | KEY_RETURN {node_attr = {"return", "return_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

global_stmt: KEY_GLOBAL names {node_attr = {"global", "global_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
 
names: NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "names"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | NAME DELIM_COMMA names {node_attr = {"NAME", ",", "names"}; node_numbers = {node_count+0,node_count + 1, $3}; insert_node(); $$ = node_count + 2; node_count += 3;}

compound_stmt: if_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | while_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | for_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | funcdef {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | classdef {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
             | program_start {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
 
program_start: KEY_IF DUNDER_NAME OP_EQUAL DUNDER_MAIN DELIM_COLON suite {node_attr = {"if", "__name__", "==", "__main__", ":", "program_start"}; node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4, $6}; insert_node(); $$ = node_count + 5; node_count += 6;}

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
            node_attr = {"for","in", ":","for_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, node_count+2, $6}; insert_node(); $$ = node_count + 3; node_count += 4;}

stmt_plus : blocks {$$ = $1;}
          | stmt_plus blocks {$$ = $1; /*adj[$$].push_back($2);*/ all_nodes[$$]->add_child(all_nodes[$2]);}
        
suite: single_stmt {node_attr = {"suite"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
     | newline_plus INDENT stmt_plus DEDENT {node_attr = {"suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}
     | newline_plus INDENT stmt_plus DEDENT newline_plus{node_attr = {"suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}

namedexpr_test: test {node_attr = {"namedexpr_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
              | test DELIM_ASSIGN test {node_attr = {"=", "namedexpr_test"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
    
test: or_test {node_attr = {"test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

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

string_plus: string_plus STRING_LITERAL {node_attr = {string("STR ") + strdup($2), "string_plus"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
           | STRING_LITERAL {node_attr = {string("STR ") + strdup($1), "string_plus"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

atom: DELIM_LEFT_PAREN named_star_plus DELIM_RIGHT_PAREN {node_attr = {"(", ")", "atom"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")", "atom"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_BRACKET named_star_plus DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "atom"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "atom"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | DELIM_LEFT_CURLY DELIM_RIGHT_CURLY {node_attr = {"{", "}", "atom"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
    | NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | number {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | string_plus {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
    | DELIM_ELLIPSIS {node_attr = {"...", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | KEY_NONE {node_attr = {"None", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | KEY_TRUE {node_attr = {string("BOL ") + strdup($1), "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | KEY_FALSE {node_attr = {string("BOL ") + strdup($1), "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
    | types {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

number: INTEGER {node_attr = {string("INT ") + strdup($1), "number"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | FLOAT_NUMBER {node_attr = {string("FLT ") + strdup($1), "number"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
      | IMAGINARY_NUMBER {node_attr = {string("IMG ") + strdup($1), "number"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

named_star_plus: namedexpr_test {node_attr = {"named_star_plus"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
               | namedexpr_test DELIM_COMMA {node_attr = {",", "named_star_plus"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
               | namedexpr_test DELIM_COMMA named_star_plus {node_attr = {",", "named_star_plus"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}

trailer: DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailer"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailer"}; node_numbers = {node_count, node_count+1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | DELIM_LEFT_BRACKET test DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "trailer"}; node_numbers = {node_count, $2, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}
       | DELIM_DOT NAME {node_attr = {".", string("NAME ( ") + strdup($2) + " )", "trailer"}; node_numbers = {node_count, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}

trailer_plus: trailer_plus trailer {node_attr = {"trailer_plus"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count + 0; node_count += 1;}
            | trailer {node_attr = {"trailer_plus"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}

exprlist: expr {node_attr = {"exprlist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | expr DELIM_COMMA exprlist {node_attr = {",", "exprlist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | expr DELIM_COMMA {node_attr = {",", "exprlist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

testlist: test {node_attr = {"testlist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | test DELIM_COMMA testlist {node_attr = {",", "testlist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | test DELIM_COMMA {node_attr = {",", "testlist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

classdef: class_header suite {
    node_attr = {"classdef"};
    node_numbers = {$1, $2};
    insert_node();
    $$ =  node_count;
    node_count += 1;
    current_table = current_table->parent_st;
}
        
class_header: KEY_CLASS NAME DELIM_LEFT_PAREN NAME DELIM_RIGHT_PAREN DELIM_COLON {
    node_attr = {"class", string("NAME ( ") + strdup($2) + " )", "(", string("NAME ( ") + strdup($4) + " )", ")", ":", "class_header"};
    node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4, node_count + 5};
    insert_node();
    $$ = node_count + 6;
    node_count += 7;
    make_new_class_symbtab(strdup($2), strdup($4));
}
| KEY_CLASS NAME DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_COLON {
    node_attr = {"class", string("NAME ( ") + strdup($2) + " )", "(", ")", ":", "class_header"};
    node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4};
    insert_node();
    $$ = node_count + 5;
    node_count += 6;
    make_new_class_symbtab(strdup($2));
}
| KEY_CLASS NAME DELIM_COLON {
    node_attr = {"class", string("NAME ( ") + strdup($2) + " )", ":", "class_header"};
    node_numbers = {node_count, node_count + 1, node_count + 2};
    insert_node();
    $$ = node_count + 3;
    node_count += 4;
    make_new_class_symbtab(strdup($2));
}

arglist: argument {node_attr = {"arglist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1; }
       | argument DELIM_COMMA arglist {node_attr = {",", "arglist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2; }
       | argument DELIM_COMMA {node_attr = {",", "arglist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2; }

argument: test {node_attr = {"argument"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
        | test DELIM_ASSIGN test {node_attr = {"=", "argument"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;}
        /* | OP_POWER test {node_attr = {"**", "argument"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;}
        | OP_MULTIPLY test  {node_attr = {"*", "argument"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;} */

func_body_suite: single_stmt {node_attr = {"func_body_suite"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
               |  newline_plus INDENT stmt_plus DEDENT {node_attr = {"func_body_suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}
               |  newline_plus INDENT stmt_plus DEDENT newline_plus {node_attr = {"func_body_suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;}
        
types: TYPE_INT {node_attr = {"int", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | TYPE_BOOL {node_attr = {"bool", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | TYPE_FLOAT {node_attr = {"float", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
     | type_list {node_attr = {"types"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
     | TYPE_STRING {node_attr = {"str", "types"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

type_list: TYPE_LIST DELIM_LEFT_BRACKET types DELIM_RIGHT_BRACKET {node_attr = {"list", "[", "]", "type_list"}; node_numbers = {node_count, node_count + 1, $3, node_count + 2}; insert_node(); $$ = node_count + 3; node_count += 4;}
         | TYPE_LIST DELIM_LEFT_BRACKET NAME DELIM_RIGHT_BRACKET {node_attr = {"list", "[", string("NAME ( ") + strdup($3) + " )", "]", "type_list"}; node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3}; insert_node(); $$ = node_count + 4; node_count += 5;}

type_or_name: types {node_attr = {"type_or_name"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;}
            | NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "type_or_name"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

%%


int main(int argc, char* argv[]) {
    global_table = new symbol_table_global();
    current_table = global_table;
    temp_table = NULL;
    /* int yydebug = 0; */
    bool help_flag = false;
    string input_file = "";
    string output_file = "ast.dot";
    string op_color = "red";
    string delim_color = "forestgreen";
    string key_color = "blue";
    string name_color = "cyan3";
    string default_color = "black";

    for(int i = 1; i < argc; i++) {
        string s = argv[i];
        if(s == "--help") {
            help_flag = true;
            continue;
        }
        if(s == "--verbose2") {
            yydebug = 1;
            continue;
        }
        if(s == "--verbose1") {
            our_debug = true;
            continue;
        }
        if(s.length() <= 7) {
            cerr << "Wrong flag used!!" << endl;
            cout << endl;
            print_help();
        }
        if(s.substr(0, 8) == "--input=") {
            input_file = s.substr(8);
        } 
        else if(s.substr(0, 9) == "--output=") {
            output_file = s.substr(9);
        }
        else if(s.substr(0, 10) == "--colorop=") {
            op_color = s.substr(10);
        }
        else if(s.substr(0, 11) == "--colorkey=") {
            key_color = s.substr(11);
        } 
        else if(s.substr(0, 13) == "--colordelim=") {
            delim_color = s.substr(13);
        }
        else {
            cerr << "Wrong flag used!!" << endl;
            cout << endl;
            print_help();
        }
    }

    if(!help_flag && input_file.empty()) {
        cout << "Input file not specified!" << endl;
        cout << endl;
        help_flag = 1;
    }

    if(help_flag) {
        print_help();
    }

    if(input_file != "") {
        freopen(input_file.c_str(), "r", stdin);
    } 

    yyparse();
    root_node = all_nodes.back();
    root_node->clean_tree();
    root_node -> make_dot();
    
    return 0;
}

void yyerror (char const *s) {
    fprintf (stderr, "%s\nOn line %d\n", s, yylineno);
}
