#include <bits/stdc++.h>
#include "../include/global.hpp"
using namespace std;

int num_scopes = 0;
symbol_table_global *global_table = new symbol_table_global();

map<string, int> type_to_size = {
    {"int", 8}, 
    {"float", 8},
    {"bool", 1},
    {"str", 4},
    {"list[ int ]", 8}, 
    {"list[ float ]", 8},
    {"list[ bool ]", 8},
    {"list[ str ]", 8}
};

set<string> primitive_types = {
    "int", "float", "bool", "str"
};

st_entry::st_entry() {}

st_entry::st_entry(string name, int line_no, int semicolon_no, string type /*= "int"*/) {
    this->name = name;
    this->line_no = line_no;
    // this->stmt_no = semicolon_no;
    this->type = type;
    this->size = type_to_size[type];
}

st_entry::st_entry(string name, st_entry (&other)) {
    this->name = name;
    this->type = other.type;
    this->line_no = other.line_no;
    // this->stmt_no = other.stmt_no;
    this->size = other.size;
}

void st_entry::update_type(string type) {
    this->type = type;
    this->size = type_to_size[type];
    if(this -> size == 0) {
        this -> size = 4;       // otherwise it's a reference and hence 4 bytes
    }
}

symbol_table::symbol_table() {
    this -> scope = "";
    this -> name = "";
    this -> symbol_table_category = 'B';
}

symbol_table::symbol_table(string name) {
    this -> scope = "";
    this -> name = name;
    this -> symbol_table_category = 'B';
}

void symbol_table::add_scope(symbol_table* st) {
    this->sub_scopes++;
    st->scope = scope + "." + to_string(this->sub_scopes);
    st->parent_st = this;    // st is the child symbol table, this pointer gives the parent symbol table
}

void symbol_table::add_entry(st_entry* new_entry) {
    // for(int i = 0; i < new_entry -> dimensions; i++) {
    //     new_entry -> type += "[]";
    // }
    new_entry -> update_type(new_entry -> type);

    for(auto (&entry) : entries) {
        if(new_entry->name == entry->name) {
            cout << "ERROR: Variable " << new_entry->name << " is already declared at line number " << entry->line_no << " in the same scope.\n";
            exit(1);
        }
    }
    if(this -> symbol_table_category == 'G') {
        new_entry -> is_global = true;
    }
    entries.push_back(new_entry);
    new_entry -> table = this;
}

void symbol_table::delete_entry(string name) {
    for(auto ite = entries.begin(); ite != entries.end(); ite++) {
        if((*ite) -> name == name) {
            entries.erase(ite);
            return;
        }
    }

    cout<<"There is no entry with variable name " << name << " in scope " << scope << ".\n";
    cout<<"Returning without deleting...\n";
}

st_entry* symbol_table::look_up_local(string name) {
    for(auto &en: this->entries) {
        if(en->name == name) {
            return en;
        }
    }
    if(this->symbol_table_category == 'M') {
        symbol_table_func* tmp = (symbol_table_func *) this;
        for(auto &param: tmp->params) {
            if(param->name == name) {
                return param;
            }
        }
    }
    return NULL;
}

st_entry* symbol_table::look_up(string name) {
    //! populate the global symbol table entry list with class names so that lookup here is possible !//
    
    if(this -> symbol_table_category == 'M') {
        symbol_table_func* tmp = (symbol_table_func *) this;
        for(int idx = 0; idx < tmp -> params.size(); idx++) {
            if(tmp -> params[idx]-> name == name) {
                return tmp -> params[idx];
            }
        } 
    }
    for(int idx = 0; idx < entries.size(); idx++) {
        if(entries[idx]->name == name) {
            return entries[idx];
        }
    }
    st_entry *st = global_table->look_up_local(name);

    // if(this -> symbol_table_category == 'C' && ((symbol_table_class *)this) -> parent_class) {
    //     st = ((symbol_table_class *)this)->parent_class->look_up(name);
    // }
    // if(!st && this->parent_st &&) {
    //     st = this->parent_st->look_up(name);
    // }
    return st;
}

