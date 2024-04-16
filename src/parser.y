%{
#include<bits/stdc++.h>
#include "../include/global.hpp"
using namespace std;
#define YYDEBUG 1

extern int yylineno;
extern int in_loop;

int node_count = 0;
int ins_count = 0;
int temp_count = 0;
int str_count = 1;
bool our_debug = false;
vector <string> nodes;
vector <vector <int>> adj;
vector <string> node_attr;
map<string, string> string_list;
vector <int> node_numbers;
vector <node *> all_nodes;
vector <quad> all_quads;
node* root_node = NULL;
symbol_table *current_table;
symbol_table *temp_table;

void debug_insert() {
    cout << "PRODUCTION:\t";
    for(auto s: node_attr) cout << s << "\t";
    cout << endl;
    cout << "NODE COUNT " << node_count << endl;
    cout << "NODE_ATTR SIZE " << node_attr.size() << endl;
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
    }
    if(our_debug) {
        debug_insert();
    }
    for(int i = 0; i < node_numbers.size(); i++) {
        all_nodes[node_count + node_attr.size() - 1]->add_child(all_nodes[node_numbers[i]]);
    }
}

void print_help() {
    cout << "Usage: ./run.sh --input=<input_file_path> [options]" << endl;
    cout << "The following options can be used" << endl;
    cout << endl;
    cout << "--output=<output_file_path> \t: Output file specification (default is 3AC.txt)" << endl;
    cout << "--help \t\t\t\t: Instruction regarding usage instructions and options" << endl;
    cout << "--verbose1 \t\t\t: Prints our custom debug statements while reducing a production" << endl;
    cout << "--verbose2 \t\t\t: Prints the complete stack trace of the parser execution" << endl;
    cout << endl;
    exit(1);
}

string get_new_temp() {
    string temp = "__t" + to_string(temp_count);
    temp_count++;
    return temp;
}

string get_new_str_temp() {
    string temp = ".LC" + to_string(str_count);
    str_count++;
    return temp;
}

string max_type(string type1, string type2) {
    if(type1 == type2) {
        return type1;
    }
    if(type1 == "float" || type2 == "float") {
        return "float";
    }
    if(type1 == "int" || type2 == "int") {
        return "int";
    }
    return "UNDEFINED";
}

bool is_not_class(string &type) {
    bool flag = false;
    for(auto t: primitive_types) {
        if(t == type) {
            flag = true;
            break;
        }
    }
    if(type.length() >= 4 && type.substr(0,4) == "list") {
        flag = true;
    }
    return flag;
}

void check_type_int_bool(string type1, string type2, string op) {
    if((type1 != "int" && type1 != "bool") || (type2 != "bool" && type2 != "int")) {
        cout << "Typeerror at line " << yylineno << ": unsupported operand type(s) for " << op << ": " << type1 << " and " << type2 << endl;
        exit(1);
    }
}

string check_type_arith(string type1, string type2, string op) {
    if((type1 != "int" && type1 != "bool" && type1 != "float") || (type2 != "bool" && type2 != "int" &&type2 != "float")) {
        cout << "Typeerror at line " << yylineno << ": unsupported operand type(s) for " << op << ": " << type1 << " and " << type2 <<endl;
        exit(1);
    }
    if(type1 == "float" || type2 == "float") return "float";
    return "int";
}

void make_new_class_symbtab(string s, string parent = "") {
    temp_table = new symbol_table_class(s);
    if(current_table->symbol_table_category == 'G') {
        symbol_table_class *if_exist = global_table -> look_up_class(s);
        if(if_exist) {
            cout << "Redeclaration of class '" << s << "' in same scope at line " << yylineno << endl;
            exit(1);
        }
        ((symbol_table_global *) current_table)->add_entry((symbol_table_class *) temp_table);
    }
    else {
        cout << "Illegal definition of class '" << s << "' at line " << yylineno << endl;
        exit(1);
    }
    
    if(parent != "") {
        symbol_table_class *par = ((symbol_table_global *)current_table) -> look_up_class(parent);
        if(par == NULL) {
            cout << "Parent class '" << parent << "' is not defined at line " << yylineno << endl;
            exit(1);
        }
        else {
            ((symbol_table_class *)temp_table) -> parent_class = par;
            ((symbol_table_class *)temp_table) -> object_size = par -> object_size;
        }
    }
    temp_table->scope_start_line_no = yylineno;
    current_table->add_scope(temp_table);
    current_table->children_st.push_back(temp_table);
    current_table = temp_table;
}

symbol_table_func *check_predefined_functions(string func_name, vector<string> &params) {
    if(func_name == "print") {
        if(params.size() != 1) {
            cout << "Invalid arguments for 'print' at line " << yylineno << endl;
            exit(1);
        }
        if(params[0] != "str" && params[0] != "int" && params[0] != "float" && params[0] != "bool") {
            cout << "Invalid arguments for 'print' at line " << yylineno << endl;
            exit(1);
        }
        for(int i = 0; i < global_table->functions.size(); i++) {
            if(global_table->functions[i]->name == "print" && global_table->functions[i]->params[0]->type == params[0]) {
                return global_table->functions[i];
            }
        }
        return NULL;
    }
    else if(func_name == "len"){
        if(params.size() != 1) {
            cout << "Invalid arguments for 'len' at line " << yylineno << endl;
            exit(1);
        }
        if(params[0].length() < 4 || params[0].substr(0,4) != "list") {
            cout << "Invalid arguments for 'len' at line " << yylineno << endl;
            exit(1);
        }
        return global_table->look_up_func(func_name);
    }
    return NULL;
}

symbol_table_func *make_new_func_symbtab(string func_name, vector<st_entry *> &params, string ret_type) {
    int sz = params.size();
    for(int i = 0; i < sz - 1; i++) {
        for(int j = i + 1; j < sz; j++) {
            if(params[i]->name == params[j] -> name) {
                cout << "Duplicate argument '" << params[i]->name << "' in definition of function '" << func_name << "' at line " << yylineno << endl;
                exit(1);
            }
        }
    }
    temp_table = new symbol_table_func(func_name, params, ret_type);
    if(current_table->symbol_table_category == 'C') {
        symbol_table_func *if_exist = ((symbol_table_class *)current_table) -> look_up_function(func_name);
        if(if_exist) {
            cout << "Redeclaration of function '" << func_name << "' in same scope at line " << yylineno << endl;
            exit(1);
        }
        temp_table -> mangled_name = current_table -> name + "@" + temp_table -> name;
        ((symbol_table_class *) current_table)->add_func((symbol_table_func *) temp_table);
    }
    else if(current_table->symbol_table_category == 'G') {
        symbol_table_func *if_exist = global_table -> look_up_func(func_name);
        if(if_exist) {
            cout << "Redeclaration of function '" << func_name << "' in global scope at line " << yylineno << endl;
            exit(1);
        }
        temp_table -> mangled_name = temp_table -> name;
        ((symbol_table_global *) current_table)->add_entry((symbol_table_func *) temp_table);
    }
    else {
        cout<< "Invalid declaration of function '" << func_name << "' at line " << yylineno << endl;
        exit(1);
    }
    temp_table->scope_start_line_no = yylineno;
    current_table->add_scope(temp_table);
    current_table->children_st.push_back(temp_table);
    current_table = temp_table;
    return (symbol_table_func *)temp_table;
}

void is_compatible(string type1, string type2 = "bool", bool stri = false) {
    if(type1 == "int") {
        if (!(type2 == "int" || type2 == "float" || type2 == "bool")){
            cout << "Incompatible types " << type1 << " and " << type2 << " on line " << yylineno << endl;
            exit(1);
        }
        return;
    }
    if(type1 == "float") {
        if (!(type2 == "int" || type2 == "float")){
            cout << "Incompatible types " << type1 << " and " << type2 << " on line " << yylineno << endl;
            exit(1);
        }
        return;
    }
    if(type1 == "bool") {
        if (!(type2 == "int" || type2 == "bool")){
           cout << "Incompatible types " << type1 << " and " << type2 << " on line " << yylineno << endl;
            exit(1);
        }
        return;
    }
    if(type1 != type2 || (stri && type1 != "str")){
        cout << "Incompatible types " << type1 << " and " << type2 << " on line " << yylineno << endl;
        exit(1);
    }
    return;
}

void for_break_continue(int n1, int n2) {
    for(int i = 0; i < all_nodes[n1]->ta_codes.size(); i++) {
        auto (&tac) = all_nodes[n1]->ta_codes[i];
        if(tac.code == "\t\tgoto CONTINUE;\n"){
            int rel_jump = all_nodes[n1] -> ta_codes.size() - i;
            tac = quad("", "J+" + to_string(rel_jump), "goto", "");     // res, arg1, op, arg2
            tac.make_code_from_goto();
        }
        else if(tac.code == "\t\tgoto BREAK;\n") {
            int rel_jump = all_nodes[n1] -> ta_codes.size() - i + 2;
            tac = quad("", "J+" + to_string(rel_jump), "goto", "");     // res, arg1, op, arg2
            tac.make_code_from_goto();
        }
    }
}

void while_break_continue(int n1, int n2) {
    for(int i = 0; i < all_nodes[n1]->ta_codes.size(); i++) {
        auto (&tac) = all_nodes[n1]->ta_codes[i];
        if(tac.code == "\t\tgoto CONTINUE;\n"){
            int rel_jump = i + all_nodes[n2] -> ta_codes.size();
            tac = quad("", "J-" + to_string(rel_jump), "goto", "");     // res, arg1, op, arg2
            tac.make_code_from_goto();
        }
        else if(tac.code == "\t\tgoto BREAK;\n") {
            int rel_jump = all_nodes[n1] -> ta_codes.size() - i + 1;
            tac = quad("", "J+" + to_string(rel_jump), "goto", "");     // res, arg1, op, arg2
            tac.make_code_from_goto();
        }
    }
}

string check_decl_before_use(string name , node *current_node) {
    st_entry *existing_entry = current_table->look_up(name);
    if(!existing_entry) {
        symbol_table_func *st_func = global_table -> look_up_func(name);
        if(!st_func) {
            symbol_table_class *st_class = global_table -> look_up_class(name);
            if(!st_class) {
                cout << "Identifier '" << name << "' at line " << yylineno << " was not declared\n";
                exit(1);
            }
            else {
                current_node->is_class = true;
                current_node->var = st_class -> name;
                return name;
            }
        }
        else {
            current_node->is_func = true;
            current_node->sym_tab_func = st_func;
            current_node->var = st_func -> mangled_name;
            return st_func -> return_type;
        }
    }
    else {
        current_node->is_var = true;
        current_node->var = existing_entry->mangled_name;
        current_node->sym_tab_entry = existing_entry;
        return existing_entry -> type;
    }
}

