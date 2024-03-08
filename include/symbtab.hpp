#ifndef SYMBTAB_HPP
#define SYMBTAB_HPP

#include <bits/stdc++.h>
using namespace std;

class symbol_table;

class st_entry {

public:
    // One entry of a symbol table
    // From assignment: Type, source file, line number, size, offset

    string name;
    string type;
    symbol_table* table;
    int line_no;
    int stmt_no;
    int size;
    int offset = 0; // offset for field declarations 
    int dimensions = 0;
    bool modifier_bv[10] = {0}; 
    bool initialized = false;   // FIELD DECLARATIONS are initialized with default values

    st_entry();
    st_entry(string name, int line_no, int semicolon_no, string type = "int");
    st_entry(string name, st_entry (&other));

    void update_type(string type);

    void update_modifiers(vector<st_entry*> modifiers);
};

class symbol_table {

public:
    vector<st_entry*> entries;
    string scope, name;

    symbol_table* parent_st = NULL;
    vector<symbol_table*> children_st;

    int sub_scopes = 0;
    int scope_start_line_no = 0;
    char symbol_table_category = 'O';     // GLOBAL : G || CLASS : C || METHOD : M || BLOCK : B || OTHER : O

    symbol_table();
    symbol_table(string name);

    void add_scope(symbol_table* st);

    void add_entry(st_entry* new_entry);
    void delete_entry(string name);

    st_entry* look_up(string name);

    void make_csv(string filename = "symbol_table.csv");
    void make_csv_wrapper(string filename);
};

class symbol_table_func : public symbol_table {

public:
    // Additionally stores the types of parameters expected in the function
    // Along with other entries in a typical symbol table
    vector<st_entry* > params;
    string return_type;
    bool modifier_bv[10] = {0};
    
    symbol_table_func(string func_name, vector<st_entry* > (&params), string return_type);

    void add_entry(st_entry* new_entry);

    void update_modifiers(vector<st_entry*> modifiers);

    bool operator == (const symbol_table_func& other);

    void make_csv(string filename);
};

class symbol_table_class : public symbol_table {

public:
    // Stores member variables and a list of Function-Symbol tables for member functions 
    vector<symbol_table_func* > member_funcs;
    int object_size = 0;
    bool modifier_bv[10] = {0};
    
    symbol_table_class(string class_name);

    void add_func(symbol_table_func* func);
    symbol_table_func* look_up_function(string &name, vector<string> &params);

    void update_modifiers(vector<st_entry*> modifiers);

    void make_csv(string filename);
};

class symbol_table_global : public symbol_table {

public:
    // Stores classes 
    vector<symbol_table_class* > classes;

    symbol_table_global();
    void add_entry(symbol_table_class* new_cls);
    symbol_table_class* look_up_class(string &cls_name);

    void make_csv(string filename);
    void add_SysOutPln();
};

#endif 