symbol_table_func::symbol_table_func(string func_name, vector<st_entry* > (&params), string return_type) {
    this->name = func_name;

    for(auto &param : params) {
        // for(int i = 0; i < param -> dimensions; i++) {
        //     param -> type += "[]";
        // }
        param -> table = this;
        param -> update_type(param -> type);
    }

    this->params = params;
    this->return_type = return_type;
    this->symbol_table_category = 'M';
}

void symbol_table_func::add_entry(st_entry* new_entry) {
    // for(int i = 0; i < new_entry -> dimensions; i++) {
    //     new_entry -> type += "[]";
    // }
    new_entry -> update_type(new_entry -> type);

    for(const auto (&param) : params) {
        if(new_entry->name == param->name) {
            cout << "ERROR: Variable " << new_entry -> name << " is already declared at line number " << param->line_no << " as a formal parameter.\n";
            exit(1);
        }
    }

    for(const auto (&entry) : entries) {
        if(new_entry -> name == entry -> name) {
            cout << "ERROR: Variable " << new_entry -> name << " is already declared at line number " << entry -> line_no << " in the same scope.\n";
            exit(1);
        }
    }

    entries.push_back(new_entry);
    new_entry -> table = this;
}


bool symbol_table_func::operator == (const symbol_table_func& other) {
    if(this->name == other.name) {
        if((this->params).size() == other.params.size()) {
            for(int idx = 0; idx < other.params.size(); idx++) {
                if((this->params)[idx]->type != other.params[idx]->type) {
                    return false;
                }
            }
            return true;
        }
    }
    return false;
}

int symbol_table_func::get_func_local_size() {
    int space = 0;
    for(auto &entry : this -> entries) {
        space += entry -> size;
    }
    return space;
}

symbol_table_class::symbol_table_class(string class_name) {
    this -> name = class_name;
    this -> symbol_table_category = 'C';
}

void symbol_table_class::add_func(symbol_table_func* new_func) {
    for(auto (&func) : (this->member_funcs)) {
        if((*func) == (*new_func)) {
            cout << "ERROR: Function with name " << (new_func->name) << " and parameter tuple: (";
            for(int idx = 0; idx < new_func->params.size(); idx++) {
                if(idx) {
                    cout << ", " << (new_func->params)[idx]->type;
                } else {
                    cout << (new_func->params)[idx]->type;
                }
            }
            cout << ") already exists at line number: " << new_func -> scope_start_line_no << "\n";
            exit(1);
        }
    }
    this->member_funcs.push_back(new_func);
}

symbol_table_func* symbol_table_class::look_up_function(string &name) {
    for(int idx = 0; idx < this -> member_funcs.size(); idx++) {
        if(name == member_funcs[idx] -> name) {
            return member_funcs[idx];
        }
    }
    // if(this -> parent_class) {
    //     return this -> parent_class -> look_up_function(name);
    // }
    return NULL;
}

symbol_table_func* symbol_table_class::look_up_function_in_class_hierarchy(string &name) {
    for(int idx = 0; idx < this -> member_funcs.size(); idx++) {
        if(name == member_funcs[idx] -> name) {
            return member_funcs[idx];
        }
    }
    if(this -> parent_class) {
        return this -> parent_class -> look_up_function_in_class_hierarchy(name);
    }
    return NULL;
}

st_entry* symbol_table_class::look_up_attribute_in_class_hierarchy(string &name) {
    for(int idx = 0; idx < this -> entries.size(); idx++) {
        if(name == entries[idx] -> name) {
            return entries[idx];
        }
    }
    if(this -> parent_class) {
        return this -> parent_class -> look_up_attribute_in_class_hierarchy(name);
    }
    return NULL;
}

symbol_table_global::symbol_table_global() {
    this -> name = "__GlobalSymbolTable__";
    this -> scope = "";
    this -> symbol_table_category = 'G';
    this -> parent_st = NULL;
    this -> classes = vector <symbol_table_class*>();
    this -> functions = vector <symbol_table_func*>();
}