string check_star_and_make(node* current_node, string s) {
    if(s[0] == '*') {
        string tmp = get_new_temp();
        quad q(tmp, s.substr(1), "", "");
        q.make_code_from_load();
        current_node->ta_codes.push_back(q);
        return tmp;
    }
    return s;
}

string check_attribute_in_class(symbol_table_class* symtab, string &name, node *current_node, string b = "") {
    st_entry* existing_entry = symtab -> look_up_attribute_in_class_hierarchy(name);
    if(!existing_entry) {
        symbol_table_func *function_entry = symtab -> look_up_function_in_class_hierarchy(name);
        if(!function_entry) {
            cout << "Class '" << symtab->name << "' has no attribute '" << name << "' ( at line " << yylineno << " )\n";
            exit(1);
        }
        else {
            // b = check_star_and_make(current_node, b);
            // quad q0("", b , "push_param", "");
            // q0.make_code_push_param();
            // current_node->ta_codes.push_back(q0);
            current_node -> var = function_entry->mangled_name;
            current_node -> is_func = true;
            current_node -> is_class_func = b;
            current_node -> sym_tab_func = function_entry;
            return function_entry -> return_type;
        }
    }
    else {
        string tmp = get_new_temp();
        // if(b[0] == '*') {
        //     b = b.substr(1);
        // }
        b = check_star_and_make(current_node, b);

        quad q(tmp, b , "+", to_string(existing_entry->offset));
        q.make_code_from_binary();
        current_node->ta_codes.push_back(q);
        current_node->var = "*" + tmp;
        if(!is_not_class(existing_entry -> type)) {
            current_node -> is_class = true;
        } else {
            current_node -> sym_tab_entry = existing_entry;
        }
        current_node -> is_var = true;
        return existing_entry -> type;    
    }
}

string check_self_decl_before_use(string name, node *current_node) {
    if(current_table->symbol_table_category == 'M') {
        return check_attribute_in_class((symbol_table_class *)(current_table -> parent_st), name, current_node, "self");
    }
    else if(current_table -> symbol_table_category == 'C') {
        return check_attribute_in_class(((symbol_table_class *)current_table), name, current_node, "self");
    }
    else {
        cout << "Invalid use of self at line " << yylineno << ". self can only be used within class member functions\n";
        exit(1);
    }
}

string check_constructor(string class_name, vector<string> actual_params, node *curr_node) {   
    symbol_table_class *cl_tb = global_table -> look_up_class(class_name);
    if(!cl_tb) {
        cout << "Class '" << class_name << "' at line " << yylineno << " doesn't exist\n";
        exit(1);
    }
    string init = "__init__";
    symbol_table_func *constr = cl_tb -> look_up_function_in_class_hierarchy(init);
    if(!constr)  {
        cout << "Constructor for class '" << class_name << "' at line " << yylineno << " doesn't exist\n";
        exit(1);
    }
    if(constr -> params.size() != actual_params.size() + 1){
        cout << "Invalid arguments for constructor of class '" << class_name << "' at line " << yylineno << endl;
        exit(1);
    }
    for(int i = 1; i < constr->params.size(); i++) {
        is_compatible(constr->params[i]->type, actual_params[i - 1]);
    }
    curr_node->sym_tab_func = constr;
    return cl_tb -> name;
}

string set_trailer_type_compatibility(int node_num,  node *leftnode, string typeLeft, string typeRight, string attribute_name = "", vector<string> actual_params = {}) {
    node* current_node = all_nodes[node_num];
    if(typeRight == "list_subs") {
        if(typeLeft.length() >= 4 && typeLeft.substr(0, 4) == "list") 
            return typeLeft.substr(6, typeLeft.length() - 8);
        else {
            cout << "Item on line " << yylineno << " of type '" << typeLeft << "' is not subscriptable\n";
            exit(1);
        }
    }
    if(typeRight == "objattribute") {
        if(is_not_class(typeLeft)) {
            cout << "'" << typeLeft << "' on line " << yylineno << " is not a class object\n";
            exit(1);
        } 
        string class_name = typeLeft;
        symbol_table_class *if_class = global_table -> look_up_class(class_name);
        if(!if_class) {
            cout << "Class '" << class_name << "' at line " << yylineno << " doesn't exist\n";
            exit(1);
        }
        return (check_attribute_in_class(if_class, attribute_name, current_node, leftnode->var));
    }
    if(typeRight == "functrailer") {
        if(!(leftnode -> is_func)) {
            if(leftnode -> is_class) {
                leftnode -> var = typeLeft + "@__init__";
                quad q0("", to_string(type_to_size[typeLeft]) , "push_param", "");
                q0.make_code_push_param();
                current_node->ta_codes.push_back(q0);    
                string temp = get_new_temp();
                quad q("", "+", "", "");
                q.make_code_shift_pointer();
                current_node->ta_codes.push_back(q);  
                q = quad("", "allocmem", "call", "1");
                q.make_code_from_func_call();
                current_node->ta_codes.push_back(q);  
                q = quad("", "-", "", "");
                q.make_code_shift_pointer();
                current_node->ta_codes.push_back(q);  
                // quad q1(temp, "pop_param", "=", "");
                // q1.make_code_from_assignment();
                quad q1(temp, "", "", "");
                q1.make_code_from_return_val();
                current_node->ta_codes.push_back(q1);

                quad q2("", temp , "push_param", "");
                q2.make_code_push_param();
                current_node->ta_codes.push_back(q2);
                current_node->var = temp;  /// chitwan
                return check_constructor(typeLeft, actual_params, leftnode); 
            }
            else {
                cout << "'" << leftnode->var << "' is not a func or class constructor\n";
                exit(1);
            }
        }
        
        int flag = 0;
        symbol_table_func *func_table = leftnode -> sym_tab_func;
        if(our_debug) {
            cout << "DEBUG " << leftnode->var << endl;
        }
        if(func_table -> name == "print" || func_table -> name == "len" || func_table -> name == "range") {
            symbol_table_func *f = check_predefined_functions(func_table -> name, actual_params);
            leftnode->var = f->mangled_name;
            return f->return_type;
        }
        if(func_table -> parent_st -> symbol_table_category == 'C') {
            flag = 1;
        }
        if(actual_params.size() + flag != (func_table -> params).size()) {
            cout << "Invalid parameters for function call '" << func_table->name << "' at line " << yylineno << endl;
            exit(1);
        }
        for(int i = 0; i < actual_params.size(); i++) {
            is_compatible(actual_params[i], func_table -> params[i + flag]-> type);
        }
        // if(func_table -> return_type == "None"){
        //     current_node->var = 
        // }
        return func_table -> return_type;
    }
    return "UNDEFINED";
}

void check_return_type(string type1) {
    if(current_table -> symbol_table_category != 'M') {
        cout << "Return statement not in method at line " << yylineno << endl;
        exit(1);
    }
    string type2 = ((symbol_table_func *)current_table)->return_type;
    is_compatible(type1, type2);
}

void make_binary_threeac(int n1, int n2, string op, int n3) {
    string arg1 = all_nodes[n1]->var;
    string arg2 = all_nodes[n2]->var;
    all_nodes[n3]->append_tac(all_nodes[n1]);
    arg1 = check_star_and_make(all_nodes[n3], arg1);
    all_nodes[n3]->append_tac(all_nodes[n2]);
    arg2 = check_star_and_make(all_nodes[n3], arg2);
    string res = get_new_temp();
    all_nodes[n3]->var = res;
    quad q(res, arg1, op, arg2);
    q.make_code_from_binary();
    all_nodes[n3]->ta_codes.push_back(q);
}

void make_unary_threeac(int n1, string op, int n2) {
    all_nodes[n2]->append_tac(all_nodes[n1]);
    string res = get_new_temp();
    all_nodes[n2]->var = res;
    string arg1 = all_nodes[n1]->var;
    arg1 = check_star_and_make(all_nodes[n2], arg1);
    quad q(res, arg1, op, "");
    q.make_code_from_unary();
    all_nodes[n2]->ta_codes.push_back(q);
}

void set_var_class_func(int n1, int n2) {
    all_nodes[n1]->is_var = all_nodes[n2]->is_var;
    all_nodes[n1]->is_class = all_nodes[n2]->is_class;
    all_nodes[n1]->is_func = all_nodes[n2]->is_func;
    if(all_nodes[n1]->is_func) all_nodes[n1]->sym_tab_func = all_nodes[n2]->sym_tab_func;
    return ;
}

extern int yylex(void);
void yyerror(const char*);

%}

%define parse.error verbose

%union {
    char* strval;
    int intval;
}

%token<strval> KEY_FALSE KEY_ELSE  KEY_NONE KEY_BREAK KEY_IN KEY_TRUE KEY_CLASS  KEY_RETURN KEY_AND KEY_CONTINUE KEY_FOR KEY_DEF KEY_WHILE KEY_GLOBAL KEY_NOT KEY_ELIF KEY_IF KEY_OR KEY_RANGE OP_ADD OP_SUBTRACT OP_MULTIPLY OP_POWER OP_DIVIDE OP_FLOOR_DIVIDE OP_MODULO OP_LEFT_SHIFT OP_RIGHT_SHIFT OP_BITWISE_AND OP_BITWISE_OR OP_BITWISE_XOR OP_BITWISE_NOT OP_LESS_THAN OP_GREATER_THAN OP_LESS_THAN_EQUAL OP_GREATER_THAN_EQUAL OP_EQUAL OP_NOT_EQUAL DELIM_LEFT_PAREN DELIM_RIGHT_PAREN DELIM_LEFT_BRACKET DELIM_RIGHT_BRACKET DELIM_COMMA DELIM_COLON DELIM_DOT DELIM_SEMICOLON DELIM_ASSIGN DELIM_ARROW DELIM_ASSIGN_ADD DELIM_ASSIGN_SUBTRACT DELIM_ASSIGN_MULTIPLY DELIM_ASSIGN_DIVIDE DELIM_ASSIGN_FLOOR_DIVIDE DELIM_ASSIGN_MODULO DELIM_ASSIGN_BITWISE_AND DELIM_ASSIGN_BITWISE_OR DELIM_ASSIGN_BITWISE_XOR DELIM_ASSIGN_RIGHT_SHIFT DELIM_ASSIGN_LEFT_SHIFT DELIM_ASSIGN_POWER DELIM_ELLIPSIS NAME INDENT DEDENT NEWLINE FLOAT_NUMBER  INTEGER STRING_LITERAL DUNDER_NAME DUNDER_MAIN TYPE_INT TYPE_FLOAT TYPE_STRING TYPE_BOOL TYPE_LIST SELF_DOT

