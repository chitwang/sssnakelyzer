#ifndef GLOBAL_HPP
#define GLOBAL_HPP

#include <bits/stdc++.h>
#include "symbtab.hpp"
#include "node.hpp"
#include "threeac.hpp"

extern int num_scopes;
extern "C" int yylineno;

extern symbol_table_global *global_table;

extern map<string, int> type_to_size;
extern set<string> primitive_types;

extern node *root_node;     // contains the root node of the parse tree

#endif