void symbol_table_global::add_entry(symbol_table_class* new_cls) {
    for(auto &cls : this -> classes) {
        if(new_cls -> name == cls -> name) {
            cout << "ERROR: Duplicate class " << new_cls -> name << " at line number " << new_cls -> scope_start_line_no << endl;
            exit(1);
        }
    }

    // st_entry *tmp = new st_entry(new_cls -> name, new_cls -> scope_start_line_no, 0, new_cls -> name);
    // tmp -> initialized = true;
    // this -> entries.push_back(tmp);  // populate here as well for other lookups
    this -> classes.push_back(new_cls);
}

void symbol_table_global::add_entry(symbol_table_func* new_func) {
    for(auto &func : this -> functions) {
        if(new_func -> name == func -> name) {
            cout << "ERROR: Duplicate function " << new_func -> name << " at line number " << new_func -> scope_start_line_no << endl;
            exit(1);
        }
    }
    // st_entry *tmp = new st_entry(new_func -> name, new_func -> scope_start_line_no, 0, new_func -> name);
    // tmp -> initialized = true;
    // this -> entries.push_back(tmp);  // populate here as well for other lookups
    this -> functions.push_back(new_func);
}

symbol_table_class* symbol_table_global::look_up_class(string &cls_name) {
    for(auto &cls : this -> classes) {
        if(cls -> name == cls_name) {
            return cls;
        }
    }
    return NULL;
}

symbol_table_func* symbol_table_global::look_up_func(string &func_name) {
    for(auto &func : this -> functions) {
        if(func -> name == func_name) {
            return func;
        }
    }
    return NULL;
}

void symbol_table::make_csv(string filename) {
    ofstream out(filename, ios::app);
    
    out << "Scope, Name, Type, Line Number\n";
    for(auto &entry : this -> entries) {
        out << this -> scope << ", " <<  entry -> name << ", " << entry -> type << ", " << entry -> line_no << '\n'; 
    }
    out.close();
}

void symbol_table_func::make_csv(string filename) {
    ofstream out(filename, ios::app);
    
    out << "Scope, Formal Parameter Name, Formal Parameter Type, Line Number\n";
    for(auto &param : this -> params) {
        out << this -> scope << ", " << param -> name << ", " << param -> type << ", " << param -> line_no << '\n';
    }

    out << "Scope, Name, Type, Line Number\n";
    for(auto &entry : this -> entries) {
        out << this -> scope << ", " <<  entry -> name << ", " << entry -> type << ", " << entry -> line_no << '\n'; 
    }

    out.close();
}

void symbol_table_class::make_csv(string filename) {
    ofstream out(filename, ios::app);
    
    out << "Scope, Function Name, Return Type, Line Number\n";
    for(auto &func: this -> member_funcs) {
        string func_name = func -> name;
        func_name += "(";

        bool first = true;
        for(auto &param : func -> params) {
            func_name += (first ? "" : "; ");
            func_name += param -> type;
            first = false;
        }
        
        func_name += ")";

        out << this -> scope << ", " << func_name << ", " << func -> return_type << ", " << this -> scope_start_line_no << "\n";
    }

    out << "Scope, Field Name, Field Type, Line Number\n";
    for(auto &entry: this -> entries) {
        out << this -> scope << ", " <<  entry -> name << ", " << entry -> type << ", " << entry -> line_no << '\n';
    }

    out.close();
}

void symbol_table_global::make_csv(string filename) {
    ofstream out(filename, ios::app);

    out << "Scope, Class Name, Size, Line Number\n";
    for(auto &cls : this -> classes) {
        out << "Global, " << cls -> name << ", " << cls -> object_size << ", " << this -> scope_start_line_no << "\n";  
    }
    out << "Scope, Function Name, Size, Line Number\n";
    for(auto &funcs : this -> functions) {
        out << "Global, " << funcs -> name << ", NULL, " << this -> scope_start_line_no << "\n";  
    }
    out << "Scope, Variable Name, Size, Line Number\n";

    for(auto &entry : this -> entries) {
        out << "Global, " << entry -> name << ", " << entry -> type << ", " << entry -> line_no << '\n'; 
    }

    out.close();
}

