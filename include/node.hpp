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
    bool is_var = false;
    bool is_func = false;
    bool is_class = false;
    string var = "undefined_var";
    string type = "";                   // To be used only if node is a terminal, empty otherwise. stores the token
    node* parent = NULL;
    vector <string> type_list = {};           // Used for typechecking
    vector <string> var_list = {};           // Used for typechecking
    string datatype = "UNDEFINED";      // Used for typechecking
    vector <quad> ta_codes;
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