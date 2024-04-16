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
    cout << "--symbtab \t\t\t: Print the symbol tables in separate .csv files" << endl;
    cout << "--no-save-temps \t\t: To remove temporary files after execution (by default they are saved)" << endl;
    cout << "--verbose1 \t\t\t: Prints our custom debug statements while reducing a production" << endl;
    cout << "--verbose2 \t\t\t: Prints the complete stack trace of the parser execution" << endl;
    cout << endl;
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


#line 669 "parser.tab.c"

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

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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

#line 805 "parser.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */



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
#define YYFINAL  96
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   955

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  79
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  59
/* YYNRULES -- Number of rules.  */
#define YYNRULES  165
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  268

#define YYUNDEFTOK  2
#define YYMAXUTOK   333


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
      75,    76,    77,    78
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   617,   617,   641,   644,   647,   649,   652,   654,   655,
     657,   673,   696,   720,   727,   735,   739,   743,   750,   767,
     782,   785,   789,   793,   796,   799,   804,   807,   810,   814,
     817,   834,   869,   890,   894,   946,   985,   986,   987,   988,
     989,   990,   991,   992,   993,   994,   995,   996,   998,  1001,
    1004,  1008,  1019,  1030,  1043,  1051,  1069,  1079,  1091,  1094,
    1097,  1100,  1103,  1106,  1110,  1118,  1132,  1154,  1175,  1210,
    1223,  1243,  1265,  1307,  1352,  1353,  1357,  1360,  1363,  1367,
    1373,  1382,  1389,  1397,  1402,  1410,  1416,  1423,  1429,  1480,
    1481,  1482,  1483,  1484,  1485,  1486,  1487,  1489,  1495,  1502,
    1508,  1514,  1520,  1526,  1532,  1537,  1544,  1550,  1557,  1564,
    1570,  1574,  1578,  1582,  1588,  1597,  1603,  1609,  1616,  1623,
    1629,  1636,  1643,  1701,  1740,  1796,  1802,  1848,  1886,  1942,
    1949,  1957,  1998,  2003,  2008,  2022,  2024,  2029,  2032,  2035,
    2037,  2044,  2053,  2063,  2068,  2076,  2082,  2095,  2103,  2111,
    2120,  2125,  2133,  2139,  2145,  2148,  2151,  2155,  2163,  2171,
    2179,  2187,  2196,  2204,  2213,  2221
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "KEY_FALSE", "KEY_ELSE", "KEY_NONE",
  "KEY_BREAK", "KEY_IN", "KEY_TRUE", "KEY_CLASS", "KEY_RETURN", "KEY_AND",
  "KEY_CONTINUE", "KEY_FOR", "KEY_DEF", "KEY_WHILE", "KEY_GLOBAL",
  "KEY_NOT", "KEY_ELIF", "KEY_IF", "KEY_OR", "KEY_RANGE", "OP_ADD",
  "OP_SUBTRACT", "OP_MULTIPLY", "OP_POWER", "OP_DIVIDE", "OP_FLOOR_DIVIDE",
  "OP_MODULO", "OP_LEFT_SHIFT", "OP_RIGHT_SHIFT", "OP_BITWISE_AND",
  "OP_BITWISE_OR", "OP_BITWISE_XOR", "OP_BITWISE_NOT", "OP_LESS_THAN",
  "OP_GREATER_THAN", "OP_LESS_THAN_EQUAL", "OP_GREATER_THAN_EQUAL",
  "OP_EQUAL", "OP_NOT_EQUAL", "DELIM_LEFT_PAREN", "DELIM_RIGHT_PAREN",
  "DELIM_LEFT_BRACKET", "DELIM_RIGHT_BRACKET", "DELIM_COMMA",
  "DELIM_COLON", "DELIM_DOT", "DELIM_SEMICOLON", "DELIM_ASSIGN",
  "DELIM_ARROW", "DELIM_ASSIGN_ADD", "DELIM_ASSIGN_SUBTRACT",
  "DELIM_ASSIGN_MULTIPLY", "DELIM_ASSIGN_DIVIDE",
  "DELIM_ASSIGN_FLOOR_DIVIDE", "DELIM_ASSIGN_MODULO",
  "DELIM_ASSIGN_BITWISE_AND", "DELIM_ASSIGN_BITWISE_OR",
  "DELIM_ASSIGN_BITWISE_XOR", "DELIM_ASSIGN_RIGHT_SHIFT",
  "DELIM_ASSIGN_LEFT_SHIFT", "DELIM_ASSIGN_POWER", "DELIM_ELLIPSIS",
  "NAME", "INDENT", "DEDENT", "NEWLINE", "FLOAT_NUMBER", "INTEGER",
  "STRING_LITERAL", "DUNDER_NAME", "DUNDER_MAIN", "TYPE_INT", "TYPE_FLOAT",
  "TYPE_STRING", "TYPE_BOOL", "TYPE_LIST", "SELF_DOT", "$accept",
  "start_symbol", "file_input", "file_plus", "newline_plus", "funcdef",
  "func_header", "parameters", "typedarglist", "tfpdef", "blocks",
  "single_stmt", "semicolon_stmt", "small_stmt", "expr_stmt",
  "type_declaration", "augassign", "flow_stmt", "break_stmt",
  "continue_stmt", "return_stmt", "global_stmt", "names", "compound_stmt",
  "program_start", "if_stmt", "elif_plus", "while_stmt", "for_stmt",
  "stmt_plus", "suite", "namedexpr_test", "test", "or_test", "and_test",
  "not_test", "comparison", "comp_op", "expr", "xor_expr", "and_expr",
  "shift_expr", "arith_expr", "term", "factor", "power", "atom_expr",
  "trailored_atom", "atom", "number", "testlist", "classdef",
  "class_header", "arglist", "argument", "func_body_suite", "types",
  "type_list", "type_or_name", YY_NULLPTR
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
     325,   326,   327,   328,   329,   330,   331,   332,   333
};
# endif

#define YYPACT_NINF (-158)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     242,  -158,  -158,  -158,  -158,   -20,   861,  -158,   877,     5,
     861,    11,   861,   693,   877,   877,   877,   861,   861,  -158,
      41,  -158,  -158,  -158,  -158,  -158,  -158,  -158,  -158,    48,
      34,   103,  -158,   546,   318,  -158,   595,  -158,  -158,    38,
      59,  -158,    63,  -158,  -158,  -158,  -158,  -158,  -158,  -158,
    -158,  -158,  -158,     4,  -158,    91,   108,  -158,    10,    87,
      90,    52,    29,    62,  -158,  -158,    97,   -15,    61,  -158,
    -158,   595,  -158,  -158,   -12,  -158,    60,  -158,     7,    84,
      80,  -158,    82,  -158,  -158,    89,    83,  -158,  -158,  -158,
      88,    86,    92,     3,    20,    93,  -158,  -158,  -158,   546,
     -45,  -158,  -158,    65,   644,   861,   861,  -158,  -158,  -158,
    -158,  -158,  -158,  -158,  -158,  -158,  -158,  -158,  -158,   861,
     861,   861,  -158,   126,   877,  -158,  -158,  -158,  -158,  -158,
    -158,   877,   877,   877,   877,   877,   877,   877,   877,   877,
     877,   877,   877,   769,   861,    70,   785,   861,    71,   -34,
    -158,  -158,   -23,  -158,  -158,   121,   -21,    22,   595,    11,
      72,   595,  -158,   861,  -158,  -158,  -158,  -158,   101,   109,
       3,   546,  -158,  -158,  -158,  -158,  -158,  -158,  -158,    87,
    -158,    90,    52,    29,    29,    62,    62,  -158,  -158,  -158,
    -158,  -158,  -158,  -158,   110,   111,   114,  -158,  -158,   112,
     115,  -158,   546,   116,   113,   119,  -158,   117,   122,   120,
    -158,   861,  -158,  -158,   123,    12,  -158,  -158,  -158,  -158,
    -158,   394,  -158,   861,  -158,  -158,  -158,   470,  -158,   124,
     861,     3,  -158,   102,   125,   595,   129,   861,   157,    38,
    -158,  -158,    38,  -158,    28,  -158,  -158,  -158,  -158,   595,
     130,   131,    65,    65,   132,   861,  -158,   595,   595,   595,
     137,   149,  -158,  -158,   134,  -158,   595,  -158
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,   138,   136,    51,   137,     0,    54,    52,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,   135,
     132,     9,   142,   141,   134,   157,   159,   161,   158,     0,
       0,     0,     2,     3,     5,    61,     0,     7,    20,     0,
      23,    26,    29,    27,    48,    49,    50,    28,    21,    63,
      58,    59,    60,    33,    80,    81,    83,    86,    87,    97,
      99,   101,   103,   106,   109,   117,   118,   121,   120,   133,
      62,     0,   139,   160,     0,   132,     0,    53,     0,     0,
       0,    79,    56,    55,    85,     0,     0,   115,   116,   114,
       0,   143,     0,     0,     0,   140,     1,     6,     8,     4,
       0,   154,    10,    22,    24,     0,     0,    36,    37,    38,
      39,    47,    40,    41,    42,    43,    45,    44,    46,     0,
       0,     0,    95,     0,     0,    89,    90,    93,    92,    91,
      94,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      76,   146,     0,   149,   140,     0,     0,     0,     0,     0,
       0,     0,   130,   145,   131,   165,   164,    34,     0,     0,
       0,     0,    25,    30,    32,    31,    82,    84,    96,    98,
      88,   100,   102,   104,   105,   107,   108,   110,   111,   113,
     112,   119,   127,   153,     0,   150,     0,   129,   123,     0,
       0,   125,     0,     0,     0,     0,    14,    19,     0,    16,
      12,     0,    71,    57,     0,    65,   144,   163,   162,    35,
      74,     0,   126,   152,   128,   122,   124,     0,   148,     0,
       0,     0,    13,    15,     0,     0,     0,     0,    66,   155,
      75,   151,    77,   147,     0,    18,    17,    11,    64,     0,
       0,     0,   156,    78,     0,     0,    67,     0,     0,     0,
       0,    69,    68,    72,     0,    70,     0,    73
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -158,  -158,  -158,   138,     1,  -158,  -158,  -158,   -65,  -158,
     -28,     2,    77,  -158,  -158,  -158,  -158,  -158,  -158,  -158,
    -158,  -158,    23,  -158,  -158,  -158,   -78,  -158,  -158,   -18,
    -143,   -10,    -6,    66,    64,   175,    57,  -158,   181,    67,
      58,    68,   -25,   -19,     9,  -158,  -158,  -158,  -158,  -158,
    -109,  -158,  -158,  -140,  -158,  -158,   -85,  -158,  -157
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    31,    32,    33,   149,    35,    36,   157,   208,   209,
      37,   150,    39,    40,    41,    42,   119,    43,    44,    45,
      46,    47,    83,    48,    49,    50,   238,    51,    52,   221,
     151,    80,    53,    54,    55,    56,    57,   131,    58,    59,
      60,    61,    62,    63,    64,    65,    66,    67,    68,    69,
      92,    70,    71,   194,   195,   102,    72,    73,   167
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      77,    34,    38,    86,    81,    97,   199,    81,   166,   169,
     175,    90,    91,   219,   155,   212,   236,   122,   215,   203,
     171,   206,    98,    87,    88,    89,   143,   123,   144,   152,
     237,   202,   145,    98,   153,    38,    38,   100,   101,   124,
     103,   204,   124,   207,    74,   125,   126,   127,   128,   129,
     130,   136,   137,   106,   216,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,   118,   165,   210,    79,
     254,    97,   211,   255,   245,    82,    25,    26,    27,    28,
      29,   134,   135,   241,   168,   166,   138,    93,   139,   140,
     141,    94,   248,    25,    26,    27,    28,    29,    95,   173,
     174,    38,   146,    96,   147,    21,   256,   104,   148,   183,
     184,   120,   105,    91,   261,   262,   263,   185,   186,   121,
     132,   133,   142,   267,   154,   156,   158,   159,   160,   161,
     162,   163,    98,   178,   197,   201,   164,   193,   196,   170,
     193,   200,   205,   220,   214,   217,   166,   187,   188,   189,
     190,   191,   222,   218,   225,   229,   223,    91,   224,   226,
     230,   251,   228,   231,   232,   233,   207,   237,   246,   235,
     243,   247,    99,    38,   220,   249,   257,   258,   259,   264,
     266,   172,   213,   265,   227,   177,   176,    84,   180,    78,
     181,   179,     0,   240,     0,     0,     0,     0,     0,   240,
       0,   182,     0,     0,    38,   234,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   193,     0,     0,
       0,     0,     0,    38,   244,     0,     0,   250,     0,    38,
       0,    81,     0,     0,     0,     0,     0,     0,     0,     0,
     252,     0,     0,   253,     0,     1,     0,     2,     3,   260,
       4,     5,     6,     0,     7,     8,     9,    10,    11,    12,
       0,    13,     0,     0,    14,    15,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    16,     0,     0,     0,
       0,     0,     0,    17,     0,    18,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    19,    20,     0,     0,    21,
      22,    23,    24,     0,     0,    25,    26,    27,    28,    29,
      30,     1,     0,     2,     3,     0,     4,     5,     6,     0,
       7,     8,     9,    10,    11,    12,     0,    13,     0,     0,
      14,    15,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    16,     0,     0,     0,     0,     0,     0,    17,
       0,    18,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    19,    20,     0,     0,    98,    22,    23,    24,     0,
       0,    25,    26,    27,    28,    29,    30,     1,     0,     2,
       3,     0,     4,     5,     6,     0,     7,     8,     9,    10,
      11,    12,     0,    13,     0,     0,    14,    15,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    16,     0,
       0,     0,     0,     0,     0,    17,     0,    18,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    19,    20,     0,
     239,     0,    22,    23,    24,     0,     0,    25,    26,    27,
      28,    29,    30,     1,     0,     2,     3,     0,     4,     5,
       6,     0,     7,     8,     9,    10,    11,    12,     0,    13,
       0,     0,    14,    15,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    16,     0,     0,     0,     0,     0,
       0,    17,     0,    18,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    19,    20,     0,   242,     0,    22,    23,
      24,     0,     0,    25,    26,    27,    28,    29,    30,     1,
       0,     2,     3,     0,     4,     5,     6,     0,     7,     8,
       9,    10,    11,    12,     0,    13,     0,     0,    14,    15,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      16,     0,     0,     0,     0,     0,     0,    17,     0,    18,
       0,     0,     0,     0,     0,     0,     0,     0,     1,     0,
       2,     3,     0,     4,     0,     6,     0,     7,     0,    19,
      20,    11,    12,     0,    22,    23,    24,    14,    15,    25,
      26,    27,    28,    29,    30,     0,     0,     0,     0,    16,
       0,     0,     0,     0,     0,     0,    17,     0,    18,     0,
       0,     0,     0,     0,     0,     0,     0,     1,     0,     2,
       3,     0,     4,     0,     6,     0,     7,     0,    19,    20,
      11,    12,    21,    22,    23,    24,    14,    15,    25,    26,
      27,    28,    29,    30,     0,     0,     0,     0,    16,     0,
       0,     0,     0,     0,     0,    17,     0,    18,     0,     0,
       0,     0,     0,     0,     0,     0,     1,     0,     2,     0,
       0,     4,     0,     0,     0,     0,     0,    19,    20,     0,
      12,     0,    22,    23,    24,    14,    15,    25,    26,    27,
      28,    29,    30,     0,     0,     0,     0,    16,     0,     0,
       0,     0,     0,     0,    17,     0,    18,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    19,    75,     0,     0,
       0,    22,    23,    24,    85,     0,    25,    26,    27,    28,
      29,    76,     1,     0,     2,     0,     0,     4,     0,     0,
       0,     0,     0,     0,     0,     0,    12,     0,     1,     0,
       2,    14,    15,     4,     0,     0,     0,     0,     0,     0,
       0,     0,    12,    16,     0,     0,     0,    14,    15,     0,
      17,   192,    18,     0,     0,     0,     0,     0,     0,    16,
       0,     0,     0,     0,     0,     0,    17,   198,    18,     0,
       0,     0,    19,    75,     0,     0,     0,    22,    23,    24,
       0,     0,    25,    26,    27,    28,    29,    76,    19,    75,
       0,     0,     0,    22,    23,    24,     0,     0,    25,    26,
      27,    28,    29,    76,     1,     0,     2,     0,     0,     4,
       0,     0,     0,     0,     0,     0,     0,     0,    12,     0,
       1,     0,     2,    14,    15,     4,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    16,     0,     0,     0,    14,
      15,     0,    17,     0,    18,     0,     0,     0,     0,     0,
       0,    16,     0,     0,     0,     0,     0,     0,    17,     0,
      18,     0,     0,     0,    19,    75,     0,     0,     0,    22,
      23,    24,     0,     0,    25,    26,    27,    28,    29,    76,
      19,    75,     0,     0,     0,    22,    23,    24,     0,     0,
      25,    26,    27,    28,    29,    76
};