void symbol_table::make_csv_wrapper(string filename) {
    string child_file;
    switch(this -> symbol_table_category) {
        case 'G': ((symbol_table_global *) this) -> make_csv(filename);
        break;
        case 'C': ((symbol_table_class *) this) -> make_csv(filename);
        break;
        case 'M': ((symbol_table_func *) this) -> make_csv(filename);
        break;
        case 'B': 
        default: ((symbol_table *) this) -> make_csv(filename);
        break;
    }

    for(auto &child : children_st) {
        child_file = filename.substr(0, filename.size()-4) + "_" + child -> name + ".csv";
        if(child -> symbol_table_category == 'G' || child -> symbol_table_category == 'C' || child -> symbol_table_category == 'M') {
            child -> make_csv_wrapper(child_file);
        }
        else {
            child -> make_csv_wrapper(filename);
        }
    }
}

void symbol_table_global::add_Print() {
    vector <st_entry *> args;

    st_entry *arg = new st_entry("print_str", 0, 0, "str");
    args.push_back(arg);
    symbol_table_func *print_str = new symbol_table_func("print", args, "None");
    print_str->mangled_name = "print_str";
    global_table -> functions.push_back(print_str);
    global_table -> add_scope((symbol_table *)print_str);
    global_table -> children_st.push_back((symbol_table *)print_str);

    arg = new st_entry("print_int", 0, 0, "int");
    args = {arg};
    symbol_table_func *print_int = new symbol_table_func("print", args, "None");
    print_int->mangled_name = "print_int";
    global_table -> functions.push_back(print_int);
    global_table -> add_scope((symbol_table *)print_int);
    global_table -> children_st.push_back((symbol_table *)print_int);

    arg = new st_entry("print_flt", 0, 0, "float");
    args = {arg};
    symbol_table_func *print_float = new symbol_table_func("print", args, "None");
    print_float->mangled_name = "print_flt";
    global_table -> functions.push_back(print_float);
    global_table -> add_scope((symbol_table *)print_float);
    global_table -> children_st.push_back((symbol_table *)print_float);

    arg = new st_entry("print_bol", 0, 0, "bool");
    args = {arg};
    symbol_table_func *print_bool = new symbol_table_func("print", args, "None");
    print_bool->mangled_name = "print_bol";
    global_table -> functions.push_back(print_bool);
    global_table -> add_scope((symbol_table *)print_bool);
    global_table -> children_st.push_back((symbol_table *)print_bool);
}

void symbol_table_global::add_Range() {
    vector <st_entry *> args;

    st_entry *start = new st_entry("start", 0, 0, "int");
    st_entry *end = new st_entry("end", 0, 0, "int");
    args.push_back(start);
    args.push_back(end);

    symbol_table_func *range_start_end = new symbol_table_func("range", args, "int");
    range_start_end->mangled_name = "range_start_end";
    global_table -> functions.push_back(range_start_end);
    global_table -> add_scope((symbol_table *)range_start_end);
    global_table -> children_st.push_back((symbol_table *)range_start_end);

    args = {end};
    symbol_table_func *range_end = new symbol_table_func("range", args, "int");
    range_end->mangled_name = "range_end";
    global_table -> functions.push_back(range_end);
    global_table -> add_scope((symbol_table *)range_end);
    global_table -> children_st.push_back((symbol_table *)range_end);
}

void symbol_table_global::add_Len() {
    vector<st_entry *> args;

    st_entry *list = new st_entry("list_var", 0, 0, "list");
    args.push_back(list);
    symbol_table_func *len = new symbol_table_func("len", args, "int");
    len->mangled_name = "len";
    global_table -> functions.push_back(len);
    global_table -> add_scope((symbol_table *)len);
    global_table -> children_st.push_back((symbol_table *)len);
}