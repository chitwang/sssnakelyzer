#ifndef NODE_HPP
#define NODE_HPP

#include <bits/stdc++.h>
#include "symbtab.hpp"
#include "threeac.hpp"
using namespace std;

class node {
public:
    string name = "";                   // stores the lexeme if terminal or the name of the non terminal otherwise
    bool terminal = false;
    bool exp_applicable = false;
    bool is_var = false;
    bool is_self = false;
    bool is_func = false;
    bool is_class = false;
    string var = "undefined_var";
    string type = "";                   // To be used only if node is a terminal, empty otherwise. stores the token
    int node_number = 0;                // For disambiguity in AST code
    node* parent = NULL;
    vector <string> type_list = {};           // Used for typechecking
    vector <string> var_list = {};           // Used for typechecking
    string datatype = "UNDEFINED";      // Used for typechecking
    string typecast_to = "UNNEEDED";    // If the node needs to be type-casted,
    int line_no = 0;                    // Stores where the node body **ENDS**, i.e., where the production rule is completed
    vector <quad> ta_codes;
    bool type_checked = false;          // Tracks if type_checked is called or not
    long long int exp_int_val = 0;
    double exp_dob_val = 0.0;
    string exp_str_val = ""; 
    bool exp_bool_val = false;

    symbol_table* sym_tab = NULL;              // symbol table to which the node belongs
    symbol_table_func *sym_tab_func = NULL;
    st_entry* sym_tab_entry;
    vector <st_entry *> entry_list;
    vector <node *> children;

    node(string name = "", bool terminal = false, string type = "", node *parent = NULL);
    void add_child(node* child);
    void append_tac(node* v);
    void print_tac(string filename);
};

#endif