static const yytype_int16 yycheck[] =
{
       6,     0,     0,    13,    10,    33,   146,    13,    93,    94,
     119,    17,    18,   170,     7,   158,     4,     7,   161,    42,
      65,    42,    67,    14,    15,    16,    41,    17,    43,    41,
      18,    65,    47,    67,    46,    33,    34,    36,    36,    32,
      39,    64,    32,    64,    64,    35,    36,    37,    38,    39,
      40,    22,    23,    49,   163,    51,    52,    53,    54,    55,
      56,    57,    58,    59,    60,    61,    62,    64,    46,    64,
      42,    99,    50,    45,   231,    64,    73,    74,    75,    76,
      77,    29,    30,   223,    64,   170,    24,    46,    26,    27,
      28,    43,   235,    73,    74,    75,    76,    77,    64,   105,
     106,    99,    41,     0,    43,    67,   249,    48,    47,   134,
     135,    20,    49,   119,   257,   258,   259,   136,   137,    11,
      33,    31,    25,   266,    64,    41,    46,    45,    39,    46,
      42,    45,    67,     7,    64,    64,    44,   143,   144,    46,
     146,   147,    21,   171,    72,    44,   231,   138,   139,   140,
     141,   142,    42,    44,    42,    42,    45,   163,    44,    44,
      41,     4,    46,    46,    42,    45,    64,    18,   233,    46,
      46,    46,    34,   171,   202,    46,    46,    46,    46,    42,
      46,   104,   159,   261,   202,   121,   120,    12,   131,     8,
     132,   124,    -1,   221,    -1,    -1,    -1,    -1,    -1,   227,
      -1,   133,    -1,    -1,   202,   211,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,   223,    -1,    -1,
      -1,    -1,    -1,   221,   230,    -1,    -1,   237,    -1,   227,
      -1,   237,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     239,    -1,    -1,   242,    -1,     3,    -1,     5,     6,   255,
       8,     9,    10,    -1,    12,    13,    14,    15,    16,    17,
      -1,    19,    -1,    -1,    22,    23,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    34,    -1,    -1,    -1,
      -1,    -1,    -1,    41,    -1,    43,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    63,    64,    -1,    -1,    67,
      68,    69,    70,    -1,    -1,    73,    74,    75,    76,    77,
      78,     3,    -1,     5,     6,    -1,     8,     9,    10,    -1,
      12,    13,    14,    15,    16,    17,    -1,    19,    -1,    -1,
      22,    23,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    34,    -1,    -1,    -1,    -1,    -1,    -1,    41,
      -1,    43,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    63,    64,    -1,    -1,    67,    68,    69,    70,    -1,
      -1,    73,    74,    75,    76,    77,    78,     3,    -1,     5,
       6,    -1,     8,     9,    10,    -1,    12,    13,    14,    15,
      16,    17,    -1,    19,    -1,    -1,    22,    23,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    34,    -1,
      -1,    -1,    -1,    -1,    -1,    41,    -1,    43,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    63,    64,    -1,
      66,    -1,    68,    69,    70,    -1,    -1,    73,    74,    75,
      76,    77,    78,     3,    -1,     5,     6,    -1,     8,     9,
      10,    -1,    12,    13,    14,    15,    16,    17,    -1,    19,
      -1,    -1,    22,    23,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    34,    -1,    -1,    -1,    -1,    -1,
      -1,    41,    -1,    43,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    63,    64,    -1,    66,    -1,    68,    69,
      70,    -1,    -1,    73,    74,    75,    76,    77,    78,     3,
      -1,     5,     6,    -1,     8,     9,    10,    -1,    12,    13,
      14,    15,    16,    17,    -1,    19,    -1,    -1,    22,    23,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      34,    -1,    -1,    -1,    -1,    -1,    -1,    41,    -1,    43,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,     3,    -1,
       5,     6,    -1,     8,    -1,    10,    -1,    12,    -1,    63,
      64,    16,    17,    -1,    68,    69,    70,    22,    23,    73,
      74,    75,    76,    77,    78,    -1,    -1,    -1,    -1,    34,
      -1,    -1,    -1,    -1,    -1,    -1,    41,    -1,    43,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,     3,    -1,     5,
       6,    -1,     8,    -1,    10,    -1,    12,    -1,    63,    64,
      16,    17,    67,    68,    69,    70,    22,    23,    73,    74,
      75,    76,    77,    78,    -1,    -1,    -1,    -1,    34,    -1,
      -1,    -1,    -1,    -1,    -1,    41,    -1,    43,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,     3,    -1,     5,    -1,
      -1,     8,    -1,    -1,    -1,    -1,    -1,    63,    64,    -1,
      17,    -1,    68,    69,    70,    22,    23,    73,    74,    75,
      76,    77,    78,    -1,    -1,    -1,    -1,    34,    -1,    -1,
      -1,    -1,    -1,    -1,    41,    -1,    43,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    63,    64,    -1,    -1,
      -1,    68,    69,    70,    71,    -1,    73,    74,    75,    76,
      77,    78,     3,    -1,     5,    -1,    -1,     8,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    17,    -1,     3,    -1,
       5,    22,    23,     8,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    17,    34,    -1,    -1,    -1,    22,    23,    -1,
      41,    42,    43,    -1,    -1,    -1,    -1,    -1,    -1,    34,
      -1,    -1,    -1,    -1,    -1,    -1,    41,    42,    43,    -1,
      -1,    -1,    63,    64,    -1,    -1,    -1,    68,    69,    70,
      -1,    -1,    73,    74,    75,    76,    77,    78,    63,    64,
      -1,    -1,    -1,    68,    69,    70,    -1,    -1,    73,    74,
      75,    76,    77,    78,     3,    -1,     5,    -1,    -1,     8,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    17,    -1,
       3,    -1,     5,    22,    23,     8,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    34,    -1,    -1,    -1,    22,
      23,    -1,    41,    -1,    43,    -1,    -1,    -1,    -1,    -1,
      -1,    34,    -1,    -1,    -1,    -1,    -1,    -1,    41,    -1,
      43,    -1,    -1,    -1,    63,    64,    -1,    -1,    -1,    68,
      69,    70,    -1,    -1,    73,    74,    75,    76,    77,    78,
      63,    64,    -1,    -1,    -1,    68,    69,    70,    -1,    -1,
      73,    74,    75,    76,    77,    78
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     5,     6,     8,     9,    10,    12,    13,    14,
      15,    16,    17,    19,    22,    23,    34,    41,    43,    63,
      64,    67,    68,    69,    70,    73,    74,    75,    76,    77,
      78,    80,    81,    82,    83,    84,    85,    89,    90,    91,
      92,    93,    94,    96,    97,    98,    99,   100,   102,   103,
     104,   106,   107,   111,   112,   113,   114,   115,   117,   118,
     119,   120,   121,   122,   123,   124,   125,   126,   127,   128,
     130,   131,   135,   136,    64,    64,    78,   111,   117,    64,
     110,   111,    64,   101,   114,    71,   110,   123,   123,   123,
     111,   111,   129,    46,    43,    64,     0,    89,    67,    82,
      83,    90,   134,    83,    48,    49,    49,    51,    52,    53,
      54,    55,    56,    57,    58,    59,    60,    61,    62,    95,
      20,    11,     7,    17,    32,    35,    36,    37,    38,    39,
      40,   116,    33,    31,    29,    30,    22,    23,    24,    26,
      27,    28,    25,    41,    43,    47,    41,    43,    47,    83,
      90,   109,    41,    46,    64,     7,    41,    86,    46,    45,
      39,    46,    42,    45,    44,    64,   135,   137,    64,   135,
      46,    65,    91,   111,   111,   129,   112,   113,     7,   118,
     115,   119,   120,   121,   121,   122,   122,   123,   123,   123,
     123,   123,    42,   111,   132,   133,   111,    64,    42,   132,
     111,    64,    65,    42,    64,    21,    42,    64,    87,    88,
      46,    50,   109,   101,    72,   109,   129,    44,    44,   137,
      89,   108,    42,    45,    44,    42,    44,   108,    46,    42,
      41,    46,    42,    45,   111,    46,     4,    18,   105,    66,
      89,   132,    66,    46,   111,   137,    87,    46,   109,    46,
     110,     4,    83,    83,    42,    45,   109,    46,    46,    46,
     111,   109,   109,   109,    42,   105,    46,   109
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    79,    80,    81,    81,    81,    82,    82,    83,    83,
      84,    85,    85,    86,    86,    87,    87,    87,    88,    88,
      89,    89,    90,    91,    91,    91,    92,    92,    92,    93,
      93,    93,    93,    93,    94,    94,    95,    95,    95,    95,
      95,    95,    95,    95,    95,    95,    95,    95,    96,    96,
      96,    97,    98,    99,    99,   100,   101,   101,   102,   102,
     102,   102,   102,   102,   103,   104,   104,   104,   104,   105,
     105,   106,   107,   107,   108,   108,   109,   109,   109,   110,
     111,   112,   112,   113,   113,   114,   114,   115,   115,   116,
     116,   116,   116,   116,   116,   116,   116,   117,   117,   118,
     118,   119,   119,   120,   120,   120,   121,   121,   121,   122,
     122,   122,   122,   122,   123,   123,   123,   123,   124,   124,
     125,   125,   126,   126,   126,   126,   126,   126,   126,   126,
     127,   127,   127,   127,   127,   127,   127,   127,   127,   127,
     127,   128,   128,   129,   129,   129,   130,   131,   131,   131,
     132,   132,   132,   133,   134,   134,   134,   135,   135,   135,
     135,   135,   136,   136,   137,   137
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     2,     1,     2,     1,     2,     1,
       2,     6,     4,     3,     2,     2,     1,     3,     3,     1,
       1,     1,     2,     1,     2,     3,     1,     1,     1,     1,
       3,     3,     3,     1,     3,     4,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     2,     1,     2,     1,     3,     1,     1,
       1,     1,     1,     1,     6,     4,     5,     7,     8,     4,
       5,     4,     9,    11,     1,     2,     1,     4,     5,     1,
       1,     1,     3,     1,     3,     2,     1,     1,     3,     1,
       1,     1,     1,     1,     1,     1,     2,     1,     3,     1,
       3,     1,     3,     1,     3,     3,     1,     3,     3,     1,
       3,     3,     3,     3,     2,     2,     2,     1,     1,     3,
       1,     1,     4,     3,     4,     3,     4,     3,     4,     3,
       3,     3,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     1,     1,     1,     3,     2,     2,     6,     5,     3,
       1,     3,     2,     1,     1,     4,     5,     1,     1,     1,
       1,     1,     4,     4,     1,     1
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
  case 2:
#line 617 "parser.y"
                         {node_attr = {"start_symbol"};  node_numbers = {(yyvsp[0].intval)}; insert_node();(yyval.intval) = node_count; node_count += 1;
    quad q("", "len", "", "");
    q.make_code_begin_func();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("len@list", "", "", "");
    q.make_code_pop_param();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    string temp = get_new_temp();
    q = quad(temp, "len@list", "=", "");
    q.make_code_from_assignment();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    string temp1 = get_new_temp();
    q = quad(temp1, temp, "", "");
    q.make_code_from_load();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("", temp1, "return", "");
    q.make_code_from_return();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("", "", "", "");
    q.make_code_end_func();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2360 "parser.tab.c"
    break;

  case 3:
#line 641 "parser.y"
                      {node_attr = {"file_input"};  node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2368 "parser.tab.c"
    break;

  case 4:
#line 644 "parser.y"
                         {node_attr = {"file_input"}; node_numbers = {(yyvsp[0].intval)}; insert_node();  (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2376 "parser.tab.c"
    break;

  case 5:
#line 647 "parser.y"
               {node_attr = {"file_input"}; node_numbers = {}; insert_node();  (yyval.intval) = node_count; node_count += 1;}
#line 2382 "parser.tab.c"
    break;

  case 6:
#line 649 "parser.y"
                            {(yyval.intval) = (yyvsp[-1].intval);all_nodes[(yyval.intval)]->add_child(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]); 
}
#line 2390 "parser.tab.c"
    break;

  case 7:
#line 652 "parser.y"
                  {(yyval.intval) = (yyvsp[0].intval);}
#line 2396 "parser.tab.c"
    break;

  case 8:
#line 654 "parser.y"
                                   {}
#line 2402 "parser.tab.c"
    break;

  case 9:
#line 655 "parser.y"
                      {}
#line 2408 "parser.tab.c"
    break;

  case 10:
#line 657 "parser.y"
                                     {node_attr = {"funcdef"}; node_numbers = {(yyvsp[-1].intval), (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1; 
    vector<st_entry *> temp;
    for(auto entry : current_table->entries) {
        if(!entry->is_global) {
            temp.push_back(entry);
        }
    }
    current_table->entries = temp;
    current_table = current_table->parent_st;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    quad q("", "", "", "");
    q.make_code_end_func();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 2428 "parser.tab.c"
    break;

  case 11:
#line 673 "parser.y"
                                                                  {
    node_attr = {"def", string("NAME ( ") + strdup((yyvsp[-4].strval)) + " )", "->", ":", "func_header"};
    node_numbers = {node_count, node_count + 1, (yyvsp[-3].intval), node_count + 2, (yyvsp[-1].intval), node_count + 3};
    insert_node();
    (yyval.intval) = node_count + 4;
    node_count += 5;
    symbol_table_func *newf = make_new_func_symbtab(strdup((yyvsp[-4].strval)), all_nodes[(yyvsp[-3].intval)]->entry_list, all_nodes[(yyvsp[-1].intval)]->datatype);
    quad q("", newf->mangled_name, "", "");
    q.make_code_begin_func();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    for(int i = all_nodes[(yyvsp[-3].intval)]->entry_list.size()-1;i>=0;i--) {
        auto entry = all_nodes[(yyvsp[-3].intval)]->entry_list[i];
        if(entry->name == "self") {
            entry -> mangled_name = "self";
        }
        else {
            entry -> mangled_name = newf -> mangled_name + "@" + entry->name;
        }
        quad q1( entry -> mangled_name , "", "", "");
        q1.make_code_pop_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    }
}
#line 2456 "parser.tab.c"
    break;

  case 12:
#line 696 "parser.y"
                                      {
    node_attr = {"def", string("NAME ( ") + strdup((yyvsp[-2].strval)) + " )", ":", "func_header"};
    node_numbers = {node_count, node_count + 1, (yyvsp[-1].intval), node_count + 2};
    insert_node();
    (yyval.intval) = node_count + 3; 
    node_count += 4;
    symbol_table_func *newf = make_new_func_symbtab(strdup((yyvsp[-2].strval)), all_nodes[(yyvsp[-1].intval)]->entry_list, "None");
    quad q("", newf -> mangled_name, "", "");
    q.make_code_begin_func();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    for(int i = all_nodes[(yyvsp[-1].intval)]->entry_list.size()-1;i>=0;i--) {
        auto entry = all_nodes[(yyvsp[-1].intval)]->entry_list[i];
        if(entry->name == "self") {
            entry -> mangled_name = "self";
        }
        else {
            entry -> mangled_name = newf -> mangled_name + "@" + entry->name;
        }
        quad q1(entry -> mangled_name , "", "", "");
        q1.make_code_pop_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    }
}
#line 2484 "parser.tab.c"
    break;

  case 13:
#line 720 "parser.y"
                                                            {
    node_attr = {"(", ")", "parameters"}; node_numbers = {node_count, (yyvsp[-1].intval), node_count + 1}; insert_node();
    (yyval.intval) = node_count + 2;
    node_count += 3;
    all_nodes[(yyval.intval)]->entry_list = all_nodes[(yyvsp[-1].intval)]->entry_list;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 2496 "parser.tab.c"
    break;

  case 14:
#line 727 "parser.y"
                                     {
    node_attr = {"(", ")","parameters"}; 
    node_numbers = {node_count + 0,node_count + 1};
    insert_node();
    (yyval.intval) = node_count + 2;
    node_count += 3;
}
#line 2508 "parser.tab.c"
    break;

  case 15:
#line 735 "parser.y"
                                 { node_attr = {",", "typedarglist"}; node_numbers = {(yyvsp[-1].intval), node_count}; insert_node(); (yyval.intval) = node_count + 1;  node_count += 2;
    all_nodes[(yyval.intval)]->entry_list = all_nodes[(yyvsp[-1].intval)]->entry_list;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 2517 "parser.tab.c"
    break;

  case 16:
#line 739 "parser.y"
         { node_attr = {"typedarglist"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->entry_list = all_nodes[(yyvsp[0].intval)]->entry_list;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2526 "parser.tab.c"
    break;

  case 17:
#line 743 "parser.y"
                                  { node_attr = {",", "typedarglist"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->entry_list = all_nodes[(yyvsp[-2].intval)]->entry_list; 
    all_nodes[(yyval.intval)]->entry_list.insert(all_nodes[(yyval.intval)]->entry_list.end(), all_nodes[(yyvsp[0].intval)]->entry_list.begin(), all_nodes[(yyvsp[0].intval)]->entry_list.end());
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2537 "parser.tab.c"
    break;

  case 18:
#line 750 "parser.y"
                                      {
    node_attr = {string("NAME ( ") + strdup((yyvsp[-2].strval)) + " )", ":", "tpdef"};
    node_numbers = {node_count, node_count + 1, (yyvsp[0].intval)};
    insert_node();
    (yyval.intval) = node_count + 2;
    if(string(strdup((yyvsp[-2].strval))) == "self") {
        cout << "Invalid type hint for self at " << yylineno << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup((yyvsp[-2].strval)), yylineno, yylineno, all_nodes[(yyvsp[0].intval)]->datatype);
    all_nodes[(yyval.intval)]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    if(all_nodes[(yyvsp[0].intval)]->datatype.length() >= 4 && all_nodes[(yyvsp[0].intval)]->datatype.substr(0,4) == "list") {
        all_nodes[(yyval.intval)]->entry_list[0]->dimensions = 1;
    }
    node_count += 3;
}
#line 2559 "parser.tab.c"
    break;

  case 19:
#line 767 "parser.y"
       {
    node_attr = {string("NAME ( ") + strdup((yyvsp[0].strval)) + " )", "tpdef"};
    node_numbers = {node_count};
    insert_node();
    (yyval.intval) = node_count + 1;
    if(string(strdup((yyvsp[0].strval))) != "self" || current_table -> symbol_table_category != 'C') {
        cout << "Parameter '" << strdup((yyvsp[0].strval)) << "' type not given at line " << yylineno << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup((yyvsp[0].strval)), yylineno, yylineno, current_table->name);
    all_nodes[(yyval.intval)]->entry_list = {new_entry};
    all_nodes[node_count]->datatype = current_table->name;
    node_count += 2;
}
#line 2578 "parser.tab.c"
    break;

  case 20:
#line 782 "parser.y"
                    {node_attr = {"blocks"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2586 "parser.tab.c"
    break;

  case 21:
#line 785 "parser.y"
                {node_attr = {"blocks"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2594 "parser.tab.c"
    break;

  case 22:
#line 789 "parser.y"
                                         { node_attr = {"single_stmt"}; node_numbers = {(yyvsp[-1].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 2602 "parser.tab.c"
    break;

  case 23:
#line 793 "parser.y"
                           {node_attr = {"semicolon_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2610 "parser.tab.c"
    break;

  case 24:
#line 796 "parser.y"
                             {node_attr = {";", "semicolon_stmt"}; node_numbers = {(yyvsp[-1].intval), node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 2618 "parser.tab.c"
    break;

  case 25:
#line 799 "parser.y"
                                            {node_attr = {";", "semicolon_stmt"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2627 "parser.tab.c"
    break;

  case 26:
#line 804 "parser.y"
                      {node_attr = {"small_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2635 "parser.tab.c"
    break;

  case 27:
#line 807 "parser.y"
            {node_attr = {"small_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count;  node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2643 "parser.tab.c"
    break;

  case 28:
#line 810 "parser.y"
              {node_attr = {"small_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2651 "parser.tab.c"
    break;

  case 29:
#line 814 "parser.y"
                            {node_attr = {"expr_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2659 "parser.tab.c"
    break;

  case 30:
#line 817 "parser.y"
                                     {node_attr = {"=", "expr_stmt"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype);
    string arg1 = all_nodes[(yyvsp[0].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyvsp[0].intval)], arg1);
    quad q("", "", "", "");
    if((all_nodes[(yyvsp[-2].intval)]->var)[0] == '*') {
        q = quad((all_nodes[(yyvsp[-2].intval)]->var).substr(1), arg1, "", "");
        q.make_code_from_store();
    }
    else {
        q = quad (all_nodes[(yyvsp[-2].intval)]->var, arg1, "=", "");
        q.make_code_from_assignment();
    }
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 2681 "parser.tab.c"
    break;

  case 31:
#line 834 "parser.y"
                          {node_attr = {"expr_stmt"}; node_numbers = {(yyvsp[-2].intval), (yyvsp[-1].intval), (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    string op = all_nodes[(yyvsp[-1].intval)]->name.substr(9);
    if(!all_nodes[(yyvsp[-2].intval)]->is_var) {
        cout << "Invalid left hand side of assignment at line " << yylineno << endl;
        exit(1);
    }
    if(op[0] == '+' || op[0] == '-' || op[0] == '*' || op[0] == '/') {
        check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, op);
    }
    else {
        check_type_int_bool(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, op);
    }
    
    op = op.substr(0, op.size() - 1);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    string arg1 = all_nodes[(yyvsp[-2].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    string arg2 = all_nodes[(yyvsp[0].intval)]->var_list[0];
    arg2 = check_star_and_make(all_nodes[(yyval.intval)], arg2);
    if((all_nodes[(yyvsp[-2].intval)] -> var)[0] == '*') {
        string tmp = get_new_temp();
        quad q(tmp, arg1, op, arg2);
        q.make_code_from_binary();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        q = quad((all_nodes[(yyvsp[-2].intval)] -> var).substr(1), tmp , "", "");
        q.make_code_from_store();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
    else{
        quad q(all_nodes[(yyvsp[-2].intval)] -> var, arg1, op, arg2);
        q.make_code_from_binary();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
}
#line 2721 "parser.tab.c"
    break;

  case 32:
#line 869 "parser.y"
                         {node_attr = {"=","expr_stmt"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    if(!all_nodes[(yyvsp[-2].intval)]->is_var) {
        cout << "Invalid left hand side of assignment at line " << yylineno << endl;
        exit(1);
    }
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    string arg1 = all_nodes[(yyvsp[0].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    quad q("", "", "", "");
    if((all_nodes[(yyvsp[-2].intval)]->var)[0]=='*') {
        q = quad((all_nodes[(yyvsp[-2].intval)]->var).substr(1), arg1, "", "");
        q.make_code_from_store();
    }
    else {
        q = quad(all_nodes[(yyvsp[-2].intval)]->var, arg1, "", "");
        q.make_code_from_assignment();
    }
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 2747 "parser.tab.c"
    break;

  case 33:
#line 890 "parser.y"
       {node_attr = {"expr_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2755 "parser.tab.c"
    break;

  case 34:
#line 894 "parser.y"
                                                {
    node_attr = {string("NAME ( ") + strdup((yyvsp[-2].strval)) + " )", ":", "type_declaration"};
    node_numbers = {node_count, node_count + 1, (yyvsp[0].intval)};
    insert_node(); 
    (yyval.intval) = node_count + 2;
    st_entry *entry = current_table -> look_up_local(strdup((yyvsp[-2].strval)));
    if(entry) {
        cout << "'" << strdup((yyvsp[-2].strval)) << "' already declared at line" << entry->line_no << endl;
        exit(1);
    }
    if(current_table->symbol_table_category == 'M') {
        if(current_table->name == strdup((yyvsp[-2].strval))) {
            cout << "Illegal declaration of '" << strdup((yyvsp[-2].strval)) << "' at line " << yylineno << "\n";
        }
    }
    else if(current_table->symbol_table_category == 'G') {
        string var_name = strdup((yyvsp[-2].strval));
        symbol_table_func* fnc =  global_table->look_up_func(var_name);
        symbol_table_class* cl =  global_table->look_up_class(var_name);
        if(fnc || cl) { 
            cout << "'" << strdup((yyvsp[-2].strval)) << "' already declared as " << (fnc ? "function" : "") << (cl ? "class" : "") << endl;
            exit(1);
        }
    }
    
    st_entry *new_entry = new st_entry(strdup((yyvsp[-2].strval)), yylineno, yylineno, all_nodes[(yyvsp[0].intval)]->datatype);
    if(current_table -> symbol_table_category == 'M') {
        new_entry ->mangled_name = ((symbol_table_func *)current_table) -> mangled_name + "@" + strdup((yyvsp[-2].strval));
    }
    else {
        new_entry -> mangled_name = strdup((yyvsp[-2].strval));
    }
    all_nodes[node_count]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    if(all_nodes[(yyvsp[0].intval)]->datatype.length() >= 4 && all_nodes[(yyvsp[0].intval)]->datatype.substr(0,4) == "list") {
        new_entry->dimensions = 1;
    }
    new_entry -> table = current_table;
    current_table -> add_entry(new_entry);
    node_count += 3;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    
    /* shrey - Declaration of variable is done by mangled name rather than only lexeme */
    // all_nodes[$$] -> var = strdup($1);
    all_nodes[(yyval.intval)] -> var = new_entry -> mangled_name;
    if(current_table->symbol_table_category == 'C') {
        new_entry -> offset = ((symbol_table_class *)(current_table->parent_st))->object_size;
        bool is_class = !is_not_class(all_nodes[(yyvsp[0].intval)]->datatype);
        if(!is_class) ((symbol_table_class *)(current_table->parent_st))->object_size += type_to_size[all_nodes[(yyvsp[0].intval)]->datatype];
        else ((symbol_table_class *)(current_table->parent_st))->object_size += 8;
    }
    all_nodes[(yyval.intval)]->sym_tab_entry = new_entry;
}
#line 2812 "parser.tab.c"
    break;

  case 35:
#line 946 "parser.y"
                                         {
    node_attr = {"self.", string("NAME ( ")+ strdup((yyvsp[-2].strval)) + " )", ":", "type_declaration"};
    node_numbers = {node_count, node_count + 1, node_count + 2, (yyvsp[0].intval)};
    if(current_table->symbol_table_category != 'M' || !(current_table->parent_st) || current_table->parent_st->symbol_table_category != 'C') {
        cout << "Invalid Declaration at line " << yylineno << ". Identifiers can only have letters, digits or _\n";
        exit(1);
    }
    insert_node();
    (yyval.intval) = node_count + 3;
    st_entry *entry = current_table -> parent_st -> look_up_local(strdup((yyvsp[-2].strval)));
    if(entry) {
        cout << "'" << strdup((yyvsp[-2].strval)) << "' attribute already declared at line " << entry->line_no << endl;
        exit(1);
    }
    st_entry *new_entry = new st_entry(strdup((yyvsp[-2].strval)), yylineno, yylineno, all_nodes[(yyvsp[0].intval)]->datatype);
    all_nodes[node_count]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    if(all_nodes[(yyvsp[0].intval)]->datatype.length() >= 4 && all_nodes[(yyvsp[0].intval)]->datatype.substr(0,4) == "list") {
        new_entry->dimensions = 1;
    }
    new_entry -> table = current_table -> parent_st;
    current_table -> parent_st -> add_entry(new_entry);
    node_count += 4;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->var = string("*( self + ") + to_string(((symbol_table_class *)(current_table->parent_st))->object_size) + " )";

    /*  chitwan  -- 3ac minor correctness assign *(self + offt) to some temporary first */
    string tmp = get_new_temp();
    quad q(tmp, "self" , "+", to_string(((symbol_table_class *)(current_table->parent_st))->object_size));
    q.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->var = "*" + tmp;
    /* chitwan --*/
    new_entry -> offset = ((symbol_table_class *)(current_table->parent_st))->object_size;
    bool is_class = !is_not_class(all_nodes[(yyvsp[0].intval)]->datatype);
    if(!is_class) ((symbol_table_class *)(current_table->parent_st))->object_size += type_to_size[all_nodes[(yyvsp[0].intval)]->datatype];
    else ((symbol_table_class *)(current_table->parent_st))->object_size += 8;
    all_nodes[(yyval.intval)]->sym_tab_entry = new_entry;
}
#line 2855 "parser.tab.c"
    break;

  case 36:
#line 985 "parser.y"
                            {node_attr = {"+=", "augassign+="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2861 "parser.tab.c"
    break;

  case 37:
#line 986 "parser.y"
                                 {node_attr = {"-=", "augassign-="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2867 "parser.tab.c"
    break;

  case 38:
#line 987 "parser.y"
                                 { node_attr = {"*=", "augassign*="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2873 "parser.tab.c"
    break;

  case 39:
#line 988 "parser.y"
                               {node_attr = {"/=", "augassign/="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2879 "parser.tab.c"
    break;

  case 40:
#line 989 "parser.y"
                               {node_attr = {"%=", "augassign%="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2885 "parser.tab.c"
    break;

  case 41:
#line 990 "parser.y"
                                    {node_attr = {"&=", "augassign&="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2891 "parser.tab.c"
    break;

  case 42:
#line 991 "parser.y"
                                   {node_attr = {"|=", "augassign|="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2897 "parser.tab.c"
    break;

  case 43:
#line 992 "parser.y"
                                    {node_attr = {"^=", "augassign^="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2903 "parser.tab.c"
    break;

  case 44:
#line 993 "parser.y"
                                   {node_attr = {"<<=", "augassign<<="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2909 "parser.tab.c"
    break;

  case 45:
#line 994 "parser.y"
                                    {node_attr = {">>=", "augassign>>="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2915 "parser.tab.c"
    break;

  case 46:
#line 995 "parser.y"
                              {node_attr = {"**=", "augassign**="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2921 "parser.tab.c"
    break;

  case 47:
#line 996 "parser.y"
                                     {node_attr = {"//=", "augassign//="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 2927 "parser.tab.c"
    break;

  case 48:
#line 998 "parser.y"
                      {node_attr = {"flow_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2935 "parser.tab.c"
    break;

  case 49:
#line 1001 "parser.y"
                {node_attr = {"flow_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2943 "parser.tab.c"
    break;

  case 50:
#line 1004 "parser.y"
              {node_attr = {"flow_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 2951 "parser.tab.c"
    break;

  case 51:
#line 1008 "parser.y"
                      {node_attr = {"break", "break_stmt"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2; 
    if(in_loop <= 0) {
        cout << "Use of break statement outside of for or while loop on line " << yylineno << endl;
        exit(1);
    }
    quad q("", "goto", "BREAK", "");
    q.code = "\t\tgoto BREAK;\n";
    q.made_from = quad::GOTO;
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 2966 "parser.tab.c"
    break;

  case 52:
#line 1019 "parser.y"
                            {node_attr = {"continue", "continue_stmt"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    if(in_loop <= 0) {
        cout << "Use of continue statement outside of for or while loop on line " << yylineno << endl;
        exit(1);
    }
    quad q("", "goto", "CONTINUE", "");
    q.code = "\t\tgoto CONTINUE;\n";
    q.made_from = quad::GOTO;
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 2981 "parser.tab.c"
    break;

  case 53:
#line 1030 "parser.y"
                             {node_attr = {"return", "return_stmt"}; node_numbers = {node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1;
    node_count += 2;
    check_return_type(all_nodes[(yyvsp[0].intval)]->datatype);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    string arg1 = all_nodes[(yyvsp[0].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    // quad q("", arg1, "push", "");
    // q.make_code_push_param();
    // all_nodes[$$]->ta_codes.push_back(q);
    quad q("", arg1, "return", "");
    q.make_code_from_return();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 2999 "parser.tab.c"
    break;

  case 54:
#line 1043 "parser.y"
             {node_attr = {"return", "return_stmt"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1;
    node_count += 2;
    check_return_type("None");
    quad q("", "", "return", "");
    q.make_code_from_return();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 3011 "parser.tab.c"
    break;

  case 55:
#line 1051 "parser.y"
                              {node_attr = {"global", "global_stmt"}; node_numbers = {node_count, (yyvsp[0].intval)};  insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    if(current_table -> symbol_table_category == 'M'){
        for(auto entry : all_nodes[(yyvsp[0].intval)]->entry_list){
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
#line 3033 "parser.tab.c"
    break;

  case 56:
#line 1069 "parser.y"
            {node_attr = {string("NAME ( ") + strdup((yyvsp[0].strval)) + " )", "names"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; 
    st_entry *entry = global_table -> look_up_local(strdup((yyvsp[0].strval)));
    if(!entry) {
        cout << "'" << strdup((yyvsp[0].strval)) << "' not a global variable ( at line number " << yylineno << " )\n";
        exit(1);
    }
    all_nodes[(yyval.intval)]->entry_list = {entry};
    all_nodes[node_count]->datatype = entry -> type;
    node_count += 2;
}
#line 3048 "parser.tab.c"
    break;

  case 57:
#line 1079 "parser.y"
                         {node_attr = {"NAME", ",", "names"}; node_numbers = {node_count+0,node_count + 1, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 2; 
    st_entry *entry = global_table -> look_up_local(strdup((yyvsp[-2].strval)));
    if(!entry) {
        cout << "'" << strdup((yyvsp[-2].strval)) << "' not a global variable at line number " << yylineno << endl;
        exit(1);
    }
    all_nodes[(yyval.intval)]->entry_list = all_nodes[(yyvsp[0].intval)]->entry_list;
    all_nodes[node_count]->datatype = entry -> type;
    all_nodes[(yyval.intval)]->entry_list.push_back(entry);
    node_count += 3;
}
#line 3064 "parser.tab.c"
    break;

  case 58:
#line 1091 "parser.y"
                       {node_attr = {"compound_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3072 "parser.tab.c"
    break;

  case 59:
#line 1094 "parser.y"
             {node_attr = {"compound_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3080 "parser.tab.c"
    break;

  case 60:
#line 1097 "parser.y"
           {node_attr = {"compound_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3088 "parser.tab.c"
    break;

  case 61:
#line 1100 "parser.y"
          {node_attr = {"compound_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3096 "parser.tab.c"
    break;

  case 62:
#line 1103 "parser.y"
           {node_attr = {"compound_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3104 "parser.tab.c"
    break;

  case 63:
#line 1106 "parser.y"
                {node_attr = {"compound_stmt"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3112 "parser.tab.c"
    break;

  case 64:
#line 1110 "parser.y"
                                                                         {node_attr = {"if", "__name__", "==", "__main__", ":", "program_start"}; node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 5;
    node_count += 6;
    quad q("", "", "", "");
    q.code = "program start: \n";
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3124 "parser.tab.c"
    break;

  case 65:
#line 1118 "parser.y"
                                                 {node_attr = {"if",":","if_stmt"}; node_numbers = {node_count, (yyvsp[-2].intval), node_count+1, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 2;
    node_count += 3;
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    string op = "if_false";
    string arg1 = all_nodes[(yyvsp[-2].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3142 "parser.tab.c"
    break;

  case 66:
#line 1132 "parser.y"
                                                    {node_attr = {"if",":","if_stmt"}; node_numbers = {node_count, (yyvsp[-3].intval), node_count+1, (yyvsp[-1].intval), (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 2;
    node_count += 3;
    is_compatible(all_nodes[(yyvsp[-3].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    string op = "if_false";
    string arg1 = all_nodes[(yyvsp[-3].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[-1].intval)]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    
    // arg1 = a
    op = "goto";
    arg1 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3168 "parser.tab.c"
    break;

  case 67:
#line 1154 "parser.y"
                                                                     {node_attr = {"if",":","else",":","if_stmt"}; node_numbers = {node_count, (yyvsp[-5].intval), node_count+1, (yyvsp[-3].intval), node_count+2, node_count + 3, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 4;
    node_count += 5;
    is_compatible(all_nodes[(yyvsp[-5].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-5].intval)]);
    string op = "if_false";
    string arg1 = all_nodes[(yyvsp[-5].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[-3].intval)]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);

    op = "goto";
    arg1 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3193 "parser.tab.c"
    break;

  case 68:
#line 1175 "parser.y"
                                                                               {node_attr = {"if",":","else",":","if_stmt"}; node_numbers = {node_count, (yyvsp[-6].intval), node_count+1, (yyvsp[-4].intval), (yyvsp[-3].intval), node_count+2, node_count + 3, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 4;
    node_count += 5;
    is_compatible(all_nodes[(yyvsp[-6].intval)]->datatype, "bool");
    
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-6].intval)]);
    string op = "if_false";
    string arg1 = all_nodes[(yyvsp[-6].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[-4].intval)]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-4].intval)]);
    
    // arg1 = a
    op = "goto";
    arg1 = "J+" + to_string(all_nodes[(yyvsp[-3].intval)]->ta_codes.size() + all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 2);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    /* chitwan */
    for(auto &qu: all_nodes[(yyvsp[-3].intval)]->ta_codes) {
        if(qu.op == "goto") { 
            qu.rel_jump += all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1;
        }
    }
    /* chitwan */
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    arg1 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1);
    q2 =  quad("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3232 "parser.tab.c"
    break;

  case 69:
#line 1210 "parser.y"
                                                     {node_attr = {"elif",":","elif_plus"}; node_numbers = {node_count, (yyvsp[-2].intval), node_count+1, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 2; node_count += 3;
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    string op = "if_false";
    string arg1 = all_nodes[(yyvsp[-2].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3249 "parser.tab.c"
    break;

  case 70:
#line 1223 "parser.y"
                                                      {node_attr = {"elif",":","elif_plus"}; node_numbers = {node_count, (yyvsp[-3].intval), node_count+1, (yyvsp[-1].intval), (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 2; node_count += 3;
    is_compatible(all_nodes[(yyvsp[-3].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    string op = "if_false";
    string arg1 = all_nodes[(yyvsp[-3].intval)]->var;
    arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[-1].intval)]->ta_codes.size() + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    // arg1 = a
    op = "goto";
    arg1 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3273 "parser.tab.c"
    break;

  case 71:
#line 1243 "parser.y"
                                                       {node_attr = {"while",":","while_stmt"}; node_numbers = {node_count, (yyvsp[-2].intval), node_count+1, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 2; node_count += 3;
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, "bool");
    int exp_size = all_nodes[(yyvsp[-2].intval)]->ta_codes.size();
    int stat_size = all_nodes[(yyvsp[0].intval)]->ta_codes.size();
    string arg1 = all_nodes[(yyvsp[-2].intval)]->var;
    arg1  = check_star_and_make(all_nodes[(yyvsp[-2].intval)], arg1);
    all_nodes[(yyval.intval)] -> append_tac(all_nodes[(yyvsp[-2].intval)]);
    string op = "if_false";
    string arg2 = "J+" + to_string(stat_size + 2);
    quad q("", arg1, op, arg2);
    q.make_code_from_conditional();
    all_nodes[(yyval.intval)] -> ta_codes.push_back(q);
    while_break_continue((yyvsp[0].intval), (yyval.intval));
    all_nodes[(yyval.intval)] -> append_tac(all_nodes[(yyvsp[0].intval)]);
    op = "goto";
    arg1 = "J-" + to_string(stat_size + exp_size + 1);
    quad q2("", arg1, op, "");
    q2.make_code_from_goto();
    all_nodes[(yyval.intval)] -> ta_codes.push_back(q2);
    in_loop--;
}
#line 3299 "parser.tab.c"
    break;

  case 72:
#line 1265 "parser.y"
                                                                                                  {node_attr = {"for","in", "range", "(", ")", ":","for_stmt"}; node_numbers = {node_count, (yyvsp[-7].intval), node_count+1, node_count + 2, node_count + 3, (yyvsp[-3].intval), node_count + 4 ,node_count + 5, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 6;
    node_count += 7;
    if(all_nodes[(yyvsp[-7].intval)]->datatype != "int") {        
        cout << "for loop ending at line " << yylineno << " has invalid iterator type\n";
        exit(1);
    }
    if(all_nodes[(yyvsp[-3].intval)]->datatype != "int") {
        cout << "for loop ending at line " << yylineno << " has invalid argument for range\n";
        exit(1);
    }
    string narg1 = all_nodes[(yyvsp[-7].intval)]->var;
    //narg1 = check_star_and_make(all_nodes[$2], narg1);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-7].intval)]);
    string narg2 = all_nodes[(yyvsp[-3].intval)]->var;
    narg2 = check_star_and_make(all_nodes[(yyvsp[-3].intval)], narg2);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    quad q(narg1, "0", "=", "");
    q.make_code_from_assignment();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    string tmp_var = get_new_temp();
    quad q1(tmp_var, narg1, "<", narg2);
    q1.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    string op = "if_false";
    string arg1 = tmp_var;
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 3);
    quad q2("", arg1, op, arg2);
    q2.make_code_from_conditional();
    all_nodes[(yyval.intval)] -> ta_codes.push_back(q2);
    for_break_continue((yyvsp[0].intval), (yyval.intval));
    op = "goto";
    arg1 = "J-" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 3);   // chitwan -- yha size+4 ki jgh 3 hoga as per examples check this once by running public1.py
    all_nodes[(yyval.intval)] -> append_tac(all_nodes[(yyvsp[0].intval)]);
    quad q4(narg1, narg1, "+", "1");
    q4.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q4);
    quad q3("", arg1, op, "");
    q3.make_code_from_goto();
    all_nodes[(yyval.intval)] -> ta_codes.push_back(q3);
    in_loop--;
}
#line 3345 "parser.tab.c"
    break;

  case 73:
#line 1307 "parser.y"
                                                                                                           {node_attr = {"for","in", "range", "(" , ",", ")", ":","for_stmt"}; node_numbers = {node_count, (yyvsp[-9].intval), node_count+1, node_count + 2, node_count + 3, (yyvsp[-5].intval), node_count+4, (yyvsp[-3].intval), node_count + 5, node_count + 6, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 7;
    node_count += 8;
    if(all_nodes[(yyvsp[-9].intval)]->datatype != "int") { 
        cout << "for loop ending at line " << yylineno << " has invalid iterator type\n";
        exit(1);
    }
    if(all_nodes[(yyvsp[-5].intval)]->datatype != "int" || all_nodes[(yyvsp[-3].intval)]->datatype != "int") {
        cout << "for loop ending at line " << yylineno << " has invalid argument(s) for range\n";
        exit(1);
    }
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-9].intval)]);
    string narg1 = all_nodes[(yyvsp[-5].intval)]->var;
    narg1 = check_star_and_make(all_nodes[(yyvsp[-5].intval)], narg1);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-5].intval)]);
    string narg2 = all_nodes[(yyvsp[-3].intval)]->var;
    narg2 = check_star_and_make(all_nodes[(yyvsp[-3].intval)], narg2);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    quad q(all_nodes[(yyvsp[-9].intval)]->var, narg1, "=", "");
    q.make_code_from_assignment();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    string temp_var = get_new_temp();
    quad q1(temp_var, all_nodes[(yyvsp[-9].intval)]->var, "<", narg2);
    q1.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    string op = "if_false";
    string arg1 = temp_var;
    /* shrey - Incorrect jump in for loop, change: size() + 2 -> size() + 3 */
    string arg2 = "J+" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 3);
    quad q2("", arg1, op, arg2);
    q2.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    for_break_continue((yyvsp[0].intval), (yyval.intval));
    /* shrey - Fixed order of code. Made it same as above */
    op = "goto";
    arg1 = "J-" + to_string(all_nodes[(yyvsp[0].intval)]->ta_codes.size() + 3);   // shrey -- yha size+4 ki jgh 3 hoga as per examples check this once by running test.py
    all_nodes[(yyval.intval)] -> append_tac(all_nodes[(yyvsp[0].intval)]);
    quad q4(all_nodes[(yyvsp[-9].intval)]->var, all_nodes[(yyvsp[-9].intval)]->var, "+", "1");
    q4.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q4);
    quad q3("", arg1, op, "");
    q3.make_code_from_goto();
    all_nodes[(yyval.intval)] -> ta_codes.push_back(q3);
    in_loop--;
}
#line 3394 "parser.tab.c"
    break;

  case 74:
#line 1352 "parser.y"
                   {(yyval.intval) = (yyvsp[0].intval);}
#line 3400 "parser.tab.c"
    break;

  case 75:
#line 1353 "parser.y"
                   {(yyval.intval) = (yyvsp[-1].intval); all_nodes[(yyval.intval)]->add_child(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3408 "parser.tab.c"
    break;

  case 76:
#line 1357 "parser.y"
                   {node_attr = {"suite"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 3416 "parser.tab.c"
    break;

  case 77:
#line 1360 "parser.y"
                                       {node_attr = {"suite"}; node_numbers = {(yyvsp[-1].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 3424 "parser.tab.c"
    break;

  case 78:
#line 1363 "parser.y"
                                                   {node_attr = {"suite"}; node_numbers = {(yyvsp[-2].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
}
#line 3432 "parser.tab.c"
    break;

  case 79:
#line 1367 "parser.y"
                     {node_attr = {"namedexpr_test"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
}
#line 3442 "parser.tab.c"
    break;

  case 80:
#line 1373 "parser.y"
              {node_attr = {"test"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count;
    node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    
}
#line 3455 "parser.tab.c"
    break;

  case 81:
#line 1382 "parser.y"
                  {node_attr = {"or_test"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; 
    node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
}
#line 3467 "parser.tab.c"
    break;

  case 82:
#line 1389 "parser.y"
                          {node_attr = {"or", "or_test"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; 
    node_count += 2;
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, "bool");
    is_compatible(all_nodes[(yyvsp[0].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->datatype = "bool";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "||", (yyval.intval));
}
#line 3479 "parser.tab.c"
    break;

  case 83:
#line 1397 "parser.y"
                   {node_attr = {"and_test"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1; all_nodes[(yyval.intval)] -> datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
}
#line 3489 "parser.tab.c"
    break;

  case 84:
#line 1402 "parser.y"
                            {node_attr = {"and", "and_test"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; 
    node_count += 2;
    is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, "bool");
    is_compatible(all_nodes[(yyvsp[0].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->datatype = "bool";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "&&", (yyval.intval));
}
#line 3501 "parser.tab.c"
    break;

  case 85:
#line 1410 "parser.y"
                           {node_attr = {"not", "not_test"}; node_numbers = {node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    is_compatible(all_nodes[(yyvsp[0].intval)]->datatype, "bool");
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    make_unary_threeac((yyvsp[0].intval), "!", (yyval.intval));
}
#line 3511 "parser.tab.c"
    break;

  case 86:
#line 1416 "parser.y"
             {node_attr = {"not_test"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3522 "parser.tab.c"
    break;

  case 87:
#line 1423 "parser.y"
                 {node_attr = {"comparison"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)] -> datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3533 "parser.tab.c"
    break;

  case 88:
#line 1429 "parser.y"
                          {node_attr = {"comparison"}; node_numbers = {(yyvsp[-2].intval), (yyvsp[-1].intval), (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 0;
    node_count += 1;
    string op = all_nodes[(yyvsp[-1].intval)]->name.substr(7);
    if(op == "in" || op == "not_in") {
        if(all_nodes[(yyvsp[-2].intval)]->datatype != all_nodes[(yyvsp[0].intval)]->datatype.substr(6, all_nodes[(yyvsp[0].intval)]->datatype.size() - 8)) {
            cout << "Type Error at line " << yylineno << endl;
            exit(1);
        }
    }
    else {
        is_compatible(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, true);
    }
    all_nodes[(yyval.intval)]->datatype = "bool";
    if(all_nodes[(yyvsp[-2].intval)]->datatype == "str") {   
        string arg1 = all_nodes[(yyvsp[-2].intval)]->var;
        arg1 = check_star_and_make(all_nodes[(yyvsp[-2].intval)], arg1);
        all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
        string arg2 = all_nodes[(yyvsp[0].intval)]->var;
        arg2 = check_star_and_make(all_nodes[(yyvsp[0].intval)], arg2);
        all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
        quad q("", arg1, "push_param", "");
        q.make_code_push_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        q = quad("", arg2, "push_param", "");
        q.make_code_push_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        q = quad("", "+", "", "");
        q.make_code_shift_pointer();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        q = quad("", "strcmp1", "call", "2");
        q.make_code_from_func_call();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        q = quad("", "-", "", "");
        q.make_code_shift_pointer();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
        string temp = get_new_temp();
        // q = quad(temp, "pop_param", "=", "");
        // q.make_code_from_assignment();
        q = quad(temp, "", "", "");
        q.make_code_from_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        all_nodes[(yyval.intval)]->var = get_new_temp();
        q = quad(all_nodes[(yyval.intval)]->var, temp, op, "0");
        q.make_code_from_binary();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
    else { 
        make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), op , (yyval.intval));
    }
}
#line 3588 "parser.tab.c"
    break;

  case 89:
#line 1480 "parser.y"
                      {node_attr = {"<", "comp_op<"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3594 "parser.tab.c"
    break;

  case 90:
#line 1481 "parser.y"
                         {node_attr = {">", "comp_op>"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3600 "parser.tab.c"
    break;

  case 91:
#line 1482 "parser.y"
                  {node_attr = {"==", "comp_op=="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3606 "parser.tab.c"
    break;

  case 92:
#line 1483 "parser.y"
                               {node_attr = {">=", "comp_op>="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3612 "parser.tab.c"
    break;

  case 93:
#line 1484 "parser.y"
                            {node_attr = {"<=", "comp_op<="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3618 "parser.tab.c"
    break;

  case 94:
#line 1485 "parser.y"
                      {node_attr = {"!=", "comp_op!="}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3624 "parser.tab.c"
    break;

  case 95:
#line 1486 "parser.y"
                {node_attr = {"in", "comp_opin"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 3630 "parser.tab.c"
    break;

  case 96:
#line 1487 "parser.y"
                        {node_attr = {"not", "in", "comp_opnot_in"}; node_numbers = {node_count, node_count + 1}; insert_node(); (yyval.intval) = node_count + 2; node_count += 3;}
#line 3636 "parser.tab.c"
    break;

  case 97:
#line 1489 "parser.y"
               {node_attr = {"expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3647 "parser.tab.c"
    break;

  case 98:
#line 1495 "parser.y"
                              {node_attr = {"|", "expr"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2; 
    check_type_int_bool(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    all_nodes[(yyval.intval)]->datatype = "int";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "|", (yyval.intval));
    
}
#line 3658 "parser.tab.c"
    break;

  case 99:
#line 1502 "parser.y"
                   {node_attr = {"xor_expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3669 "parser.tab.c"
    break;

  case 100:
#line 1508 "parser.y"
                                   {node_attr = {"^", "xor_expr"}; node_numbers = {(yyvsp[-2].intval), node_count + 0, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    all_nodes[(yyval.intval)]->datatype = "int";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "^", (yyval.intval));
}
#line 3679 "parser.tab.c"
    break;

  case 101:
#line 1514 "parser.y"
                     {node_attr = {"and_expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3690 "parser.tab.c"
    break;

  case 102:
#line 1520 "parser.y"
                                     {node_attr = {"&", "and_expr"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    all_nodes[(yyval.intval)]->datatype = "int";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "&", (yyval.intval));
}
#line 3700 "parser.tab.c"
    break;

  case 103:
#line 1526 "parser.y"
                       {node_attr = {"shift_expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3711 "parser.tab.c"
    break;

  case 104:
#line 1532 "parser.y"
                                      {node_attr = {"<<", "shift_expr"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    all_nodes[(yyval.intval)]->datatype = "int";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "<<", (yyval.intval));
}
#line 3721 "parser.tab.c"
    break;

  case 105:
#line 1537 "parser.y"
                                       {node_attr = {">>", "shift_expr"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    check_type_int_bool(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    all_nodes[(yyval.intval)]->datatype = "int";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), ">>", (yyval.intval));
    
}
#line 3732 "parser.tab.c"
    break;

  case 106:
#line 1544 "parser.y"
                 {node_attr = {"arith_expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3743 "parser.tab.c"
    break;

  case 107:
#line 1550 "parser.y"
                         {node_attr = {"+", "arith_expr"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1;
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "+", (yyval.intval));
    
}
#line 3755 "parser.tab.c"
    break;

  case 108:
#line 1557 "parser.y"
                              {node_attr = {"-", "arith_expr"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1;
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "-", (yyval.intval));
}
#line 3766 "parser.tab.c"
    break;

  case 109:
#line 1564 "parser.y"
             {node_attr = {"term"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3777 "parser.tab.c"
    break;

  case 110:
#line 1570 "parser.y"
                          {node_attr = {"*", "term"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "*", (yyval.intval));
}
#line 3786 "parser.tab.c"
    break;

  case 111:
#line 1574 "parser.y"
                        {node_attr = {"/", "term"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "/", (yyval.intval));
}
#line 3795 "parser.tab.c"
    break;

  case 112:
#line 1578 "parser.y"
                        {node_attr = {"%", "term"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "%", (yyval.intval));
}
#line 3804 "parser.tab.c"
    break;

  case 113:
#line 1582 "parser.y"
                              {node_attr = {"//", "term"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    all_nodes[(yyval.intval)]->datatype = "int";
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "//", (yyval.intval));
}
#line 3814 "parser.tab.c"
    break;

  case 114:
#line 1588 "parser.y"
                              {node_attr = {"~", "factor"}; node_numbers = {node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    if(all_nodes[(yyvsp[0].intval)]->datatype != "int" && all_nodes[(yyvsp[0].intval)]->datatype != "bool") {
        cout << "Bitwise not at line " << yylineno << ". Operand should be compatible to integer\n";
        exit(1);
    }
    all_nodes[(yyval.intval)]->datatype = "int";
    make_unary_threeac((yyvsp[0].intval), "~", (yyval.intval));
}
#line 3827 "parser.tab.c"
    break;

  case 115:
#line 1597 "parser.y"
                {node_attr = {"+", "factor"}; node_numbers = {node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    is_compatible(all_nodes[(yyvsp[0].intval)]->datatype, "int");
    all_nodes[(yyval.intval)]->datatype = (all_nodes[(yyvsp[0].intval)]->datatype == "float" ? "float":"int");
    make_unary_threeac((yyvsp[0].intval), "+", (yyval.intval));
}
#line 3837 "parser.tab.c"
    break;

  case 116:
#line 1603 "parser.y"
                     {node_attr = {"-", "factor"}; node_numbers = {node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    is_compatible(all_nodes[(yyvsp[0].intval)]->datatype, "int");
    all_nodes[(yyval.intval)]->datatype = (all_nodes[(yyvsp[0].intval)]->datatype == "float" ? "float":"int");
    make_unary_threeac((yyvsp[0].intval), "-", (yyval.intval));
}
#line 3847 "parser.tab.c"
    break;

  case 117:
#line 1609 "parser.y"
        {node_attr = {"factor"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)] -> datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3858 "parser.tab.c"
    break;

  case 118:
#line 1616 "parser.y"
                 {node_attr = {"power"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)] -> datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3869 "parser.tab.c"
    break;

  case 119:
#line 1623 "parser.y"
                            {node_attr = {"**", "power"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1;
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = check_type_arith(all_nodes[(yyvsp[-2].intval)]->datatype, all_nodes[(yyvsp[0].intval)]->datatype, strdup((yyvsp[-1].strval)));
    make_binary_threeac((yyvsp[-2].intval), (yyvsp[0].intval), "**", (yyval.intval));
}
#line 3879 "parser.tab.c"
    break;

  case 120:
#line 1629 "parser.y"
                { node_attr = {"atom_expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3890 "parser.tab.c"
    break;

  case 121:
#line 1636 "parser.y"
                 { node_attr = {"atom_expr"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    set_var_class_func((yyval.intval), (yyvsp[0].intval));
}
#line 3901 "parser.tab.c"
    break;

  case 122:
#line 1643 "parser.y"
                                                                {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {(yyvsp[-3].intval), node_count, (yyvsp[-1].intval), node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);  // chitwan -- missing tha ye
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-3].intval)], all_nodes[(yyvsp[-3].intval)]->datatype, "functrailer", "", all_nodes[(yyvsp[-1].intval)]->type_list);
    node_count += 3;
    if(all_nodes[(yyvsp[-3].intval)]->var == "print_str") {
        string arg1 = check_star_and_make(all_nodes[(yyval.intval)], all_nodes[(yyvsp[-1].intval)]->var_list[0]);
        quad q("", arg1, "", "");
        q.make_code_from_print_str();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
    else {
        if(all_nodes[(yyvsp[-3].intval)]->is_class_func != ""){
            string b = all_nodes[(yyvsp[-3].intval)]->is_class_func;
            b = check_star_and_make(all_nodes[(yyval.intval)], b);
            quad q0("", b , "push_param", "");
            q0.make_code_push_param();
            all_nodes[(yyval.intval)]->ta_codes.push_back(q0);
        }
        for(int i=0;i<all_nodes[(yyvsp[-1].intval)]->var_list.size();i++) {
            string arg1 = all_nodes[(yyvsp[-1].intval)]->var_list[i];
            arg1 = check_star_and_make(all_nodes[(yyval.intval)], arg1);
            quad q("", arg1, "push_param", "");
            q.make_code_push_param();
            all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        }
        int num_params = 0;
        if(all_nodes[(yyvsp[-3].intval)]->sym_tab_func) {
            num_params = all_nodes[(yyvsp[-3].intval)]->sym_tab_func->params.size();
        }
        quad q("", "+", "", "");
        q.make_code_shift_pointer();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        if(all_nodes[(yyvsp[-3].intval)]->var == "print_int" || all_nodes[(yyvsp[-3].intval)]->var == "print_bol" || all_nodes[(yyvsp[-3].intval)]->var == "print_flt") {
            all_nodes[(yyvsp[-3].intval)]->var = "print";
        }
        
        q = quad("", all_nodes[(yyvsp[-3].intval)]->var, "call", to_string(num_params));
        q.make_code_from_func_call();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        q = quad("", "-", "", "");
        q.make_code_shift_pointer();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
        if(all_nodes[(yyval.intval)]->datatype == "None" || all_nodes[(yyvsp[-3].intval)]->is_class) {
            quad q("", "", "", "");
            q.make_code_from_none_return_val();
            all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        }
        else {
            string temp = get_new_temp();
            quad q1(temp, "", "", "");
            q1.make_code_from_return_val();
            all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
            all_nodes[(yyval.intval)]->var = temp;
        }
    }
}
#line 3963 "parser.tab.c"
    break;

  case 123:
#line 1701 "parser.y"
                                          {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {(yyvsp[-2].intval), node_count, node_count + 1}; insert_node(); (yyval.intval) = node_count + 2; 
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]); // chitwan -- ye missing tha
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-2].intval)],all_nodes[(yyvsp[-2].intval)]->datatype, "functrailer");
    node_count += 3;
    if(all_nodes[(yyvsp[-2].intval)]->is_class_func != ""){
        string b = all_nodes[(yyvsp[-2].intval)]->is_class_func;
        b = check_star_and_make(all_nodes[(yyval.intval)], b);
        quad q0("", b , "push_param", "");
        q0.make_code_push_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q0);
    }
    int num_params = 0;
    if(all_nodes[(yyvsp[-2].intval)]->sym_tab_func) {
        num_params = all_nodes[(yyvsp[-2].intval)]->sym_tab_func->params.size();
    }
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    q = quad("", all_nodes[(yyvsp[-2].intval)]->var, "call", to_string(num_params));
    q.make_code_from_func_call();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    if(all_nodes[(yyval.intval)]->datatype == "None" || all_nodes[(yyvsp[-2].intval)]->is_class) {
        quad q("", "", "", "");
        q.make_code_from_none_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        all_nodes[(yyval.intval)]->var = "__t" + to_string(temp_count - 1);
    }
    else{
        string temp = get_new_temp();
        quad q1(temp, "", "", "");
        q1.make_code_from_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
        all_nodes[(yyval.intval)]->var = temp;
    }
}
#line 4006 "parser.tab.c"
    break;

  case 124:
#line 1740 "parser.y"
                                                   {node_attr = {"[", "]", "trailored_atom"}; node_numbers = {(yyvsp[-3].intval), node_count, (yyvsp[-1].intval), node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    if(all_nodes[(yyvsp[-1].intval)]->datatype != "int") {
        cout << "Type mismatch at line " << yylineno << ". List index should be an integer\n";
        exit(1);
    }
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-3].intval)],all_nodes[(yyvsp[-3].intval)]->datatype, "list_subs");
    node_count += 3;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    string temp = get_new_temp();
    string narg1 = all_nodes[(yyvsp[-3].intval)]->var;
    narg1 = check_star_and_make(all_nodes[(yyval.intval)], narg1);
    quad q(temp, narg1, "=", "");
    q.make_code_from_assignment();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    string narg2 = all_nodes[(yyvsp[-1].intval)]->var;
    narg2 = check_star_and_make(all_nodes[(yyval.intval)], narg2);
    string temp1 = get_new_temp();
    quad q1(temp1, temp, "", "");
    q1.make_code_from_load();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    string temp2 = get_new_temp();
    quad q2(temp2, narg2, ">=", temp1);   // chitwan -- pehle ye >= ki jgh < tha
    q2.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    
    string op = "if_false";
    string arg2 = "J+2";
    quad q3("", temp2, op, arg2);
    q3.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q3);
    quad q4("", "", "", "");
    q4.code = "\t\texit_out_of_bound\n";
    q4.made_from = quad::EXIT;
    all_nodes[(yyval.intval)]->ta_codes.push_back(q4);
    // temp is the base address excluding size; temp1 is useless at this point
    string type = all_nodes[(yyvsp[-3].intval)]->datatype.substr(6, all_nodes[(yyvsp[-3].intval)]->datatype.size() - 8);
    int size = type_to_size[type];
    if(!is_not_class(type)) {
        size = 8;
    }
    quad q5(temp1, narg2 , "*", to_string(size));   // [4i] => 4*i
    q5.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q5);
    quad q6(temp1, temp1 , "+", "8");  // bypassing the size thing   + 8
    q6.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q6);  
    quad q7(temp1, temp , "+", temp1);   // base + 8 + 4 * i
    q7.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q7);
    string t = get_new_temp();
    /* shrey - Changing temp for a[i] */
    all_nodes[(yyval.intval)]->var = "*" + temp1;
    all_nodes[(yyval.intval)]->is_var = true;
}
#line 4066 "parser.tab.c"
    break;

  case 125:
#line 1796 "parser.y"
                      {node_attr = {".", string("NAME ( ") + strdup((yyvsp[-1].strval)) + " )", "trailored_atom"}; node_numbers = {(yyvsp[-2].intval), node_count, node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);   // chitwan -- 
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-2].intval)],all_nodes[(yyvsp[-2].intval)]->datatype, "objattribute", strdup((yyvsp[0].strval)));
    node_count += 3;
    // done in set trailer type
}
#line 4077 "parser.tab.c"
    break;

  case 126:
#line 1802 "parser.y"
                                                            {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {(yyvsp[-3].intval), node_count, (yyvsp[-1].intval), node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]); // chitwan -- ye missing tha
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-3].intval)],all_nodes[(yyvsp[-3].intval)]->datatype, "functrailer", "", all_nodes[(yyvsp[-1].intval)]->type_list);
    node_count += 3;
    if(all_nodes[(yyvsp[-3].intval)]->is_class_func != ""){
        string b = all_nodes[(yyvsp[-3].intval)]->is_class_func;
        b = check_star_and_make(all_nodes[(yyval.intval)], b);
        quad q0("", b , "push_param", "");
        q0.make_code_push_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q0);
    }
    for(int i=0;i<all_nodes[(yyvsp[-1].intval)]->var_list.size();i++){
    // for(int i=all_nodes[$3]->var_list.size()-1;i>=0;i--){
        string arg1 = all_nodes[(yyvsp[-1].intval)]->var_list[i];
        arg1  = check_star_and_make(all_nodes[(yyval.intval)], arg1);
        quad q("", arg1, "push_param", "");
        q.make_code_push_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
    int num_params = 0;
    if(all_nodes[(yyvsp[-3].intval)]->sym_tab_func) {
        num_params = all_nodes[(yyvsp[-3].intval)]->sym_tab_func->params.size();
    }
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    q = quad("", all_nodes[(yyvsp[-3].intval)]->var, "call", to_string(num_params));
    q.make_code_from_func_call();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    if(all_nodes[(yyval.intval)]->datatype == "None" || all_nodes[(yyvsp[-3].intval)]->is_class) {
        quad q("", "", "", "");
        q.make_code_from_none_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
    else{
        string temp = get_new_temp();
        quad q1(temp, "", "", "");
        q1.make_code_from_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
        all_nodes[(yyval.intval)]->var = temp;
    }
}
#line 4128 "parser.tab.c"
    break;

  case 127:
#line 1848 "parser.y"
                                                    {node_attr = {"(", ")", "trailored_atom"}; node_numbers = {(yyvsp[-2].intval), node_count, node_count+1}; insert_node(); (yyval.intval) = node_count + 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]); // chitwan -- ye missing tha
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-2].intval)],all_nodes[(yyvsp[-2].intval)]->datatype, "functrailer");
    node_count += 3;
    if(all_nodes[(yyvsp[-2].intval)]->is_class_func != ""){
        string b = all_nodes[(yyvsp[-2].intval)]->is_class_func;
        b = check_star_and_make(all_nodes[(yyval.intval)], b);
        quad q0("", b , "push_param", "");
        q0.make_code_push_param();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q0);
    }
    int num_params = 0;
    if(all_nodes[(yyvsp[-2].intval)]->sym_tab_func) {
        num_params = all_nodes[(yyvsp[-2].intval)]->sym_tab_func->params.size();
    }
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    q = quad("", all_nodes[(yyvsp[-2].intval)]->var, "call", to_string(num_params));
    q.make_code_from_func_call();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    if(all_nodes[(yyval.intval)]->datatype == "None" || all_nodes[(yyvsp[-2].intval)]->is_class) {
        quad q("", "", "", "");
        q.make_code_from_none_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        all_nodes[(yyval.intval)]->var = "__t" + to_string(temp_count - 1);
    }
    else{
        string temp = get_new_temp();
        quad q1(temp, "", "", "");
        q1.make_code_from_return_val();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
        all_nodes[(yyval.intval)]->var = temp;
    }
}
#line 4171 "parser.tab.c"
    break;

  case 128:
#line 1886 "parser.y"
                                                             {node_attr = {"[", "]", "trailored_atom"}; node_numbers = {(yyvsp[-3].intval), node_count, (yyvsp[-1].intval), node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    if(all_nodes[(yyvsp[-1].intval)]->datatype != "int") {
        cout << "Type mismatch at line " << yylineno << ". List index should be an integer\n";
        exit(1);
    }
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-3].intval)],all_nodes[(yyvsp[-3].intval)]->datatype, "list_subs");
    node_count += 3;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-3].intval)]);
    string temp = get_new_temp();
    string narg1 = all_nodes[(yyvsp[-3].intval)]->var;
    narg1 = check_star_and_make(all_nodes[(yyval.intval)], narg1);
    quad q(temp, narg1, "=", "");
    q.make_code_from_assignment();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    string narg2 = all_nodes[(yyvsp[-1].intval)]->var;
    narg2 = check_star_and_make(all_nodes[(yyval.intval)], narg2);
    string temp1 = get_new_temp();
    quad q1(temp1, temp, "", "");
    q1.make_code_from_load();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    string temp2 = get_new_temp();
    quad q2(temp2, narg2, ">=", temp1);   // chitwan -- pehle ye >= ki jgh < tha
    q2.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    
    string op = "if_false";
    string arg2 = "J+2";
    quad q3("", temp2, op, arg2);
    q3.make_code_from_conditional();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q3);
    quad q4("", "", "", "");
    q4.code = "\t\texit_out_of_bound\n";
    q4.made_from = quad::EXIT;
    all_nodes[(yyval.intval)]->ta_codes.push_back(q4);
    // temp is the base address excluding size; temp1 is useless at this point
    string type = all_nodes[(yyvsp[-3].intval)]->datatype.substr(6, all_nodes[(yyvsp[-3].intval)]->datatype.size() - 8);
    int size = type_to_size[type];
    if(!is_not_class(type)) {
        size = 8;
    }
    quad q5(temp1, narg2 , "*", to_string(size));   // [4i] => 4*i
    q5.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q5);
    quad q6(temp1, temp1 , "+", "8");  // bypassing the size thing   + 8
    q6.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q6);  
    quad q7(temp1, temp , "+", temp1);   // base + 8 + 4 * i
    q7.make_code_from_binary();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q7);
    string t = get_new_temp();
    /* shrey - Changing temp for a[i] */
    all_nodes[(yyval.intval)]->var = "*" + temp1;
    all_nodes[(yyval.intval)]->is_var = true;
}
#line 4231 "parser.tab.c"
    break;

  case 129:
#line 1942 "parser.y"
                                {node_attr = {".", string("NAME ( ") + strdup((yyvsp[-1].strval)) + " )", "trailored_atom"}; node_numbers = {(yyvsp[-2].intval) ,node_count, node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);   // chitwan ---
    all_nodes[(yyval.intval)]->datatype = set_trailer_type_compatibility((yyval.intval), all_nodes[(yyvsp[-2].intval)],all_nodes[(yyvsp[-2].intval)]->datatype, "objattribute", strdup((yyvsp[0].strval)));
    node_count += 3;
    // done in set trailer type
}
#line 4242 "parser.tab.c"
    break;

  case 130:
#line 1949 "parser.y"
                                              {node_attr = {"(", ")", "atom"}; node_numbers = {node_count, (yyvsp[-1].intval), node_count + 1}; insert_node(); (yyval.intval) = node_count + 2;
    node_count += 3;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[-1].intval)]->datatype;
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[-1].intval)]->var;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
    set_var_class_func((yyval.intval), (yyvsp[-1].intval));
}
#line 4254 "parser.tab.c"
    break;

  case 131:
#line 1957 "parser.y"
                                                  {node_attr = {"[", "]", "atom"}; node_numbers = {node_count, (yyvsp[-1].intval), node_count+1}; insert_node(); (yyval.intval) = node_count + 2;
    node_count += 3;
    int size = type_to_size[all_nodes[(yyvsp[-1].intval)]->datatype];
    if(!is_not_class(all_nodes[(yyvsp[-1].intval)]->datatype)) {
        size = 8;
    }
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);   // chitwan -- ye missing tha
    all_nodes[(yyval.intval)]->datatype = "list[ " + all_nodes[(yyvsp[-1].intval)]->datatype + " ]";
    all_nodes[(yyval.intval)]->var = get_new_temp();
    quad q0("", to_string(all_nodes[(yyvsp[-1].intval)]->var_list.size() * size + 8) , "push_param", "");
    q0.make_code_push_param();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q0);  
    quad q("", "+", "", "");
    q.make_code_shift_pointer();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    q = quad("", "allocmem", "call", "1");
    q.make_code_from_func_call();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    q = quad("", "-", "", "");
    q.make_code_shift_pointer(); 
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);  
    quad q2(all_nodes[(yyval.intval)]->var, "", "", "");
    q2.make_code_from_return_val();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q2);
    
    quad q1(string(all_nodes[(yyval.intval)]->var), to_string(all_nodes[(yyvsp[-1].intval)]->var_list.size()), "", "");
    q1.make_code_from_store();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q1);
    for(int i = 0; i < all_nodes[(yyvsp[-1].intval)]->var_list.size(); i++) {
        string tmp = get_new_temp();
        quad q(tmp, all_nodes[(yyval.intval)]->var, "+", to_string(8 + size * i ));
        q.make_code_from_binary();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
        string argument = all_nodes[(yyvsp[-1].intval)]->var_list[i];
        argument = check_star_and_make(all_nodes[(yyval.intval)], argument);
        q = quad(tmp, argument, "", "");
        q.make_code_from_store();
        all_nodes[(yyval.intval)]->ta_codes.push_back(q);
    }
}
#line 4299 "parser.tab.c"
    break;

  case 132:
#line 1998 "parser.y"
       {node_attr = {string("NAME ( ") + strdup((yyvsp[0].strval)) + " )", "atom"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; 
    all_nodes[(yyval.intval)]->datatype = check_decl_before_use(strdup((yyvsp[0].strval)), all_nodes[(yyval.intval)]);
    node_count += 2;
}
#line 4308 "parser.tab.c"
    break;

  case 133:
#line 2003 "parser.y"
         {node_attr = {"atom"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
}
#line 4317 "parser.tab.c"
    break;

  case 134:
#line 2008 "parser.y"
                 {node_attr = {string("STR ") + strdup((yyvsp[0].strval)), "atom"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->datatype = "str";
    string str = strdup((yyvsp[0].strval));
    if(str[0] == '\'') {
        str = "\"" + str.substr(1, str.size() - 2) + "\"";
    }
    string temp = get_new_str_temp();
    all_nodes[(yyval.intval)]->var = get_new_temp();
    string_list[temp] = str;
    quad q(all_nodes[(yyval.intval)]->var, temp, "", "");
    q.make_code_from_new_str();
    all_nodes[(yyval.intval)]->ta_codes.push_back(q);
}
#line 4335 "parser.tab.c"
    break;

  case 135:
#line 2022 "parser.y"
                 {node_attr = {"...", "atom"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;}
#line 4341 "parser.tab.c"
    break;

  case 136:
#line 2024 "parser.y"
           {node_attr = {"None", "atom"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->datatype = "None";
    all_nodes[(yyval.intval)]->var = strdup((yyvsp[0].strval));
}
#line 4350 "parser.tab.c"
    break;

  case 137:
#line 2029 "parser.y"
           {node_attr = {string("BOL ") + strdup((yyvsp[0].strval)), "atom"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2; all_nodes[(yyval.intval)]->datatype = "bool";
    all_nodes[(yyval.intval)]->var = "1";
}
#line 4358 "parser.tab.c"
    break;

  case 138:
#line 2032 "parser.y"
            {node_attr = {string("BOL ") + strdup((yyvsp[0].strval)), "atom"}; node_numbers = {node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;all_nodes[(yyval.intval)]->datatype = "bool";
    all_nodes[(yyval.intval)]->var = "0";
}
#line 4366 "parser.tab.c"
    break;

  case 139:
#line 2035 "parser.y"
        {node_attr = {"atom"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1; all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;}
#line 4372 "parser.tab.c"
    break;

  case 140:
#line 2037 "parser.y"
                {node_attr = {"self.", string("NAME ( ") + strdup((yyvsp[0].strval)) + " )", "atom"}; node_numbers =   {node_count, node_count+1}; insert_node(); (yyval.intval) = node_count + 2;
    node_count += 3;
    all_nodes[(yyval.intval)]->datatype = check_self_decl_before_use(strdup((yyvsp[0].strval)), all_nodes[(yyval.intval)]);
    string name = strdup((yyvsp[0].strval));
    st_entry *curr_entry = ((symbol_table_class *)(current_table->parent_st)) -> look_up_attribute_in_class_hierarchy(name);
}
#line 4383 "parser.tab.c"
    break;

  case 141:
#line 2044 "parser.y"
                {
    node_attr = {string("INT ") + strdup((yyvsp[0].strval)), "number"};
    node_numbers = {node_count};
    insert_node();
    (yyval.intval) = node_count + 1;
    all_nodes[(yyval.intval)]->datatype = "int";
    node_count += 2;
    all_nodes[(yyval.intval)]->var = strdup((yyvsp[0].strval));
}
#line 4397 "parser.tab.c"
    break;

  case 142:
#line 2053 "parser.y"
               {
    node_attr = {string("FLT ") + strdup((yyvsp[0].strval)), "number"};
    node_numbers = {node_count};
    insert_node();
    (yyval.intval) = node_count + 1;
    all_nodes[(yyval.intval)]->datatype = "float";
    node_count += 2;
    all_nodes[(yyval.intval)]->var = strdup((yyvsp[0].strval));
}
#line 4411 "parser.tab.c"
    break;

  case 143:
#line 2063 "parser.y"
               {node_attr = {"testlist"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)] -> datatype = all_nodes[(yyvsp[0].intval)] -> datatype;
    all_nodes[(yyval.intval)] -> var_list = {all_nodes[(yyvsp[0].intval)] -> var};
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4421 "parser.tab.c"
    break;

  case 144:
#line 2068 "parser.y"
                            {node_attr = {",", "testlist"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    is_compatible(all_nodes[(yyvsp[-2].intval)] -> datatype, all_nodes[(yyvsp[0].intval)] -> datatype);
    all_nodes[(yyval.intval)] -> datatype = max_type(all_nodes[(yyvsp[-2].intval)] -> datatype, all_nodes[(yyvsp[0].intval)] -> datatype);
    all_nodes[(yyval.intval)]->var_list = {all_nodes[(yyvsp[-2].intval)]->var};
    all_nodes[(yyval.intval)]->var_list.insert(all_nodes[(yyval.intval)]->var_list.end(), all_nodes[(yyvsp[0].intval)]->var_list.begin(), all_nodes[(yyvsp[0].intval)]->var_list.end());
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4434 "parser.tab.c"
    break;

  case 145:
#line 2076 "parser.y"
                   {node_attr = {",", "testlist"}; node_numbers = {(yyvsp[-1].intval), node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)] -> datatype = all_nodes[(yyvsp[-1].intval)] -> datatype;
    all_nodes[(yyval.intval)]->var_list.push_back(all_nodes[(yyvsp[-1].intval)]->var);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 4444 "parser.tab.c"
    break;

  case 146:
#line 2082 "parser.y"
                             {
    node_attr = {"classdef"};
    node_numbers = {(yyvsp[-1].intval), (yyvsp[0].intval)};
    insert_node();
    (yyval.intval) =  node_count;
    node_count += 1;
    type_to_size[current_table -> name] = ((symbol_table_class *)current_table) -> object_size;
    type_to_size["list[ " + current_table -> name + " ]"] = 8;
    current_table = current_table->parent_st;
    all_nodes[(yyval.intval)] -> append_tac(all_nodes[(yyvsp[-1].intval)]);
    all_nodes[(yyval.intval)] -> append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4461 "parser.tab.c"
    break;

  case 147:
#line 2095 "parser.y"
                                                                                 {
    node_attr = {"class", string("NAME ( ") + strdup((yyvsp[-4].strval)) + " )", "(", string("NAME ( ") + strdup((yyvsp[-2].strval)) + " )", ")", ":", "class_header"};
    node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4, node_count + 5};
    insert_node();
    (yyval.intval) = node_count + 6;
    node_count += 7;
    make_new_class_symbtab(strdup((yyvsp[-4].strval)), strdup((yyvsp[-2].strval)));
}
#line 4474 "parser.tab.c"
    break;

  case 148:
#line 2103 "parser.y"
                                                                {
    node_attr = {"class", string("NAME ( ") + strdup((yyvsp[-3].strval)) + " )", "(", ")", ":", "class_header"};
    node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3, node_count + 4};
    insert_node();
    (yyval.intval) = node_count + 5;
    node_count += 6;
    make_new_class_symbtab(strdup((yyvsp[-3].strval)));
}
#line 4487 "parser.tab.c"
    break;

  case 149:
#line 2111 "parser.y"
                             {
    node_attr = {"class", string("NAME ( ") + strdup((yyvsp[-1].strval)) + " )", ":", "class_header"};
    node_numbers = {node_count, node_count + 1, node_count + 2};
    insert_node();
    (yyval.intval) = node_count + 3;
    node_count += 4;
    make_new_class_symbtab(strdup((yyvsp[-1].strval)));
}
#line 4500 "parser.tab.c"
    break;

  case 150:
#line 2120 "parser.y"
                  {node_attr = {"arglist"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1; 
    all_nodes[(yyval.intval)]->type_list.push_back(all_nodes[(yyvsp[0].intval)]->datatype);
    all_nodes[(yyval.intval)]->var_list.push_back(all_nodes[(yyvsp[0].intval)]->var);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4510 "parser.tab.c"
    break;

  case 151:
#line 2125 "parser.y"
                               {node_attr = {",", "arglist"}; node_numbers = {(yyvsp[-2].intval), node_count, (yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->type_list = {all_nodes[(yyvsp[-2].intval)]->datatype};
    all_nodes[(yyval.intval)]->type_list.insert(all_nodes[(yyval.intval)]->type_list.end(), all_nodes[(yyvsp[0].intval)]->type_list.begin(), all_nodes[(yyvsp[0].intval)]->type_list.end());
    all_nodes[(yyval.intval)]->var_list = {all_nodes[(yyvsp[-2].intval)]->var};
    all_nodes[(yyval.intval)]->var_list.insert(all_nodes[(yyval.intval)]->var_list.end(), all_nodes[(yyvsp[0].intval)]->var_list.begin(), all_nodes[(yyvsp[0].intval)]->var_list.end());
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4523 "parser.tab.c"
    break;

  case 152:
#line 2133 "parser.y"
                       {node_attr = {",", "arglist"}; node_numbers = {(yyvsp[-1].intval), node_count}; insert_node(); (yyval.intval) = node_count + 1; node_count += 2;
    all_nodes[(yyval.intval)]->type_list.push_back(all_nodes[(yyvsp[-1].intval)]->datatype);
    all_nodes[(yyval.intval)]->var_list.push_back(all_nodes[(yyvsp[-1].intval)]->var);
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 4533 "parser.tab.c"
    break;

  case 153:
#line 2139 "parser.y"
               {node_attr = {"argument"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)] -> datatype;
    all_nodes[(yyval.intval)]->var = all_nodes[(yyvsp[0].intval)]->var;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4543 "parser.tab.c"
    break;

  case 154:
#line 2145 "parser.y"
                             {node_attr = {"func_body_suite"}; node_numbers = {(yyvsp[0].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[0].intval)]);
}
#line 4551 "parser.tab.c"
    break;

  case 155:
#line 2148 "parser.y"
                                        {node_attr = {"func_body_suite"}; node_numbers = {(yyvsp[-1].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-1].intval)]);
}
#line 4559 "parser.tab.c"
    break;

  case 156:
#line 2151 "parser.y"
                                                     {node_attr = {"func_body_suite"}; node_numbers = {(yyvsp[-2].intval)}; insert_node(); (yyval.intval) = node_count; node_count += 1;
    all_nodes[(yyval.intval)]->append_tac(all_nodes[(yyvsp[-2].intval)]);
}
#line 4567 "parser.tab.c"
    break;

  case 157:
#line 2155 "parser.y"
                {
    node_attr = {"int", "types"};
    node_numbers = {node_count};
    insert_node();
    (yyval.intval) = node_count + 1;
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = "int";
}
#line 4580 "parser.tab.c"
    break;

  case 158:
#line 2163 "parser.y"
            {
    node_attr = {"bool", "types"};
    node_numbers = {node_count};
    insert_node();
    (yyval.intval) = node_count + 1;
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = "bool";
}
#line 4593 "parser.tab.c"
    break;

  case 159:
#line 2171 "parser.y"
             {
    node_attr = {"float", "types"}; 
    node_numbers = {node_count}; 
    insert_node(); 
    (yyval.intval) = node_count + 1; 
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = "float";
}
#line 4606 "parser.tab.c"
    break;

  case 160:
#line 2179 "parser.y"
            {
    node_attr = {"types"};
    node_numbers = {(yyvsp[0].intval)};
    insert_node();
    (yyval.intval) = node_count;
    node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
}
#line 4619 "parser.tab.c"
    break;

  case 161:
#line 2187 "parser.y"
              {
    node_attr = {"str", "types"}; 
    node_numbers = {node_count}; 
    insert_node(); 
    (yyval.intval) = node_count + 1; 
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = "str";
}
#line 4632 "parser.tab.c"
    break;

  case 162:
#line 2196 "parser.y"
                                                                  {
    node_attr = {"list", "[", "]", "type_list"};
    node_numbers = {node_count, node_count + 1, (yyvsp[-1].intval), node_count + 2};
    insert_node();
    (yyval.intval) = node_count + 3;
    node_count += 4;
    all_nodes[(yyval.intval)]->datatype = "list[ " + all_nodes[(yyvsp[-1].intval)]->datatype + " ]";
}
#line 4645 "parser.tab.c"
    break;

  case 163:
#line 2204 "parser.y"
                                                        {
    node_attr = {"list", "[", string("NAME ( ") + strdup((yyvsp[-1].strval)) + " )", "]", "type_list"}; 
    node_numbers = {node_count, node_count + 1, node_count + 2, node_count + 3};
    insert_node();
    (yyval.intval) = node_count + 4;
    node_count += 5;
    all_nodes[(yyval.intval)]->datatype = string("list[ ") + strdup((yyvsp[-1].strval)) + " ]";
}
#line 4658 "parser.tab.c"
    break;

  case 164:
#line 2213 "parser.y"
                    {
    node_attr = {"type_or_name"};
    node_numbers = {(yyvsp[0].intval)};
    insert_node();
    (yyval.intval) = node_count;
    node_count += 1;
    all_nodes[(yyval.intval)]->datatype = all_nodes[(yyvsp[0].intval)]->datatype;
}
#line 4671 "parser.tab.c"
    break;

  case 165:
#line 2221 "parser.y"
       {
    node_attr = {string("NAME ( ") + strdup((yyvsp[0].strval)) + " )", "type_or_name"};
    node_numbers = {node_count};
    insert_node();
    (yyval.intval) = node_count + 1;
    node_count += 2;
    all_nodes[(yyval.intval)]->datatype = strdup((yyvsp[0].strval));
}
#line 4684 "parser.tab.c"
    break;


#line 4688 "parser.tab.c"

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
#line 2230 "parser.y"


int main(int argc, char* argv[]) {
    current_table = global_table;
    temp_table = NULL;
    bool help_flag = false;
    bool print_symbtab = false;
    string input_file = "";
    string output_file = "code.s";

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
        if(s == "--symbtab") {
            print_symbtab = true;
        }
        if(s == "--no-save-temps") {
            // Do nothing
        }
        if(s.length() <= 7) {
            cerr << "Wrong flag used!!" << endl;
            cout << endl;
            print_help();
            exit(1);
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
            exit(1);
        }
    }

    if(!help_flag && input_file.empty()) {
        cout << "Input file not specified!" << endl;
        cout << endl;
        print_help();
        exit(1);
    }

    if(help_flag) {
        print_help();
    }
    
    if(input_file == "") {
        exit(1);
    }
    
    if(input_file != "") {
        freopen(input_file.c_str(), "r", stdin);
    }

    global_table->add_Print();
    global_table->add_Len();
    yyparse();
    
    root_node = all_nodes.back();

    if(print_symbtab) {
        global_table->make_csv_wrapper("st.csv");
    }
    
    ins_count = 1; 
    root_node->print_tac("3AC.txt");
    task_struct* gen = new task_struct();
    gen->gen_global();
    gen->gen_text(); 

    gen->print_code(output_file);
    return 0;
}

void yyerror(const char* s)  {
    cerr << "\n************************ ERROR ********************************\n" << endl;
    cerr << "Error at line number: " << yylineno << endl;
    cerr << "Error: " << s << endl;
    cerr << "\n***************************************************************\n" << endl;
};
