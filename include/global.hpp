#ifndef GLOBAL_HPP
#define GLOBAL_HPP

#include <bits/stdc++.h>
#include "symbtab.hpp"

extern "C" int yylineno;

struct quad {
    string op;
    string arg1;
    string arg2;
    string result;
    string code = "";  
    int rel_jump = 0, abs_jump = 0, ins_line = 0;
    int made_from = 0;
    bool is_target = false;
    enum code_code {
        BINARY,
        UNARY,
        ASSIGNMENT,
        CONDITIONAL,
        STORE,
        LOAD,
        FUNC_CALL,
        GOTO,
        BEGIN_FUNC,
        END_FUNC,
        RETURN,
        SHIFT_POINTER,
        PARAM,
        POP_PARAM,
        PUSH_PARAM,
        EXIT,
        RETURN_VAL,
        NONE_RETURN_VAL,
        PRINT_STR,
        PRINT_BOOL,
        MAKE_STR
    };

    quad();
    quad(string r, string a1, string o, string a2);     // res = arg1 op arg2
    void make_code_from_binary();                       // r = a1 op a2;
    void make_code_from_unary();                        // r = op a1;
    void make_code_from_assignment();                   // r = a1;
    void make_code_from_conditional();                  // IFTRUE/FALSE a1 GOTO [filled later using check_jump()];                       
    void make_code_from_store();                        // *(r) = a1;
    void make_code_from_load();                         // r = *(a1);
    void make_code_from_func_call();                    // push/popparam a1;
    void make_code_from_goto();                         // GOTO a1;
    void make_code_push_param();                        // push/popparam a1;
    void make_code_begin_func();                        // begin_func x;
    void make_code_end_func();                          // end_func;
    void make_code_from_return();                       // return a1;
    void make_code_shift_pointer();                      // shift stack pointer
    void make_code_pop_param();
    void make_code_from_return_val();
    void make_code_from_none_return_val();
    void make_code_from_print_str();
    void make_code_from_new_str();
    void make_code_from_print_bool();
    void check_jump(const int);
};

class node {
public:
    string name = "";                   // stores the lexeme if terminal or the name of the non terminal otherwise
    bool terminal = false;
    bool is_var = false;
    bool is_func = false;
    bool is_class = false;
    string var = "undefined_var";
    string type = "";                   // To be used only if node is a terminal, empty otherwise. stores the token
    string is_class_func = "";
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

struct instruction{
    string op = "";
    string arg1 = "";
    string arg2 = "";
    string arg3 = "";
    string code = "";
    string ins_type = "";

    string comment = "";

    instruction();
    instruction(string, string a1 = "", string a2 = "", string a3 = "", string it = "ins", string comment = "");
};

struct procedure_entry{
    string name = "";
    int offset = 0;         // offset from the base pointer in procedure

    procedure_entry();
    procedure_entry(string, int);
};

struct procedure_table{
    int number_of_params = 0;
    int total_space;
    bool is_main_function = false;
    string procedure_name;
    map<string, procedure_entry> lookup_table;

    procedure_table();
    void construct_procedure_table(vector<quad> procedure_ins);
};

struct task_struct {
    vector< vector<quad> > procedures;
    vector<instruction> code;
    vector<procedure_table* > sub_tables;
    task_struct();
    void print_code(string asm_file = "code.s");
    int power_op = 0;
    void get_tac_procedures();                            
    void gen_tac_basic_block(vector<quad>, procedure_table*); 
    string get_func_name(string s);          

    void gen_global();                                      
    void gen_text();                                        
    void gen_procedure(vector<quad> procedure);           
    void gen_basic_block(vector<quad> BB, procedure_table*);      
    vector<instruction> make_x86_code(quad, int x = 0, int y = 0, int z = 0);    
};


extern symbol_table_global *global_table;

extern int temp_count;
extern map<string, int> type_to_size;
extern map<string, string> string_list;
extern set<string> primitive_types;
extern vector<node *> all_nodes;
extern vector<quad> all_quads;
extern node *root_node;

void print_tac(string filename);

#endif