%type<intval> start_symbol single_stmt compound_stmt blocks parameters func_body_suite test typedarglist tfpdef testlist small_stmt expr_stmt flow_stmt global_stmt semicolon_stmt break_stmt continue_stmt return_stmt names classdef if_stmt while_stmt funcdef for_stmt namedexpr_test elif_plus or_test suite stmt_plus and_test not_test comparison expr comp_op xor_expr and_expr shift_expr arith_expr term factor power atom_expr atom argument  number arglist types newline_plus file_input file_plus program_start augassign type_list type_declaration func_header class_header type_or_name trailored_atom

%start start_symbol

%left DELIM_COMMA

%%

start_symbol: file_input {node_attr = {"start_symbol"};  node_numbers = {$1}; insert_node();$$ = node_count; node_count += 1;
    quad q("", "len", "", "");
    q.make_code_begin_func();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("len@list", "", "", "");
    q.make_code_pop_param();
    all_nodes[$$]->ta_codes.push_back(q);
    string temp = get_new_temp();
    q = quad(temp, "len@list", "=", "");
    q.make_code_from_assignment();
    all_nodes[$$]->ta_codes.push_back(q);
    string temp1 = get_new_temp();
    q = quad(temp1, temp, "", "");
    q.make_code_from_load();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("", temp1, "return", "");
    q.make_code_from_return();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("", "", "", "");
    q.make_code_end_func();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

file_input: file_plus {node_attr = {"file_input"};  node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
} 
| newline_plus file_plus {node_attr = {"file_input"}; node_numbers = {$2}; insert_node();  $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$2]);
} 
| newline_plus {node_attr = {"file_input"}; node_numbers = {}; insert_node();  $$ = node_count; node_count += 1;}

file_plus: file_plus blocks {$$ = $1;all_nodes[$$]->add_child(all_nodes[$2]);
    all_nodes[$$]->append_tac(all_nodes[$2]); 
} 
         | blocks {$$ = $1;}

newline_plus: newline_plus NEWLINE {}
            | NEWLINE {}

funcdef: func_header func_body_suite {node_attr = {"funcdef"}; node_numbers = {$1, $2}; insert_node(); $$ = node_count; node_count += 1; 
    vector<st_entry *> temp;
    for(auto entry : current_table->entries) {
        if(!entry->is_global) {
            temp.push_back(entry);
        }
    }
    current_table->entries = temp;
    current_table = current_table->parent_st;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$2]);
    quad q("", "", "", "");
    q.make_code_end_func();
    all_nodes[$$]->ta_codes.push_back(q);
} 

func_header: KEY_DEF NAME parameters DELIM_ARROW test DELIM_COLON {
    node_attr = {"def", string("NAME ( ") + strdup($2) + " )", "->", ":", "func_header"};
    node_numbers = {node_count, node_count + 1, $3, node_count + 2, $5, node_count + 3};
    insert_node();
    $$ = node_count + 4;
    node_count += 5;
    symbol_table_func *newf = make_new_func_symbtab(strdup($2), all_nodes[$3]->entry_list, all_nodes[$5]->datatype);
    quad q("", newf->mangled_name, "", "");
    q.make_code_begin_func();
    all_nodes[$$]->ta_codes.push_back(q);
    for(int i = all_nodes[$3]->entry_list.size()-1;i>=0;i--) {
        auto entry = all_nodes[$3]->entry_list[i];
        if(entry->name == "self") {
            entry -> mangled_name = "self";
        }
        else {
            entry -> mangled_name = newf -> mangled_name + "@" + entry->name;
        }
        quad q1( entry -> mangled_name , "", "", "");
        q1.make_code_pop_param();
        all_nodes[$$]->ta_codes.push_back(q1);
    }
}
| KEY_DEF NAME parameters DELIM_COLON {
    node_attr = {"def", string("NAME ( ") + strdup($2) + " )", ":", "func_header"};
    node_numbers = {node_count, node_count + 1, $3, node_count + 2};
    insert_node();
    $$ = node_count + 3; 
    node_count += 4;
    symbol_table_func *newf = make_new_func_symbtab(strdup($2), all_nodes[$3]->entry_list, "None");
    quad q("", newf -> mangled_name, "", "");
    q.make_code_begin_func();
    all_nodes[$$]->ta_codes.push_back(q);
    for(int i = all_nodes[$3]->entry_list.size()-1;i>=0;i--) {
        auto entry = all_nodes[$3]->entry_list[i];
        if(entry->name == "self") {
            entry -> mangled_name = "self";
        }
        else {
            entry -> mangled_name = newf -> mangled_name + "@" + entry->name;
        }
        quad q1(entry -> mangled_name , "", "", "");
        q1.make_code_pop_param();
        all_nodes[$$]->ta_codes.push_back(q1);
    }
}

parameters: DELIM_LEFT_PAREN typedarglist DELIM_RIGHT_PAREN {
    node_attr = {"(", ")", "parameters"}; node_numbers = {node_count, $2, node_count + 1}; insert_node();
    $$ = node_count + 2;
    node_count += 3;
    all_nodes[$$]->entry_list = all_nodes[$2]->entry_list;
    all_nodes[$$]->append_tac(all_nodes[$2]);
}
| DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {
    node_attr = {"(", ")","parameters"}; 
    node_numbers = {node_count + 0,node_count + 1};
    insert_node();
    $$ = node_count + 2;
    node_count += 3;
}

