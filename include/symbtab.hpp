#ifndef SYMBTAB_HPP
#define SYMBTAB_HPP

#include <bits/stdc++.h>
using namespace std;

class symbol_table;

class st_entry {
public:
    int line_no;
    int size;
    bool is_global = false;
    int offset = 0; // offset for field declarations 
    int dimensions = 0;
    bool initialized = false;   // FIELD DECLARATIONS are initialized with default values
    string str_var = "";
    string name;
    string mangled_name;
    string type;
    symbol_table* table;
    
    st_entry();
    st_entry(string name, int line_no, int semicolon_no, string type = "int");
    void update_type(string type);
};

class symbol_table {
public:
    int sub_scopes = 0;
    int scope_start_line_no = 0;
    char symbol_table_category = 'O';     // GLOBAL : G || CLASS : C || METHOD : M
    vector <st_entry *> entries;
    string scope, name, mangled_name;
    symbol_table* parent_st = NULL;
    vector <symbol_table *> children_st;

    symbol_table();
    symbol_table(string name);
    void add_scope(symbol_table* st);
    void add_entry(st_entry* new_entry);
    void make_csv(string filename = "symbol_table.csv");
    void make_csv_wrapper(string filename);
    st_entry* look_up(string name);
    st_entry* look_up_local(string name);
};

class symbol_table_func : public symbol_table {
public:
    string return_type;
    vector <st_entry *> params;

    symbol_table_func(string func_name, vector<st_entry* > (&params), string return_type);
    void add_entry(st_entry* new_entry);
    void make_csv(string filename);
    bool operator == (const symbol_table_func& other);
};

class symbol_table_class : public symbol_table {
public:
    int object_size = 0;
    vector <symbol_table_func *> member_funcs;
    symbol_table_class* parent_class = NULL;

    symbol_table_class(string class_name);
    void add_func(symbol_table_func* func);
    void make_csv(string filename);
    symbol_table_func* look_up_function(string &name);
    symbol_table_func* look_up_function_in_class_hierarchy(string &name);
    st_entry* look_up_attribute_in_class_hierarchy(string &name);
};

class symbol_table_global : public symbol_table {
public:
    vector <symbol_table_class *> classes;
    vector <symbol_table_func *> functions;

    symbol_table_global();
    void add_entry(symbol_table_class* new_cls);
    void add_entry(symbol_table_func* new_func);
    void make_csv(string filename);
    void add_Print();
    void add_Range();
    void add_Len();
    symbol_table_class* look_up_class(string &cls_name);
    symbol_table_func* look_up_func(string &func_name);
};

#endif 