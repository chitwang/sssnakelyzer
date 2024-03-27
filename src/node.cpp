#include <bits/stdc++.h>
#include "../include/global.hpp"
using namespace std;

extern bool isop(string);
symbol_table_global *main_table;

node::node(string name, bool terminal, string type, node* parent) {
    this->parent = parent;
    this->name = name;
    this->terminal = terminal;
    this->type = type;
    this->line_no = yylineno;
    this->children = vector<node *> ();
    this->entry_list = vector<st_entry*> ();
}

void node::add_child(node* child) {
    if(!child) return;
    child->parent = this;
    this->children.push_back(child);
}

void node::append_tac(node* v) {
    for(auto (&tac) : v -> ta_codes) {
        this -> ta_codes.push_back(tac);
    }
    v -> ta_codes.clear();
}

void node::print_tac(string filename) {
    ofstream out(filename);

    int ins_count = 1;
    for(auto (&q) : this -> ta_codes) {
        if(q.code != "") {
            q.check_jump(ins_count);    // Also sets q's ins_line
            out << ins_count << (ins_count >= 100 ? ":" : ":\t") << q.code;
            ins_count++;
        }
    }
    out << ins_count << ":";

    out.close();
}