typedarglist: tfpdef DELIM_COMMA { node_attr = {",", "typedarglist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1;  node_count += 2;
    all_nodes[$$]->entry_list = all_nodes[$1]->entry_list;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| tfpdef { node_attr = {"typedarglist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->entry_list = all_nodes[$1]->entry_list;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| tfpdef DELIM_COMMA typedarglist { node_attr = {",", "typedarglist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->entry_list = all_nodes[$1]->entry_list; 
    all_nodes[$$]->entry_list.insert(all_nodes[$$]->entry_list.end(), all_nodes[$3]->entry_list.begin(), all_nodes[$3]->entry_list.end());
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$3]);
}

tfpdef: NAME DELIM_COLON type_or_name {
    node_attr = {string("NAME ( ") + strdup($1) + " )", ":", "tpdef"};
    node_numbers = {node_count, node_count + 1, $3};
    insert_node();
    $$ = node_count + 2;
    if(string(strdup($1)) == "self") {
        cout << "Invalid type hint for self at " << yylineno << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup($1), yylineno, yylineno, all_nodes[$3]->datatype);
    all_nodes[$$]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = all_nodes[$3]->datatype;
    if(all_nodes[$3]->datatype.length() >= 4 && all_nodes[$3]->datatype.substr(0,4) == "list") {
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
        cout << "Parameter '" << strdup($1) << "' type not given at line " << yylineno << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup($1), yylineno, yylineno, current_table->name);
    all_nodes[$$]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = current_table->name;
    node_count += 2;
} 

blocks: single_stmt {node_attr = {"blocks"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| compound_stmt {node_attr = {"blocks"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

single_stmt: semicolon_stmt newline_plus { node_attr = {"single_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

semicolon_stmt: small_stmt {node_attr = {"semicolon_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| small_stmt DELIM_SEMICOLON {node_attr = {";", "semicolon_stmt"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| small_stmt DELIM_SEMICOLON semicolon_stmt {node_attr = {";", "semicolon_stmt"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$3]);
}

small_stmt: expr_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| flow_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count;  node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| global_stmt {node_attr = {"small_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
        
expr_stmt: type_declaration {node_attr = {"expr_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| type_declaration DELIM_ASSIGN test {node_attr = {"=", "expr_stmt"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    is_compatible(all_nodes[$1]->datatype, all_nodes[$3]->datatype);
    string arg1 = all_nodes[$3]->var;
    arg1 = check_star_and_make(all_nodes[$3], arg1);
    quad q("", "", "", "");
    if((all_nodes[$1]->var)[0] == '*') {
        q = quad((all_nodes[$1]->var).substr(1), arg1, "", "");
        q.make_code_from_store();
    }
    else {
        q = quad (all_nodes[$1]->var, arg1, "=", "");
        q.make_code_from_assignment();
    }
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$3]);
    all_nodes[$$]->ta_codes.push_back(q);
}
| test augassign testlist {node_attr = {"expr_stmt"}; node_numbers = {$1, $2, $3}; insert_node(); $$ = node_count; node_count += 1;
    string op = all_nodes[$2]->name.substr(9);
    if(!all_nodes[$1]->is_var) {
        cout << "Invalid left hand side of assignment at line " << yylineno << endl;
        exit(1);
    }
    if(op[0] == '+' || op[0] == '-' || op[0] == '*' || op[0] == '/') {
        check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, op);
    }
    else {
        check_type_int_bool(all_nodes[$1]->datatype, all_nodes[$3]->datatype, op);
    }
    
    op = op.substr(0, op.size() - 1);
    all_nodes[$$]->append_tac(all_nodes[$1]);
    string arg1 = all_nodes[$1]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    all_nodes[$$]->append_tac(all_nodes[$3]);
    string arg2 = all_nodes[$3]->var_list[0];
    arg2 = check_star_and_make(all_nodes[$$], arg2);
    if((all_nodes[$1] -> var)[0] == '*') {
        string tmp = get_new_temp();
        quad q(tmp, arg1, op, arg2);
        q.make_code_from_binary();
        all_nodes[$$]->ta_codes.push_back(q);
        q = quad((all_nodes[$1] -> var).substr(1), tmp , "", "");
        q.make_code_from_store();
        all_nodes[$$]->ta_codes.push_back(q);
    }
    else{
        quad q(all_nodes[$1] -> var, arg1, op, arg2);
        q.make_code_from_binary();
        all_nodes[$$]->ta_codes.push_back(q);
    }
}
| test DELIM_ASSIGN test {node_attr = {"=","expr_stmt"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    if(!all_nodes[$1]->is_var) {
        cout << "Invalid left hand side of assignment at line " << yylineno << endl;
        exit(1);
    }
    is_compatible(all_nodes[$1]->datatype, all_nodes[$3]->datatype);
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$3]);
    string arg1 = all_nodes[$3]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    quad q("", "", "", "");
    if((all_nodes[$1]->var)[0]=='*') {
        q = quad((all_nodes[$1]->var).substr(1), arg1, "", "");
        q.make_code_from_store();
    }
    else {
        q = quad(all_nodes[$1]->var, arg1, "", "");
        q.make_code_from_assignment();
    }
    all_nodes[$$]->ta_codes.push_back(q);
}
| test {node_attr = {"expr_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

type_declaration: NAME DELIM_COLON type_or_name {
    node_attr = {string("NAME ( ") + strdup($1) + " )", ":", "type_declaration"};
    node_numbers = {node_count, node_count + 1, $3};
    insert_node(); 
    $$ = node_count + 2;
    st_entry *entry = current_table -> look_up_local(strdup($1));
    if(entry) {
        cout << "'" << strdup($1) << "' already declared at line" << entry->line_no << endl;
        exit(1);
    }
    if(current_table->symbol_table_category == 'M') {
        if(current_table->name == strdup($1)) {
            cout << "Illegal declaration of '" << strdup($1) << "' at line " << yylineno << "\n";
        }
    }
    else if(current_table->symbol_table_category == 'G') {
        string var_name = strdup($1);
        symbol_table_func* fnc =  global_table->look_up_func(var_name);
        symbol_table_class* cl =  global_table->look_up_class(var_name);
        if(fnc || cl) { 
            cout << "'" << strdup($1) << "' already declared as " << (fnc ? "function" : "") << (cl ? "class" : "") << endl;
            exit(1);
        }
    }
    
    st_entry *new_entry = new st_entry(strdup($1), yylineno, yylineno, all_nodes[$3]->datatype);
    if(current_table -> symbol_table_category == 'M') {
        new_entry ->mangled_name = ((symbol_table_func *)current_table) -> mangled_name + "@" + strdup($1);
    }
    else {
        new_entry -> mangled_name = strdup($1);
    }
    all_nodes[node_count]->datatype = all_nodes[$3]->datatype;
    if(all_nodes[$3]->datatype.length() >= 4 && all_nodes[$3]->datatype.substr(0,4) == "list") {
        new_entry->dimensions = 1;
    }
    new_entry -> table = current_table;
    current_table -> add_entry(new_entry);
    node_count += 3;
    all_nodes[$$]->datatype = all_nodes[$3]->datatype;
    
    /* shrey - Declaration of variable is done by mangled name rather than only lexeme */
    // all_nodes[$$] -> var = strdup($1);
    all_nodes[$$] -> var = new_entry -> mangled_name;
    if(current_table->symbol_table_category == 'C') {
        new_entry -> offset = ((symbol_table_class *)(current_table->parent_st))->object_size;
        bool is_class = !is_not_class(all_nodes[$3]->datatype);
        if(!is_class) ((symbol_table_class *)(current_table->parent_st))->object_size += type_to_size[all_nodes[$3]->datatype];
        else ((symbol_table_class *)(current_table->parent_st))->object_size += 8;
    }
    all_nodes[$$]->sym_tab_entry = new_entry;
}
| SELF_DOT NAME DELIM_COLON type_or_name {
    node_attr = {"self.", string("NAME ( ")+ strdup($2) + " )", ":", "type_declaration"};
    node_numbers = {node_count, node_count + 1, node_count + 2, $4};
    if(current_table->symbol_table_category != 'M' || !(current_table->parent_st) || current_table->parent_st->symbol_table_category != 'C') {
        cout << "Invalid Declaration at line " << yylineno << ". Identifiers can only have letters, digits or _\n";
        exit(1);
    }
    insert_node();
    $$ = node_count + 3;
    st_entry *entry = current_table -> parent_st -> look_up_local(strdup($2));
    if(entry) {
        cout << "'" << strdup($2) << "' attribute already declared at line " << entry->line_no << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup($2), yylineno, yylineno, all_nodes[$4]->datatype);
    all_nodes[node_count]->datatype = all_nodes[$4]->datatype;
    if(all_nodes[$4]->datatype.length() >= 4 && all_nodes[$4]->datatype.substr(0,4) == "list") {
        new_entry->dimensions = 1;
    }
    new_entry -> table = current_table -> parent_st;
    current_table -> parent_st -> add_entry(new_entry);
    node_count += 4;
    all_nodes[$$]->datatype = all_nodes[$4]->datatype;
    all_nodes[$$]->var = string("*( self + ") + to_string(((symbol_table_class *)(current_table->parent_st))->object_size) + " )";

    /*  chitwan  -- 3ac minor correctness assign *(self + offt) to some temporary first */
    string tmp = get_new_temp();
    quad q(tmp, "self" , "+", to_string(((symbol_table_class *)(current_table->parent_st))->object_size));
    q.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->var = "*" + tmp;
    /* chitwan --*/
    new_entry -> offset = ((symbol_table_class *)(current_table->parent_st))->object_size;
    bool is_class = !is_not_class(all_nodes[$4]->datatype);
    if(!is_class) ((symbol_table_class *)(current_table->parent_st))->object_size += type_to_size[all_nodes[$4]->datatype];
    else ((symbol_table_class *)(current_table->parent_st))->object_size += 8;
    all_nodes[$$]->sym_tab_entry = new_entry;
}

augassign: DELIM_ASSIGN_ADD {node_attr = {"+=", "augassign+="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_SUBTRACT {node_attr = {"-=", "augassign-="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_MULTIPLY { node_attr = {"*=", "augassign*="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_DIVIDE {node_attr = {"/=", "augassign/="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_MODULO {node_attr = {"%=", "augassign%="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_BITWISE_AND {node_attr = {"&=", "augassign&="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_BITWISE_OR {node_attr = {"|=", "augassign|="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_BITWISE_XOR {node_attr = {"^=", "augassign^="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_LEFT_SHIFT {node_attr = {"<<=", "augassign<<="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_RIGHT_SHIFT {node_attr = {">>=", "augassign>>="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_POWER {node_attr = {"**=", "augassign**="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
         | DELIM_ASSIGN_FLOOR_DIVIDE {node_attr = {"//=", "augassign//="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

flow_stmt: break_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| continue_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| return_stmt {node_attr = {"flow_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

break_stmt: KEY_BREAK {node_attr = {"break", "break_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2; 
    if(in_loop <= 0) {
        cout << "Use of break statement outside of for or while loop on line " << yylineno << endl;
        exit(1);
    }
    quad q("", "goto", "BREAK", "");
    q.code = "\t\tgoto BREAK;\n";
    q.made_from = quad::GOTO;
    all_nodes[$$]->ta_codes.push_back(q);
}

continue_stmt: KEY_CONTINUE {node_attr = {"continue", "continue_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;
    if(in_loop <= 0) {
        cout << "Use of continue statement outside of for or while loop on line " << yylineno << endl;
        exit(1);
    }
    quad q("", "goto", "CONTINUE", "");
    q.code = "\t\tgoto CONTINUE;\n";
    q.made_from = quad::GOTO;
    all_nodes[$$]->ta_codes.push_back(q);
}

return_stmt: KEY_RETURN test {node_attr = {"return", "return_stmt"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1;
    node_count += 2;
    check_return_type(all_nodes[$2]->datatype);
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    // quad q("", arg1, "push", "");
    // q.make_code_push_param();
    // all_nodes[$$]->ta_codes.push_back(q);
    quad q("", arg1, "return", "");
    q.make_code_from_return();
    all_nodes[$$]->ta_codes.push_back(q);
}
| KEY_RETURN {node_attr = {"return", "return_stmt"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1;
    node_count += 2;
    check_return_type("None");
    quad q("", "", "return", "");
    q.make_code_from_return();
    all_nodes[$$]->ta_codes.push_back(q);
}

global_stmt: KEY_GLOBAL names {node_attr = {"global", "global_stmt"}; node_numbers = {node_count, $2};  insert_node(); $$ = node_count + 1; node_count += 2;
    if(current_table -> symbol_table_category == 'M'){
        for(auto entry : all_nodes[$2]->entry_list){
            st_entry *existing_entry = current_table -> look_up_local(entry -> name);
            if(existing_entry) {
                cout << "'" << entry -> name << "' already declared at line " << existing_entry -> line_no << endl;
                exit(1);
            }
            current_table -> add_entry(entry);
        }
        
    }
    else{
        cout << "Stray global statement at line " << yylineno << "\n";
        exit(1);
    }
}

names: NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "names"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; 
    st_entry *entry = global_table -> look_up_local(strdup($1));
    if(!entry) {
        cout << "'" << strdup($1) << "' not a global variable ( at line number " << yylineno << " )\n";
        exit(1);
    }
    all_nodes[$$]->entry_list = {entry};
    all_nodes[node_count]->datatype = entry -> type;
    node_count += 2;
}
| NAME DELIM_COMMA names {node_attr = {"NAME", ",", "names"}; node_numbers = {node_count+0,node_count + 1, $3}; insert_node(); $$ = node_count + 2; 
    st_entry *entry = global_table -> look_up_local(strdup($1));
    if(!entry) {
        cout << "'" << strdup($1) << "' not a global variable at line number " << yylineno << endl;
        exit(1);
    }
    all_nodes[$$]->entry_list = all_nodes[$3]->entry_list;
    all_nodes[node_count]->datatype = entry -> type;
    all_nodes[$$]->entry_list.push_back(entry);
    node_count += 3;
}

compound_stmt: if_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| while_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| for_stmt {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| funcdef {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| classdef {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| program_start {node_attr = {"compound_stmt"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

program_start: KEY_IF DUNDER_NAME OP_EQUAL DUNDER_MAIN DELIM_COLON suite {node_attr = {"if", "__name__", "==", "__main__", ":", "program_start"}; node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4, $6}; insert_node(); $$ = node_count + 5;
    node_count += 6;
    quad q("", "", "", "");
    q.code = "program start: \n";
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$6]);
}

if_stmt: KEY_IF namedexpr_test DELIM_COLON suite {node_attr = {"if",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4}; insert_node(); $$ = node_count + 2;
    node_count += 3;
    is_compatible(all_nodes[$2]->datatype, "bool");
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    string arg2 = "J+" + to_string(all_nodes[$4]->ta_codes.size() + 1);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$4]);
}

| KEY_IF namedexpr_test DELIM_COLON suite elif_plus {node_attr = {"if",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, $5}; insert_node(); $$ = node_count + 2;
    node_count += 3;
    is_compatible(all_nodes[$2]->datatype, "bool");
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    string arg2 = "J+" + to_string(all_nodes[$4]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$4]);
    
    // arg1 = a
    op = "goto";
    arg1 = "J+" + to_string(all_nodes[$5]->ta_codes.size() + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[$$]->ta_codes.push_back(q2);
    all_nodes[$$]->append_tac(all_nodes[$5]);
}

| KEY_IF namedexpr_test DELIM_COLON suite KEY_ELSE DELIM_COLON suite {node_attr = {"if",":","else",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, node_count+2, node_count + 3, $7}; insert_node(); $$ = node_count + 4;
    node_count += 5;
    is_compatible(all_nodes[$2]->datatype, "bool");
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    string arg2 = "J+" + to_string(all_nodes[$4]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$4]);

    op = "goto";
    arg1 = "J+" + to_string(all_nodes[$7]->ta_codes.size() + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[$$]->ta_codes.push_back(q2);
    all_nodes[$$]->append_tac(all_nodes[$7]);
}

| KEY_IF namedexpr_test DELIM_COLON suite elif_plus KEY_ELSE DELIM_COLON suite {node_attr = {"if",":","else",":","if_stmt"}; node_numbers = {node_count, $2, node_count+1, $4, $5, node_count+2, node_count + 3, $8}; insert_node(); $$ = node_count + 4;
    node_count += 5;
    is_compatible(all_nodes[$2]->datatype, "bool");
    
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    string arg2 = "J+" + to_string(all_nodes[$4]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$4]);
    
    // arg1 = a
    op = "goto";
    arg1 = "J+" + to_string(all_nodes[$5]->ta_codes.size() + all_nodes[$8]->ta_codes.size() + 2);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[$$]->ta_codes.push_back(q2);
    /* chitwan */
    for(auto &qu: all_nodes[$5]->ta_codes) {
        if(qu.op == "goto") { 
            qu.rel_jump += all_nodes[$8]->ta_codes.size() + 1;
        }
    }
    /* chitwan */
    all_nodes[$$]->append_tac(all_nodes[$5]);
    arg1 = "J+" + to_string(all_nodes[$8]->ta_codes.size() + 1);
    q2 =  quad("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[$$]->ta_codes.push_back(q2);
    all_nodes[$$]->append_tac(all_nodes[$8]);
}

elif_plus: KEY_ELIF namedexpr_test DELIM_COLON suite {node_attr = {"elif",":","elif_plus"}; node_numbers = {node_count, $2, node_count+1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;
    is_compatible(all_nodes[$2]->datatype, "bool");
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    string arg2 = "J+" + to_string(all_nodes[$4]->ta_codes.size() + 1);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$4]);
}

| KEY_ELIF namedexpr_test DELIM_COLON suite elif_plus {node_attr = {"elif",":","elif_plus"}; node_numbers = {node_count, $2, node_count+1, $4, $5}; insert_node(); $$ = node_count + 2; node_count += 3;
    is_compatible(all_nodes[$2]->datatype, "bool");
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg1 = all_nodes[$2]->var;
    arg1 = check_star_and_make(all_nodes[$$], arg1);
    string arg2 = "J+" + to_string(all_nodes[$4]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$4]);
    // arg1 = a
    op = "goto";
    arg1 = "J+" + to_string(all_nodes[$5]->ta_codes.size() + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[$$]->ta_codes.push_back(q2);
    all_nodes[$$]->append_tac(all_nodes[$5]);
}

while_stmt: KEY_WHILE namedexpr_test DELIM_COLON suite {node_attr = {"while",":","while_stmt"}; node_numbers = {node_count, $2, node_count+1, $4}; insert_node(); $$ = node_count + 2; node_count += 3;
    is_compatible(all_nodes[$2]->datatype, "bool");
    int exp_size = all_nodes[$2]->ta_codes.size();
    int stat_size = all_nodes[$4]->ta_codes.size();
    string arg1 = all_nodes[$2]->var;
    arg1  = check_star_and_make(all_nodes[$2], arg1);
    all_nodes[$$] -> append_tac(all_nodes[$2]);
    string op = "if_false";
    string arg2 = "J+" + to_string(stat_size + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[$$] -> ta_codes.push_back(q);
    while_break_continue($4, $$);
    all_nodes[$$] -> append_tac(all_nodes[$4]);
    op = "goto";
    arg1 = "J-" + to_string(stat_size + exp_size + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[$$] -> ta_codes.push_back(q2);
    in_loop--;
}

for_stmt: KEY_FOR expr KEY_IN KEY_RANGE DELIM_LEFT_PAREN test DELIM_RIGHT_PAREN DELIM_COLON suite {node_attr = {"for","in", "range", "(", ")", ":","for_stmt"}; node_numbers = {node_count, $2, node_count+1, node_count + 2, node_count + 3, $6, node_count + 4 ,node_count + 5, $9}; insert_node(); $$ = node_count + 6;
    node_count += 7;
    if(all_nodes[$2]->datatype != "int") {        
        cout << "for loop ending at line " << yylineno << " has invalid iterator type\n";
        exit(1);
    }
    if(all_nodes[$6]->datatype != "int") {
        cout << "for loop ending at line " << yylineno << " has invalid argument for range\n";
        exit(1);
    }
    string narg1 = all_nodes[$2]->var;
    //narg1 = check_star_and_make(all_nodes[$2], narg1);
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string narg2 = all_nodes[$6]->var;
    narg2 = check_star_and_make(all_nodes[$6], narg2);
    all_nodes[$$]->append_tac(all_nodes[$6]);
    quad q(narg1, "0", "=", "");
    q.make_code_from_assignment();
    all_nodes[$$]->ta_codes.push_back(q);
    string tmp_var = get_new_temp();
    quad q1(tmp_var, narg1, "<", narg2);
    q1.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q1);
    string op = "if_false";
    string arg1 = tmp_var;
    string arg2 = "J+" + to_string(all_nodes[$9]->ta_codes.size() + 3);
    quad q2("", arg1, op, arg2);
    q2.make_code_from_conditional();
    all_nodes[$$] -> ta_codes.push_back(q2);
    for_break_continue($9, $$);
    op = "goto";
    arg1 = "J-" + to_string(all_nodes[$9]->ta_codes.size() + 3);   // chitwan -- yha size+4 ki jgh 3 hoga as per examples check this once by running public1.py
    all_nodes[$$] -> append_tac(all_nodes[$9]);
    quad q4(narg1, narg1, "+", "1");
    q4.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q4);
    quad q3("", arg1, op, "");
    q3.make_code_from_goto();
    all_nodes[$$] -> ta_codes.push_back(q3);
    in_loop--;
}

| KEY_FOR expr KEY_IN KEY_RANGE DELIM_LEFT_PAREN test DELIM_COMMA test DELIM_RIGHT_PAREN DELIM_COLON suite {node_attr = {"for","in", "range", "(" , ",", ")", ":","for_stmt"}; node_numbers = {node_count, $2, node_count+1, node_count + 2, node_count + 3, $6, node_count+4, $8, node_count + 5, node_count + 6, $11}; insert_node(); $$ = node_count + 7;
    node_count += 8;
    if(all_nodes[$2]->datatype != "int") { 
        cout << "for loop ending at line " << yylineno << " has invalid iterator type\n";
        exit(1);
    }
    if(all_nodes[$6]->datatype != "int" || all_nodes[$8]->datatype != "int") {
        cout << "for loop ending at line " << yylineno << " has invalid argument(s) for range\n";
        exit(1);
    }
    all_nodes[$$]->append_tac(all_nodes[$2]);
    string narg1 = all_nodes[$6]->var;
    narg1 = check_star_and_make(all_nodes[$6], narg1);
    all_nodes[$$]->append_tac(all_nodes[$6]);
    string narg2 = all_nodes[$8]->var;
    narg2 = check_star_and_make(all_nodes[$8], narg2);
    all_nodes[$$]->append_tac(all_nodes[$8]);
    quad q(all_nodes[$2]->var, narg1, "=", "");
    q.make_code_from_assignment();
    all_nodes[$$]->ta_codes.push_back(q);
    string temp_var = get_new_temp();
    quad q1(temp_var, all_nodes[$2]->var, "<", narg2);
    q1.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q1);
    string op = "if_false";
    string arg1 = temp_var;
    /* shrey - Incorrect jump in for loop, change: size() + 2 -> size() + 3 */
    string arg2 = "J+" + to_string(all_nodes[$11]->ta_codes.size() + 3);
    quad q2("", arg1, op, arg2);
    q2.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q2);
    for_break_continue($11, $$);
    /* shrey - Fixed order of code. Made it same as above */
    op = "goto";
    arg1 = "J-" + to_string(all_nodes[$11]->ta_codes.size() + 3);   // shrey -- yha size+4 ki jgh 3 hoga as per examples check this once by running test.py
    all_nodes[$$] -> append_tac(all_nodes[$11]);
    quad q4(all_nodes[$2]->var, all_nodes[$2]->var, "+", "1");
    q4.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q4);
    quad q3("", arg1, op, "");
    q3.make_code_from_goto();
    all_nodes[$$] -> ta_codes.push_back(q3);
    in_loop--;
}

stmt_plus : blocks {$$ = $1;}
| stmt_plus blocks {$$ = $1; all_nodes[$$]->add_child(all_nodes[$2]);
    all_nodes[$$]->append_tac(all_nodes[$2]);
}

suite: single_stmt {node_attr = {"suite"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| newline_plus INDENT stmt_plus DEDENT {node_attr = {"suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$3]);
}
| newline_plus INDENT stmt_plus DEDENT newline_plus{node_attr = {"suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$3]);
}

namedexpr_test: test {node_attr = {"namedexpr_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
}

test: or_test {node_attr = {"test"}; node_numbers = {$1}; insert_node(); $$ = node_count;
    node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    set_var_class_func($$, $1);
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    
}

or_test: and_test {node_attr = {"or_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; 
    node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    set_var_class_func($$, $1);
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
}
| and_test KEY_OR or_test {node_attr = {"or", "or_test"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; 
    node_count += 2;
    is_compatible(all_nodes[$1]->datatype, "bool");
    is_compatible(all_nodes[$3]->datatype, "bool");
    all_nodes[$$]->datatype = "bool";
    make_binary_threeac($1, $3, "||", $$);
}

and_test: not_test {node_attr = {"and_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1; all_nodes[$$] -> datatype = all_nodes[$1]->datatype;
    set_var_class_func($$, $1);
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
}
| not_test KEY_AND and_test {node_attr = {"and", "and_test"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; 
    node_count += 2;
    is_compatible(all_nodes[$1]->datatype, "bool");
    is_compatible(all_nodes[$3]->datatype, "bool");
    all_nodes[$$]->datatype = "bool";
    make_binary_threeac($1, $3, "&&", $$);
}

not_test: KEY_NOT not_test {node_attr = {"not", "not_test"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;
    is_compatible(all_nodes[$2]->datatype, "bool");
    all_nodes[$$]->datatype = all_nodes[$2]->datatype;
    make_unary_threeac($2, "!", $$);
}

| comparison {node_attr = {"not_test"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
        
comparison: expr {node_attr = {"comparison"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$] -> datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| expr comp_op comparison {node_attr = {"comparison"}; node_numbers = {$1, $2, $3}; insert_node(); $$ = node_count + 0;
    node_count += 1;
    string op = all_nodes[$2]->name.substr(7);
    if(op == "in" || op == "not_in") {
        if(all_nodes[$1]->datatype != all_nodes[$3]->datatype.substr(6, all_nodes[$3]->datatype.size() - 8)) {
            cout << "Type Error at line " << yylineno << endl;
            exit(1);
        }
    }
    else {
        is_compatible(all_nodes[$1]->datatype, all_nodes[$3]->datatype, true);
    }
    all_nodes[$$]->datatype = "bool";
    if(all_nodes[$1]->datatype == "str") {   
        string arg1 = all_nodes[$1]->var;
        arg1 = check_star_and_make(all_nodes[$1], arg1);
        all_nodes[$$]->append_tac(all_nodes[$1]);
        string arg2 = all_nodes[$3]->var;
        arg2 = check_star_and_make(all_nodes[$3], arg2);
        all_nodes[$$]->append_tac(all_nodes[$3]);
        quad q("", arg1, "push_param", "");
        q.make_code_push_param();
        all_nodes[$$]->ta_codes.push_back(q);
        q = quad("", arg2, "push_param", "");
        q.make_code_push_param();
        all_nodes[$$]->ta_codes.push_back(q);
        q = quad("", "+", "", "");
        q.make_code_shift_pointer();
        all_nodes[$$]->ta_codes.push_back(q);
        q = quad("", "strcmp1", "call", "2");
        q.make_code_from_func_call();
        all_nodes[$$]->ta_codes.push_back(q);
        q = quad("", "-", "", "");
        q.make_code_shift_pointer();
        all_nodes[$$]->ta_codes.push_back(q);  
        string temp = get_new_temp();
        // q = quad(temp, "pop_param", "=", "");
        // q.make_code_from_assignment();
        q = quad(temp, "", "", "");
        q.make_code_from_return_val();
        all_nodes[$$]->ta_codes.push_back(q);
        all_nodes[$$]->var = get_new_temp();
        q = quad(all_nodes[$$]->var, temp, op, "0");
        q.make_code_from_binary();
        all_nodes[$$]->ta_codes.push_back(q);
    }
    else { 
        make_binary_threeac($1, $3, op , $$);
    }
}

comp_op: OP_LESS_THAN {node_attr = {"<", "comp_op<"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_GREATER_THAN {node_attr = {">", "comp_op>"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_EQUAL {node_attr = {"==", "comp_op=="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_GREATER_THAN_EQUAL {node_attr = {">=", "comp_op>="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_LESS_THAN_EQUAL {node_attr = {"<=", "comp_op<="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | OP_NOT_EQUAL {node_attr = {"!=", "comp_op!="}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | KEY_IN {node_attr = {"in", "comp_opin"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}
       | KEY_NOT KEY_IN {node_attr = {"not", "in", "comp_opnot_in"}; node_numbers = {node_count, node_count + 1}; insert_node(); $$ = node_count + 2; node_count += 3;}

expr: xor_expr {node_attr = {"expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| expr OP_BITWISE_OR xor_expr {node_attr = {"|", "expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2; 
    check_type_int_bool(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    all_nodes[$$]->datatype = "int";
    make_binary_threeac($1, $3, "|", $$);
    
}

xor_expr: and_expr {node_attr = {"xor_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| xor_expr OP_BITWISE_XOR and_expr {node_attr = {"^", "xor_expr"}; node_numbers = {$1, node_count + 0, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    all_nodes[$$]->datatype = "int";
    make_binary_threeac($1, $3, "^", $$);
}

and_expr: shift_expr {node_attr = {"and_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| and_expr OP_BITWISE_AND shift_expr {node_attr = {"&", "and_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    all_nodes[$$]->datatype = "int";
    make_binary_threeac($1, $3, "&", $$);
}
        
shift_expr: arith_expr {node_attr = {"shift_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| shift_expr OP_LEFT_SHIFT arith_expr {node_attr = {"<<", "shift_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    all_nodes[$$]->datatype = "int";
    make_binary_threeac($1, $3, "<<", $$);
}
| shift_expr OP_RIGHT_SHIFT arith_expr {node_attr = {">>", "shift_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    all_nodes[$$]->datatype = "int";
    make_binary_threeac($1, $3, ">>", $$);
    
}

arith_expr: term {node_attr = {"arith_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| arith_expr OP_ADD term {node_attr = {"+", "arith_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    
    make_binary_threeac($1, $3, "+", $$);
    
}
| arith_expr OP_SUBTRACT term {node_attr = {"-", "arith_expr"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    
    make_binary_threeac($1, $3, "-", $$);
}

term: factor {node_attr = {"term"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}
| term OP_MULTIPLY factor {node_attr = {"*", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    make_binary_threeac($1, $3, "*", $$);
}
| term OP_DIVIDE factor {node_attr = {"/", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    make_binary_threeac($1, $3, "/", $$);
}
| term OP_MODULO factor {node_attr = {"%", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    make_binary_threeac($1, $3, "%", $$);
}
| term OP_FLOOR_DIVIDE factor {node_attr = {"//", "term"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    all_nodes[$$]->datatype = "int";
    make_binary_threeac($1, $3, "//", $$);
}

factor: OP_BITWISE_NOT factor {node_attr = {"~", "factor"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;
    if(all_nodes[$2]->datatype != "int" && all_nodes[$2]->datatype != "bool") {
        cout << "Bitwise not at line " << yylineno << ". Operand should be compatible to integer\n";
        exit(1);
    }
    all_nodes[$$]->datatype = "int";
    make_unary_threeac($2, "~", $$);
}

| OP_ADD factor {node_attr = {"+", "factor"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;
    is_compatible(all_nodes[$2]->datatype, "int");
    all_nodes[$$]->datatype = (all_nodes[$2]->datatype == "float" ? "float":"int");
    make_unary_threeac($2, "+", $$);
}

| OP_SUBTRACT factor {node_attr = {"-", "factor"}; node_numbers = {node_count, $2}; insert_node(); $$ = node_count + 1; node_count += 2;
    is_compatible(all_nodes[$2]->datatype, "int");
    all_nodes[$$]->datatype = (all_nodes[$2]->datatype == "float" ? "float":"int");
    make_unary_threeac($2, "-", $$);
}

| power {node_attr = {"factor"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$] -> datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}

power: atom_expr {node_attr = {"power"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$] -> datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}

| atom_expr OP_POWER factor {node_attr = {"**", "power"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->datatype = check_type_arith(all_nodes[$1]->datatype, all_nodes[$3]->datatype, strdup($2));
    make_binary_threeac($1, $3, "**", $$);
}
    
atom_expr: atom { node_attr = {"atom_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}

| trailored_atom { node_attr = {"atom_expr"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->var = all_nodes[$1]->var;
    set_var_class_func($$, $1);
}

trailored_atom: atom DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {$1, node_count, $3, node_count + 1}; insert_node(); $$ = node_count + 2;
    all_nodes[$$]->append_tac(all_nodes[$1]);  // chitwan -- missing tha ye
    all_nodes[$$]->append_tac(all_nodes[$3]);
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1], all_nodes[$1]->datatype, "functrailer", "", all_nodes[$3]->type_list);
    node_count += 3;
    if(all_nodes[$1]->var == "print_str") {
        string arg1 = check_star_and_make(all_nodes[$$], all_nodes[$3]->var_list[0]);
        quad q("", arg1, "", "");
        q.make_code_from_print_str();
        all_nodes[$$]->ta_codes.push_back(q);
    }
    else {
        if(all_nodes[$1]->is_class_func != ""){
            string b = all_nodes[$1]->is_class_func;
            b = check_star_and_make(all_nodes[$$], b);
            quad q0("", b , "push_param", "");
            q0.make_code_push_param();
            all_nodes[$$]->ta_codes.push_back(q0);
        }
        for(int i=0;i<all_nodes[$3]->var_list.size();i++) {
            string arg1 = all_nodes[$3]->var_list[i];
            arg1 = check_star_and_make(all_nodes[$$], arg1);
            quad q("", arg1, "push_param", "");
            q.make_code_push_param();
            all_nodes[$$]->ta_codes.push_back(q);
        }
        int num_params = 0;
        if(all_nodes[$1]->sym_tab_func) {
            num_params = all_nodes[$1]->sym_tab_func->params.size();
        }
        quad q("", "+", "", "");
        q.make_code_shift_pointer();
        all_nodes[$$]->ta_codes.push_back(q);
        if(all_nodes[$1]->var == "print_int" || all_nodes[$1]->var == "print_bol" || all_nodes[$1]->var == "print_flt") {
            all_nodes[$1]->var = "print";
        }
        
        q = quad("", all_nodes[$1]->var, "call", to_string(num_params));
        q.make_code_from_func_call();
        all_nodes[$$]->ta_codes.push_back(q);
        q = quad("", "-", "", "");
        q.make_code_shift_pointer();
        all_nodes[$$]->ta_codes.push_back(q);  
        if(all_nodes[$$]->datatype == "None" || all_nodes[$1]->is_class) {
            quad q("", "", "", "");
            q.make_code_from_none_return_val();
            all_nodes[$$]->ta_codes.push_back(q);
        }
        else {
            string temp = get_new_temp();
            quad q1(temp, "", "", "");
            q1.make_code_from_return_val();
            all_nodes[$$]->ta_codes.push_back(q1);
            all_nodes[$$]->var = temp;
        }
    }
}

| atom DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {$1, node_count, node_count + 1}; insert_node(); $$ = node_count + 2; 
    all_nodes[$$]->append_tac(all_nodes[$1]); // chitwan -- ye missing tha
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "functrailer");
    node_count += 3;
    if(all_nodes[$1]->is_class_func != ""){
        string b = all_nodes[$1]->is_class_func;
        b = check_star_and_make(all_nodes[$$], b);
        quad q0("", b , "push_param", "");
        q0.make_code_push_param();
        all_nodes[$$]->ta_codes.push_back(q0);
    }
    int num_params = 0;
    if(all_nodes[$1]->sym_tab_func) {
        num_params = all_nodes[$1]->sym_tab_func->params.size();
    }
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    q = quad("", all_nodes[$1]->var, "call", to_string(num_params));
    q.make_code_from_func_call();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    if(all_nodes[$$]->datatype == "None" || all_nodes[$1]->is_class) {
        quad q("", "", "", "");
        q.make_code_from_none_return_val();
        all_nodes[$$]->ta_codes.push_back(q);
        all_nodes[$$]->var = "__t" + to_string(temp_count - 1);
    }
    else{
        string temp = get_new_temp();
        quad q1(temp, "", "", "");
        q1.make_code_from_return_val();
        all_nodes[$$]->ta_codes.push_back(q1);
        all_nodes[$$]->var = temp;
    }
}

| atom DELIM_LEFT_BRACKET test DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "trailored_atom"}; node_numbers = {$1, node_count, $3, node_count + 1}; insert_node(); $$ = node_count + 2;
    if(all_nodes[$3]->datatype != "int") {
        cout << "Type mismatch at line " << yylineno << ". List index should be an integer\n";
        exit(1);
    }
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "list_subs");
    node_count += 3;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    string temp = get_new_temp();
    string narg1 = all_nodes[$1]->var;
    narg1 = check_star_and_make(all_nodes[$$], narg1);
    quad q(temp, narg1, "=", "");
    q.make_code_from_assignment();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$3]);
    string narg2 = all_nodes[$3]->var;
    narg2 = check_star_and_make(all_nodes[$$], narg2);
    string temp1 = get_new_temp();
    quad q1(temp1, temp, "", "");
    q1.make_code_from_load();
    all_nodes[$$]->ta_codes.push_back(q1);
    string temp2 = get_new_temp();
    quad q2(temp2, narg2, ">=", temp1);   // chitwan -- pehle ye >= ki jgh < tha
    q2.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q2);
    
    string op = "if_false";
    string arg2 = "J+2";
    quad q3("", temp2, op, arg2);
    q3.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q3);
    quad q4("", "", "", "");
    q4.code = "\t\texit_out_of_bound\n";
    q4.made_from = quad::EXIT;
    all_nodes[$$]->ta_codes.push_back(q4);
    // temp is the base address excluding size; temp1 is useless at this point
    string type = all_nodes[$1]->datatype.substr(6, all_nodes[$1]->datatype.size() - 8);
    int size = type_to_size[type];
    if(!is_not_class(type)) {
        size = 8;
    }
    quad q5(temp1, narg2 , "*", to_string(size));   // [4i] => 4*i
    q5.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q5);
    quad q6(temp1, temp1 , "+", "8");  // bypassing the size thing   + 8
    q6.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q6);  
    quad q7(temp1, temp , "+", temp1);   // base + 8 + 4 * i
    q7.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q7);
    string t = get_new_temp();
    /* shrey - Changing temp for a[i] */
    all_nodes[$$]->var = "*" + temp1;
    all_nodes[$$]->is_var = true;
}

| atom DELIM_DOT NAME {node_attr = {".", string("NAME ( ") + strdup($2) + " )", "trailored_atom"}; node_numbers = {$1, node_count, node_count + 1}; insert_node(); $$ = node_count + 2;
    all_nodes[$$]->append_tac(all_nodes[$1]);   // chitwan -- 
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "objattribute", strdup($3));
    node_count += 3;
    // done in set trailer type
}
| trailored_atom DELIM_LEFT_PAREN arglist DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {$1, node_count, $3, node_count + 1}; insert_node(); $$ = node_count + 2;
    all_nodes[$$]->append_tac(all_nodes[$1]); // chitwan -- ye missing tha
    all_nodes[$$]->append_tac(all_nodes[$3]);
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "functrailer", "", all_nodes[$3]->type_list);
    node_count += 3;
    if(all_nodes[$1]->is_class_func != ""){
        string b = all_nodes[$1]->is_class_func;
        b = check_star_and_make(all_nodes[$$], b);
        quad q0("", b , "push_param", "");
        q0.make_code_push_param();
        all_nodes[$$]->ta_codes.push_back(q0);
    }
    for(int i=0;i<all_nodes[$3]->var_list.size();i++){
    // for(int i=all_nodes[$3]->var_list.size()-1;i>=0;i--){
        string arg1 = all_nodes[$3]->var_list[i];
        arg1  = check_star_and_make(all_nodes[$$], arg1);
        quad q("", arg1, "push_param", "");
        q.make_code_push_param();
        all_nodes[$$]->ta_codes.push_back(q);
    }
    int num_params = 0;
    if(all_nodes[$1]->sym_tab_func) {
        num_params = all_nodes[$1]->sym_tab_func->params.size();
    }
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    q = quad("", all_nodes[$1]->var, "call", to_string(num_params));
    q.make_code_from_func_call();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    if(all_nodes[$$]->datatype == "None" || all_nodes[$1]->is_class) {
        quad q("", "", "", "");
        q.make_code_from_none_return_val();
        all_nodes[$$]->ta_codes.push_back(q);
    }
    else{
        string temp = get_new_temp();
        quad q1(temp, "", "", "");
        q1.make_code_from_return_val();
        all_nodes[$$]->ta_codes.push_back(q1);
        all_nodes[$$]->var = temp;
    }
}
| trailored_atom DELIM_LEFT_PAREN DELIM_RIGHT_PAREN {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {$1, node_count, node_count+1}; insert_node(); $$ = node_count + 2;
    all_nodes[$$]->append_tac(all_nodes[$1]); // chitwan -- ye missing tha
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "functrailer");
    node_count += 3;
    if(all_nodes[$1]->is_class_func != ""){
        string b = all_nodes[$1]->is_class_func;
        b = check_star_and_make(all_nodes[$$], b);
        quad q0("", b , "push_param", "");
        q0.make_code_push_param();
        all_nodes[$$]->ta_codes.push_back(q0);
    }
    int num_params = 0;
    if(all_nodes[$1]->sym_tab_func) {
        num_params = all_nodes[$1]->sym_tab_func->params.size();
    }
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    q = quad("", all_nodes[$1]->var, "call", to_string(num_params));
    q.make_code_from_func_call();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    if(all_nodes[$$]->datatype == "None" || all_nodes[$1]->is_class) {
        quad q("", "", "", "");
        q.make_code_from_none_return_val();
        all_nodes[$$]->ta_codes.push_back(q);
        all_nodes[$$]->var = "__t" + to_string(temp_count - 1);
    }
    else{
        string temp = get_new_temp();
        quad q1(temp, "", "", "");
        q1.make_code_from_return_val();
        all_nodes[$$]->ta_codes.push_back(q1);
        all_nodes[$$]->var = temp;
    }
}
| trailored_atom DELIM_LEFT_BRACKET test DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "trailored_atom"}; node_numbers = {$1, node_count, $3, node_count + 1}; insert_node(); $$ = node_count + 2;
    if(all_nodes[$3]->datatype != "int") {
        cout << "Type mismatch at line " << yylineno << ". List index should be an integer\n";
        exit(1);
    }
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "list_subs");
    node_count += 3;
    all_nodes[$$]->append_tac(all_nodes[$1]);
    string temp = get_new_temp();
    string narg1 = all_nodes[$1]->var;
    narg1 = check_star_and_make(all_nodes[$$], narg1);
    quad q(temp, narg1, "=", "");
    q.make_code_from_assignment();
    all_nodes[$$]->ta_codes.push_back(q);
    all_nodes[$$]->append_tac(all_nodes[$3]);
    string narg2 = all_nodes[$3]->var;
    narg2 = check_star_and_make(all_nodes[$$], narg2);
    string temp1 = get_new_temp();
    quad q1(temp1, temp, "", "");
    q1.make_code_from_load();
    all_nodes[$$]->ta_codes.push_back(q1);
    string temp2 = get_new_temp();
    quad q2(temp2, narg2, ">=", temp1);   // chitwan -- pehle ye >= ki jgh < tha
    q2.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q2);
    
    string op = "if_false";
    string arg2 = "J+2";
    quad q3("", temp2, op, arg2);
    q3.make_code_from_conditional();
    all_nodes[$$]->ta_codes.push_back(q3);
    quad q4("", "", "", "");
    q4.code = "\t\texit_out_of_bound\n";
    q4.made_from = quad::EXIT;
    all_nodes[$$]->ta_codes.push_back(q4);
    // temp is the base address excluding size; temp1 is useless at this point
    string type = all_nodes[$1]->datatype.substr(6, all_nodes[$1]->datatype.size() - 8);
    int size = type_to_size[type];
    if(!is_not_class(type)) {
        size = 8;
    }
    quad q5(temp1, narg2 , "*", to_string(size));   // [4i] => 4*i
    q5.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q5);
    quad q6(temp1, temp1 , "+", "8");  // bypassing the size thing   + 8
    q6.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q6);  
    quad q7(temp1, temp , "+", temp1);   // base + 8 + 4 * i
    q7.make_code_from_binary();
    all_nodes[$$]->ta_codes.push_back(q7);
    string t = get_new_temp();
    /* shrey - Changing temp for a[i] */
    all_nodes[$$]->var = "*" + temp1;
    all_nodes[$$]->is_var = true;
}

| trailored_atom DELIM_DOT NAME {node_attr = {".", string("NAME ( ") + strdup($2) + " )", "trailored_atom"}; node_numbers = {$1 ,node_count, node_count + 1}; insert_node(); $$ = node_count + 2;
    all_nodes[$$]->append_tac(all_nodes[$1]);   // chitwan ---
    all_nodes[$$]->datatype = set_trailer_type_compatibility($$, all_nodes[$1],all_nodes[$1]->datatype, "objattribute", strdup($3));
    node_count += 3;
    // done in set trailer type
}

atom: DELIM_LEFT_PAREN test DELIM_RIGHT_PAREN {node_attr = {"(", ")", "atom"}; node_numbers = {node_count, $2, node_count + 1}; insert_node(); $$ = node_count + 2;
    node_count += 3;
    all_nodes[$$]->datatype = all_nodes[$2]->datatype;
    all_nodes[$$]->var = all_nodes[$2]->var;
    all_nodes[$$]->append_tac(all_nodes[$2]);
    set_var_class_func($$, $2);
}

| DELIM_LEFT_BRACKET testlist DELIM_RIGHT_BRACKET {node_attr = {"[", "]", "atom"}; node_numbers = {node_count, $2, node_count+1}; insert_node(); $$ = node_count + 2;
    node_count += 3;
    int size = type_to_size[all_nodes[$2]->datatype];
    if(!is_not_class(all_nodes[$2]->datatype)) {
        size = 8;
    }
    all_nodes[$$]->append_tac(all_nodes[$2]);   // chitwan -- ye missing tha
    all_nodes[$$]->datatype = "list[ " + all_nodes[$2]->datatype + " ]";
    all_nodes[$$]->var = get_new_temp();
    quad q0("", to_string(all_nodes[$2]->var_list.size() * size + 8) , "push_param", "");
    q0.make_code_push_param();
    all_nodes[$$]->ta_codes.push_back(q0);  
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[$$]->ta_codes.push_back(q);  
    q = quad("", "allocmem", "call", "1");
    q.make_code_from_func_call();
    all_nodes[$$]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer(); 
    all_nodes[$$]->ta_codes.push_back(q);  
    quad q2(all_nodes[$$]->var, "", "", "");
    q2.make_code_from_return_val();
    all_nodes[$$]->ta_codes.push_back(q2);
    
    quad q1(string(all_nodes[$$]->var), to_string(all_nodes[$2]->var_list.size()), "", "");
    q1.make_code_from_store();
    all_nodes[$$]->ta_codes.push_back(q1);
    for(int i = 0; i < all_nodes[$2]->var_list.size(); i++) {
        string tmp = get_new_temp();
        quad q(tmp, all_nodes[$$]->var, "+", to_string(8 + size * i ));
        q.make_code_from_binary();
        all_nodes[$$]->ta_codes.push_back(q);
        string argument = all_nodes[$2]->var_list[i];
        argument = check_star_and_make(all_nodes[$$], argument);
        q = quad(tmp, argument, "", "");
        q.make_code_from_store();
        all_nodes[$$]->ta_codes.push_back(q);
    }
}

| NAME {node_attr = {string("NAME ( ") + strdup($1) + " )", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; 
    all_nodes[$$]->datatype = check_decl_before_use(strdup($1), all_nodes[$$]);
    node_count += 2;
}

| number {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
    all_nodes[$$]->var = all_nodes[$1]->var;
}

| STRING_LITERAL {node_attr = {string("STR ") + strdup($1), "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->datatype = "str";
    string str = strdup($1);
    if(str[0] == '\'') {
        str = "\"" + str.substr(1, str.size() - 2) + "\"";
    }
    string temp = get_new_str_temp();
    all_nodes[$$]->var = get_new_temp();
    string_list[temp] = str;
    quad q(all_nodes[$$]->var, temp, "", "");
    q.make_code_from_new_str();
    all_nodes[$$]->ta_codes.push_back(q);
}

| DELIM_ELLIPSIS {node_attr = {"...", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;}

| KEY_NONE {node_attr = {"None", "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->datatype = "None";
    all_nodes[$$]->var = strdup($1);
}

| KEY_TRUE {node_attr = {string("BOL ") + strdup($1), "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2; all_nodes[$$]->datatype = "bool";
    all_nodes[$$]->var = "1";
}
| KEY_FALSE {node_attr = {string("BOL ") + strdup($1), "atom"}; node_numbers = {node_count}; insert_node(); $$ = node_count + 1; node_count += 2;all_nodes[$$]->datatype = "bool";
    all_nodes[$$]->var = "0";
}
| types {node_attr = {"atom"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1; all_nodes[$$]->datatype = all_nodes[$1]->datatype;}

| SELF_DOT NAME {node_attr = {"self.", string("NAME ( ") + strdup($2) + " )", "atom"}; node_numbers =   {node_count, node_count+1}; insert_node(); $$ = node_count + 2;
    node_count += 3;
    all_nodes[$$]->datatype = check_self_decl_before_use(strdup($2), all_nodes[$$]);
    string name = strdup($2);
    st_entry *curr_entry = ((symbol_table_class *)(current_table->parent_st)) -> look_up_attribute_in_class_hierarchy(name);
}

number: INTEGER {
    node_attr = {string("INT ") + strdup($1), "number"};
    node_numbers = {node_count};
    insert_node();
    $$ = node_count + 1;
    all_nodes[$$]->datatype = "int";
    node_count += 2;
    all_nodes[$$]->var = strdup($1);
}
| FLOAT_NUMBER {
    node_attr = {string("FLT ") + strdup($1), "number"};
    node_numbers = {node_count};
    insert_node();
    $$ = node_count + 1;
    all_nodes[$$]->datatype = "float";
    node_count += 2;
    all_nodes[$$]->var = strdup($1);
}

testlist: test {node_attr = {"testlist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$] -> datatype = all_nodes[$1] -> datatype;
    all_nodes[$$] -> var_list = {all_nodes[$1] -> var};
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| test DELIM_COMMA testlist {node_attr = {",", "testlist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    is_compatible(all_nodes[$1] -> datatype, all_nodes[$3] -> datatype);
    all_nodes[$$] -> datatype = max_type(all_nodes[$1] -> datatype, all_nodes[$3] -> datatype);
    all_nodes[$$]->var_list = {all_nodes[$1]->var};
    all_nodes[$$]->var_list.insert(all_nodes[$$]->var_list.end(), all_nodes[$3]->var_list.begin(), all_nodes[$3]->var_list.end());
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$3]);
}
| test DELIM_COMMA {node_attr = {",", "testlist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$] -> datatype = all_nodes[$1] -> datatype;
    all_nodes[$$]->var_list.push_back(all_nodes[$1]->var);
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

classdef: class_header suite {
    node_attr = {"classdef"};
    node_numbers = {$1, $2};
    insert_node();
    $$ =  node_count;
    node_count += 1;
    type_to_size[current_table -> name] = ((symbol_table_class *)current_table) -> object_size;
    type_to_size["list[ " + current_table -> name + " ]"] = 8;
    current_table = current_table->parent_st;
    all_nodes[$$] -> append_tac(all_nodes[$1]);
    all_nodes[$$] -> append_tac(all_nodes[$2]);
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

arglist: argument {node_attr = {"arglist"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1; 
    all_nodes[$$]->type_list.push_back(all_nodes[$1]->datatype);
    all_nodes[$$]->var_list.push_back(all_nodes[$1]->var);
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
| argument DELIM_COMMA arglist {node_attr = {",", "arglist"}; node_numbers = {$1, node_count, $3}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->type_list = {all_nodes[$1]->datatype};
    all_nodes[$$]->type_list.insert(all_nodes[$$]->type_list.end(), all_nodes[$3]->type_list.begin(), all_nodes[$3]->type_list.end());
    all_nodes[$$]->var_list = {all_nodes[$1]->var};
    all_nodes[$$]->var_list.insert(all_nodes[$$]->var_list.end(), all_nodes[$3]->var_list.begin(), all_nodes[$3]->var_list.end());
    all_nodes[$$]->append_tac(all_nodes[$1]);
    all_nodes[$$]->append_tac(all_nodes[$3]);
}
| argument DELIM_COMMA {node_attr = {",", "arglist"}; node_numbers = {$1, node_count}; insert_node(); $$ = node_count + 1; node_count += 2;
    all_nodes[$$]->type_list.push_back(all_nodes[$1]->datatype);
    all_nodes[$$]->var_list.push_back(all_nodes[$1]->var);
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

argument: test {node_attr = {"argument"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1] -> datatype;
    all_nodes[$$]->var = all_nodes[$1]->var;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}

func_body_suite: single_stmt {node_attr = {"func_body_suite"}; node_numbers = {$1}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$1]);
}
|  newline_plus INDENT stmt_plus DEDENT {node_attr = {"func_body_suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$3]);
}
|  newline_plus INDENT stmt_plus DEDENT newline_plus {node_attr = {"func_body_suite"}; node_numbers = {$3}; insert_node(); $$ = node_count; node_count += 1;
    all_nodes[$$]->append_tac(all_nodes[$3]);
}

types: TYPE_INT {
    node_attr = {"int", "types"};
    node_numbers = {node_count};
    insert_node();
    $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->datatype = "int";
}
| TYPE_BOOL {
    node_attr = {"bool", "types"};
    node_numbers = {node_count};
    insert_node();
    $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->datatype = "bool";
}
| TYPE_FLOAT {
    node_attr = {"float", "types"}; 
    node_numbers = {node_count}; 
    insert_node(); 
    $$ = node_count + 1; 
    node_count += 2;
    all_nodes[$$]->datatype = "float";
}
| type_list {
    node_attr = {"types"};
    node_numbers = {$1};
    insert_node();
    $$ = node_count;
    node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
}
| TYPE_STRING {
    node_attr = {"str", "types"}; 
    node_numbers = {node_count}; 
    insert_node(); 
    $$ = node_count + 1; 
    node_count += 2;
    all_nodes[$$]->datatype = "str";
}

type_list: TYPE_LIST DELIM_LEFT_BRACKET types DELIM_RIGHT_BRACKET {
    node_attr = {"list", "[", "]", "type_list"};
    node_numbers = {node_count, node_count + 1, $3, node_count + 2};
    insert_node();
    $$ = node_count + 3;
    node_count += 4;
    all_nodes[$$]->datatype = "list[ " + all_nodes[$3]->datatype + " ]";
}
| TYPE_LIST DELIM_LEFT_BRACKET NAME DELIM_RIGHT_BRACKET {
    node_attr = {"list", "[", string("NAME ( ") + strdup($3) + " )", "]", "type_list"}; 
    node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3};
    insert_node();
    $$ = node_count + 4;
    node_count += 5;
    all_nodes[$$]->datatype = string("list[ ") + strdup($3) + " ]";
}

type_or_name: types {
    node_attr = {"type_or_name"};
    node_numbers = {$1};
    insert_node();
    $$ = node_count;
    node_count += 1;
    all_nodes[$$]->datatype = all_nodes[$1]->datatype;
}
| NAME {
    node_attr = {string("NAME ( ") + strdup($1) + " )", "type_or_name"};
    node_numbers = {node_count};
    insert_node();
    $$ = node_count + 1;
    node_count += 2;
    all_nodes[$$]->datatype = strdup($1);
}

%%

int main(int argc, char* argv[]) {
    current_table = global_table;
    temp_table = NULL;
    bool help_flag = false;
    string input_file = "";
    string output_file = "3AC.txt";

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

    global_table->add_Print();
    global_table->add_Len();
    yyparse();
    root_node = all_nodes.back();
    global_table->make_csv_wrapper("st.csv");
    
    ins_count = 1; 
    root_node->print_tac(output_file);
    codegen* gen = new codegen();
    gen->gen_global();
    gen->gen_text(); 

    gen->print_code("code.s");
    return 0;
}

void yyerror(const char* s)  {
    cerr << "\n************************ ERROR ********************************\n" << endl;
    cerr << "Error at line number: " << yylineno << endl;
    cerr << "Error: " << s << endl;
    cerr << "\n***************************************************************\n" << endl;
};
