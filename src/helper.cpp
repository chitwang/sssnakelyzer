#include <bits/stdc++.h>
#include "../include/global.hpp"
using namespace std;

symbol_table_global *main_table;
const int stack_offset = 8;
int func_count = 0;
map<string, string> func_name_map;
extern node *root_node;
extern map<string, string> string_list;


quad::quad() {}

quad::quad(string r, string a1, string o, string a2) : result(r), arg1(a1), op(o), arg2(a2) {}

void quad::make_code_from_binary() {
    made_from = BINARY;
    code = "\t\t" + result + " = " + arg1 + " " + op + " " + arg2 + ";\n";
}

void quad::make_code_from_unary() {
    made_from = UNARY;
    code = "\t\t" + result + " = " + op + "(" + arg1 + ");\n";
}

void quad::make_code_from_assignment() {
    made_from = ASSIGNMENT;
    code = "\t\t" + result + " = " + arg1 + ";\n";
}


void quad::make_code_from_store() {
    made_from = STORE;
    code = "\t\t*(" + result + ") = " + arg1 + ";\n";
}

void quad::make_code_from_load(){
    made_from = LOAD;
    code = "\t\t" + result + " = *(" + arg1 + ");\n";
}

void quad::make_code_from_conditional(){
    made_from = CONDITIONAL;
    rel_jump = stoi(arg2.substr(1, arg2.size() - 1));
    code = "\t\t" + op + " " + arg1 + " goto ";
}

void quad::make_code_from_func_call() {
    made_from = FUNC_CALL;
    code = "\t\t" + op + " " + arg1 + ", " + arg2 + ";\n";
}

void quad::make_code_from_goto() {
    made_from = GOTO;
    rel_jump = stoi(arg1.substr(1, arg1.size() - 1));
    code = "\t\t" + op + " ";      
}

void quad::make_code_push_param(){
    made_from = PUSH_PARAM;
    code = "\t\t" + op + " " + arg1 + ";\n";
    arg2 = "";
    result = "";
}

void quad::check_jump(const int ins_line){
    this->ins_line = ins_line;
    if(rel_jump){
        abs_jump = ins_line + rel_jump;
        code += to_string(abs_jump) + ";\n";
    }
}
    
void quad::make_code_begin_func() {
    made_from = BEGIN_FUNC;
    code = "begin_func " + arg1 + "\n";
}

void quad::make_code_end_func() {
    made_from = END_FUNC;
    code = "end_func\n\n";
}

void quad::make_code_from_return() {
    made_from = RETURN;
    code = "\t\t" + op + " " + arg1 + ";\n"; // op is "return"
}

void quad::make_code_shift_pointer() {
    made_from = SHIFT_POINTER;
    code = "\t\tstack_pointer " + arg1 + "xxx\n";
}

void quad::make_code_pop_param() {
    made_from = POP_PARAM;
    code = "\t\t" + result + " = pop_param;\n";
}

void quad::make_code_from_return_val() {
    made_from = RETURN_VAL;
    code = "\t\t" + result + " = " + "return_value;\n";
    arg1 = "";
    arg2 = "";
}

void quad::make_code_from_none_return_val() {
    made_from = NONE_RETURN_VAL;
    code = "\t\tnone type function call ends\n";
    arg1 = "";
    arg2 = "";
}

void quad::make_code_from_print_str() {
    made_from =  PRINT_STR;
    code = "\t\tstring print " + arg1 +  "\n";
}

void quad::make_code_from_new_str() {
    made_from =  MAKE_STR;
    code = "\t\tstring make " + arg1 + " into var " + result + "\n";
}

node::node(string name, bool terminal, string type, node* parent) {
    this->parent = parent;
    this->name = name;
    this->terminal = terminal;
    this->type = type;
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

void node::print_tac(string filename){
    ofstream out(filename);

    int ins_count = 1;
    set<int> targets;
    for(auto (&q) : this -> ta_codes) {
        if(q.code != "") {
            q.check_jump(ins_count);    
            if(q.abs_jump){
                targets.insert(q.abs_jump);
            }
            
            out << ins_count << (ins_count >= 100 ? ":" : ":\t") << q.code;
            ins_count++;
        }
    }

    for(auto (&q) : this -> ta_codes){
        if(q.code != "" && targets.find(q.ins_line) != targets.end()){
            q.is_target = true;
        }
    }

    out.close();
}


instruction::instruction(){;}

instruction::instruction(string op, string a1, string a2, string a3, string it, string comment) : op(op), arg1(a1), arg2(a2), arg3(a3), ins_type(it), comment(comment){
    if(it == "ins") {          
        code = "\t\t" + op;
        if(arg1 != ""){
            code += "\t" + arg1;
        } 
        if(arg2 != ""){
            code += ",\t" + arg2;
        }
    }
    else if(it == "segment") {  // text segment, global segment
        code = op;
        if(a1 != "") {
            code += "\t" + a1;
        }
    }
    else if(it == "label") {    // jump labels and procedure labels
        code = arg1 + ":";
    }
    else if(it == "comment") {
        // code = "\n\t\t# " + comment;
        code = "";
        return;
    }
    if(comment != ""){
        code += "\t\t# " + comment;
    }
    code += "\n";
}

bool isVariable(string s) {   
    if(s == "") {
        cout << "Empty string is neither constant/variable. Aborting...";
        exit(1);
    }
    return !(s[0] >= '0' && s[0] <= '9') && (s[0] != '-') && (s[0] != '+');
}


string task_struct::get_func_name(string s) {
    if(func_name_map.find(s) == func_name_map.end()) {
        func_count++;
        func_name_map[s] = "func" + to_string(func_count);
    }

    return func_name_map[s];
}

vector<instruction> task_struct::make_x86_code(quad q, int x, int y, int z) {
    vector<instruction> insts;
    instruction ins;

    if(q.code == "") {
        return insts;        
    }
    else {
        if(q.made_from != quad::SHIFT_POINTER && q.made_from != quad::POP_PARAM) {
            ins = instruction("", "", "", "", "comment", q.code.substr(2, q.code.size() - 2));
            insts.push_back(ins);
        }
    }

    if(q.is_target) {   
        ins = instruction("", "L" + to_string(q.ins_line), "", "", "label");
        insts.push_back(ins);
    }
    if(q.made_from == quad::BINARY){            // c(z) = a(x) op b(y)

        if(q.op == "+") {
            if(!isVariable(q.arg1)) {
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)) {
                ins = instruction("add", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("add", to_string(y) + "(%rbp)", "%rdx");
            }
        }
        else if(q.op == "-") {
            if(!isVariable(q.arg1)) {
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)) {
                ins = instruction("sub", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("sub", to_string(y) + "(%rbp)", "%rdx");
            }
        }
        else if(q.op == "*") {
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("imul", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("imul", to_string(y) + "(%rbp)", "%rdx");
            }
        }
        else if(q.op == "//" || q.op == "/") {
            if(!isVariable(q.arg1)){   // arg1 is a literal
                ins = instruction("movq", "$" + q.arg1, "%rax");
                insts.push_back(ins);
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rax");
                insts.push_back(ins);                
            }
            ins = instruction("cqto");
            insts.push_back(ins);

            if(!isVariable(q.arg2)){  // arg2 is a literal
                ins = instruction("movq", "$" + q.arg2, "%rbx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rbx");
            }
            insts.push_back(ins);
            ins = instruction("idiv", "%rbx", "");
            insts.push_back(ins);
            ins = instruction("movq", "%rax", "%rdx");
        }
        else if(q.op == "**"){
            if(!isVariable(q.arg1)) {   // arg1 is a literal
                ins = instruction("movq", "$" + q.arg1, "%rax");
                insts.push_back(ins);
            }
            else {
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rax");
                insts.push_back(ins);                
            }

            if(!isVariable(q.arg2)) {  // arg2 is a literal
                ins = instruction("movq", "$" + q.arg2, "%rbx");
            }
            else {
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rbx");
            }
            string tm = "_" + to_string(this->power_op);
            this->power_op++;
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rcx");
            insts.push_back(ins);
            ins = instruction("", "exp_loop" + tm, "", "", "label");
            insts.push_back(ins);
            ins = instruction("test", "%rbx", "%rbx");
            insts.push_back(ins);
            ins = instruction("jz", "exp_done" + tm);
            insts.push_back(ins);
            ins = instruction("imul", "%rax", "%rcx");
            insts.push_back(ins);
            ins = instruction("dec", "%rbx");
            insts.push_back(ins);
            ins = instruction("jmp", "exp_loop" + tm);
            insts.push_back(ins);
            ins = instruction("", "exp_done" + tm, "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "%rcx", "%rdx");
            // insts.push_back(ins);
        }
        else if(q.op == "%") {
            if(!isVariable(q.arg1)){   // arg1 is a literal
                ins = instruction("movq", "$" + q.arg1, "%rax");
                insts.push_back(ins);
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rax");
                insts.push_back(ins);                
            }
            ins = instruction("cqto");
            insts.push_back(ins);

            if(!isVariable(q.arg2)){  // arg2 is a literal
                ins = instruction("movq", "$" + q.arg2, "%rbx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rbx");
            }
            insts.push_back(ins);
            ins = instruction("idiv", "%rbx", "");
        }
        else if(q.op == "<<"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("sal", "%cl", "%rdx");
        }
        else if(q.op == ">>"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("sar", "%cl", "%rdx");
        }
        else if(q.op == ">>>"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("shr", "%cl", "%rdx");
        }
        else if(q.op == ">"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);

            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "%rdx", "%rcx");
            insts.push_back(ins);
            ins = instruction("jl", "1f");  // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f"); // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == "<"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);

            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "%rdx", "%rcx");
            insts.push_back(ins);
            ins = instruction("jg", "1f");  // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f"); // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == ">="){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);

            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "%rdx", "%rcx");
            insts.push_back(ins);
            ins = instruction("jle", "1f");  // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f"); // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == "<="){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);

            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "%rdx", "%rcx");
            insts.push_back(ins);
            ins = instruction("jge", "1f");  // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f"); // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == "=="){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);

            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "%rdx", "%rcx");
            insts.push_back(ins);
            ins = instruction("je", "1f");  // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f"); // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == "!="){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);

            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rcx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rcx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "%rdx", "%rcx");
            insts.push_back(ins);
            ins = instruction("jne", "1f");  // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f"); // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == "&"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("and", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("and", to_string(y) + "(%rbp)", "%rdx");
            }     
        }
        else if(q.op == "|"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("or", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("or", to_string(y) + "(%rbp)", "%rdx");
            }     
        }
        else if(q.op == "^"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("xor", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("xor", to_string(y) + "(%rbp)", "%rdx");
            }
        }
        else if(q.op == "&&"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("je", "1f");
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("je", "1f");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        else if(q.op == "||"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jne", "1f");     // true
            insts.push_back(ins);
            if(!isVariable(q.arg2)){
                ins = instruction("movq", "$" + q.arg2, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            ins = instruction("cmp", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jne", "1f");     // true
            insts.push_back(ins);
            ins = instruction("movq", "$0", "%rdx");
            insts.push_back(ins);
            ins = instruction("jmp", "2f");     // false
            insts.push_back(ins);
            ins = instruction("", "1", "", "", "label");
            insts.push_back(ins);
            ins = instruction("movq", "$1", "%rdx");
            insts.push_back(ins);
            ins = instruction("", "2", "", "", "label");
        }
        insts.push_back(ins);
        
        ins = instruction("movq", "%rdx", to_string(z) + "(%rbp)");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::UNARY){        // b(y) = op a(x)
        if(q.op == "~"){
            if(!isVariable(q.arg1)){
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            ins = instruction("not", "%rdx", "");
        }
        else if(q.op == "!") {
            if(!isVariable(q.arg1)) {
                ins = instruction("movq", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            }
            insts.push_back(ins);
            ins = instruction("test", "%rdx", "%rdx");
            insts.push_back(ins);
            ins = instruction("sete", "%al");
            insts.push_back(ins);
            ins = instruction("movzbl", "%al", "%edx");
        }
        else if(q.op == "-"){
            ins = instruction("xor", "%rdx", "%rdx");
            insts.push_back(ins);
            if(!isVariable(q.arg1)){
                ins = instruction("sub", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("sub", to_string(x) + "(%rbp)", "%rdx");
            }
        }
        else if(q.op == "+"){
            ins = instruction("xor", "%rdx", "%rdx");
            insts.push_back(ins);
            if(!isVariable(q.arg1)){
                ins = instruction("add", "$" + q.arg1, "%rdx");
            }
            else{
                ins = instruction("add", to_string(x) + "(%rbp)", "%rdx");
            }
        }
        insts.push_back(ins);
        
        ins = instruction("movq", "%rdx", to_string(y) + "(%rbp)");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::ASSIGNMENT){   // b(y) = a(x)
        if(!isVariable(q.arg1)){
            ins = instruction("movq", "$" + q.arg1, to_string(y) + "(%rbp)");
            insts.push_back(ins);
        }
        else{
            ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
            insts.push_back(ins);            
            ins = instruction("movq", "%rdx", to_string(y) + "(%rbp)");
            insts.push_back(ins);
        }
    }
    else if(q.made_from == quad::CONDITIONAL){  // if_false/if_true(op) a(x) goto y
        if(!isVariable(q.arg1)){
            ins = instruction("movq", "$" + q.arg1, "%rdx");
        }
        else{
            ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
        }
        insts.push_back(ins);
        ins = instruction("cmp", "$0", "%rdx");
        insts.push_back(ins);
        
        if(q.op == "if_false"){
            ins = instruction("je", "L" + to_string(y));
        }
        else if(q.op == "if_true"){
            ins = instruction("jne", "L" + to_string(y));
        }
        insts.push_back(ins);
    } 
    else if(q.made_from == quad::GOTO){         // goto (x)
        ins = instruction("jmp", "L" + to_string(x));
        insts.push_back(ins);
    }
    else if(q.made_from == quad::STORE){       // *(r(z) + a2) = a1(x)
        // cout<<"store\t"<<q.result<<" "<<q.arg1<<endl;
        if(!isVariable(q.arg1)){
            ins = instruction("movq", "$" + q.arg1, "%rax");
        }
        else{
            ins = instruction("movq", to_string(x) + "(%rbp)", "%rax");
        }
        insts.push_back(ins);
        
        ins = instruction("movq", to_string(z) + "(%rbp)", "%rdx");
        insts.push_back(ins);

        if(q.arg2 == "" || !isVariable(q.arg2)) {
            ins = instruction("movq", "%rax", q.arg2 + "(%rdx)");
            insts.push_back(ins);
        }
        else {
            cout << "Unknown TAC `" << q.code << "`. Cannot make load from this code!" << endl;
            exit(1);  
        }
    }
    else if(q.made_from == quad::LOAD){         // r(z) = *(a1(x) + a2(y))
        ins = instruction("movq", to_string(x) + "(%rbp)", "%rdx");
        insts.push_back(ins);

        if(q.arg2 == "" || !isVariable(q.arg2)) {
            ins = instruction("movq", q.arg2 + "(%rdx)", "%rdx");
            insts.push_back(ins);
        }
        else {
            cout << "Unknown TAC `" << q.code << "`. Cannot make load from this code!" << endl;
            exit(1);
        }

        ins = instruction("movq", "%rdx", to_string(z) + "(%rbp)");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::BEGIN_FUNC) {  
        if(y == 1) {        
            ins = instruction("", "main", "", "", "label");
            insts.push_back(ins);
        }

        ins = instruction("", get_func_name(q.arg1), "", "", "label");     // add label
        insts.push_back(ins);


        ins = instruction("pushq", "%rbp");      // old base pointer
        insts.push_back(ins);
        ins = instruction("movq", "%rsp", "%rbp");    // shift base pointer to the base of the new activation frame
        insts.push_back(ins);
        ins = instruction("pushq", "%rbx");
        insts.push_back(ins);
        ins = instruction("pushq", "%rdi");
        insts.push_back(ins);
        ins = instruction("pushq", "%rsi");
        insts.push_back(ins);
        ins = instruction("pushq", "%r12");
        insts.push_back(ins);
        ins = instruction("pushq", "%r13");
        insts.push_back(ins);
        ins = instruction("pushq", "%r14");
        insts.push_back(ins);
        ins = instruction("pushq", "%r15");
        insts.push_back(ins);
        if(x > 0) {
            ins = instruction("sub", "$" + to_string(x), "%rsp");
            insts.push_back(ins);
        }
    }
    else if(q.made_from == quad::RETURN) {    // clean up activation record
        if(q.arg1 != "") {     
            if(!isVariable(q.arg1)) {
                ins = instruction("movq", "$" + q.arg1, "%rax");
            }
            else {
                ins = instruction("movq", to_string(y) + "(%rbp)", "%rax");
            }
            insts.push_back(ins);
        }
        
        ins = instruction("add", "$" + to_string(x), "%rsp");   // delete all local and temporary variables
        insts.push_back(ins);
        ins = instruction("popq", "%r15");                      // restore old register values
        insts.push_back(ins);
        ins = instruction("popq", "%r14");
        insts.push_back(ins);
        ins = instruction("popq", "%r13");
        insts.push_back(ins);
        ins = instruction("popq", "%r12");
        insts.push_back(ins);
        ins = instruction("popq", "%rsi");
        insts.push_back(ins);
        ins = instruction("popq", "%rdi");
        insts.push_back(ins);
        ins = instruction("popq", "%rbx");
        insts.push_back(ins);
        ins = instruction("popq", "%rbp");
        insts.push_back(ins);

        ins = instruction("ret");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::END_FUNC) {
        if(x == 1) {        // if main function
            ins = instruction("movq", "$60", "%rax");
            insts.push_back(ins);
            ins = instruction("xor", "%rdi", "%rdi");
            insts.push_back(ins);
            ins = instruction("syscall");
            insts.push_back(ins);
        }
        else {              // otherwise we perform usual callee clean up
            ins = instruction("add", "$" + to_string(y), "%rsp");   // delete all local and temporary variables
            insts.push_back(ins);
            ins = instruction("popq", "%r15");                      // restore old register values
            insts.push_back(ins);
            ins = instruction("popq", "%r14");
            insts.push_back(ins);
            ins = instruction("popq", "%r13");
            insts.push_back(ins);
            ins = instruction("popq", "%r12");
            insts.push_back(ins);
            ins = instruction("popq", "%rsi");
            insts.push_back(ins);
            ins = instruction("popq", "%rdi");
            insts.push_back(ins);
            ins = instruction("popq", "%rbx");
            insts.push_back(ins);
            ins = instruction("popq", "%rbp");
            insts.push_back(ins);
            ins = instruction("ret");
            insts.push_back(ins);
        }
    }
    else if(q.made_from == quad::SHIFT_POINTER) {
        
    }
    else if(q.made_from == quad::FUNC_CALL) {
        if(x == 0) {        // if function is called without any parameters, we have yet to perform caller responsibilities
            ins = instruction("pushq", "%rax");
            insts.push_back(ins);
            ins = instruction("pushq", "%rcx");
            insts.push_back(ins);
            ins = instruction("pushq", "%rdx");
            insts.push_back(ins);
            ins = instruction("pushq", "%r8");
            insts.push_back(ins);
            ins = instruction("pushq", "%r9");
            insts.push_back(ins);
            ins = instruction("pushq", "%r10");
            insts.push_back(ins);
            ins = instruction("pushq", "%r11");
            insts.push_back(ins);
        }
        ins = instruction("call", this -> get_func_name(q.arg1));      // call the function
        insts.push_back(ins);

        if(this -> get_func_name(q.arg1) == "print") {          // deal specially with print
            ins = instruction("add", "$8", "%rsp");
            insts.push_back(ins);
        }
        else if(this -> get_func_name(q.arg1) == "allocmem") {
            ins = instruction("add", "$8", "%rsp");             // deal specially with allocmem
            insts.push_back(ins);
        }
        else if(x > 0) {                             // pop the parameters
            ins = instruction("add", "$" + to_string(x*stack_offset), "%rsp");
            insts.push_back(ins);
        }
    }
    else if(q.made_from == quad::RETURN_VAL) {
        if(q.result != "") {      // if the function returns a value
            ins = instruction("mov", "%rax", to_string(x) + "(%rbp)");
            insts.push_back(ins);
        }

        // restore original state of registers
        ins = instruction("popq", "%r11");
        insts.push_back(ins);
        ins = instruction("popq", "%r10");
        insts.push_back(ins);
        ins = instruction("popq", "%r9");
        insts.push_back(ins);
        ins = instruction("popq", "%r8");
        insts.push_back(ins);
        ins = instruction("popq", "%rdx");
        insts.push_back(ins);
        ins = instruction("popq", "%rcx");
        insts.push_back(ins);
        ins = instruction("popq", "%rax");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::NONE_RETURN_VAL) {
        // restore original state of registers
        ins = instruction("popq", "%r11");
        insts.push_back(ins);
        ins = instruction("popq", "%r10");
        insts.push_back(ins);
        ins = instruction("popq", "%r9");
        insts.push_back(ins);
        ins = instruction("popq", "%r8");
        insts.push_back(ins);
        ins = instruction("popq", "%rdx");
        insts.push_back(ins);
        ins = instruction("popq", "%rcx");
        insts.push_back(ins);
        ins = instruction("popq", "%rax");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::PUSH_PARAM){   // pushq a(x) || pushq const
        if(y == 1) {        // first parameter, perform caller saved registers
            ins = instruction("pushq", "%rax");
            insts.push_back(ins);
            ins = instruction("pushq", "%rcx");
            insts.push_back(ins);
            ins = instruction("pushq", "%rdx");
            insts.push_back(ins);
            ins = instruction("pushq", "%r8");
            insts.push_back(ins);
            ins = instruction("pushq", "%r9");
            insts.push_back(ins);
            ins = instruction("pushq", "%r10");
            insts.push_back(ins);
            ins = instruction("pushq", "%r11");
            insts.push_back(ins);
        }
        if(!isVariable(q.arg1)) {  // it is just a constant
            ins = instruction("pushq", "$" + q.arg1, "");
            insts.push_back(ins);
        } 
        else {
            ins = instruction("pushq", to_string(x) + "(%rbp)"); // load rbp + x
            insts.push_back(ins);    
        }
    }
    else if(q.made_from == quad::PRINT_STR){
        ins = instruction("movq", to_string(x) + "(%rbp)", "%rdi");
        insts.push_back(ins);
        ins = instruction("call", "puts");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::MAKE_STR){
        ins = instruction("leaq", q.arg1 + "(%rip)", "%rdi");
        insts.push_back(ins);
        ins = instruction("movq", "%rdi", to_string(x) + "(%rbp)");
        insts.push_back(ins);
    }
    else if(q.made_from == quad::EXIT){
        ins = instruction("leaq", ".LC0(%rip)", "%rdi");
        insts.push_back(ins);
        ins = instruction("call", "puts");
        insts.push_back(ins);
        ins = instruction("movq", "$60", "%rax");
        insts.push_back(ins);
        ins = instruction("xor", "%rdi", "%rdi");
        insts.push_back(ins);
        ins = instruction("syscall");
        insts.push_back(ins);

    }
    return insts;
}

task_struct::task_struct() {        // initialize the data members
    code.clear();
    procedures.clear();
}

void task_struct::get_tac_procedures() {
    vector<quad> procedure;

    bool func_started = false;

    for(quad q : root_node -> ta_codes) {
        if(q.made_from == quad::BEGIN_FUNC) {
            func_started = true;
        }

        if(func_started) {
            procedure.push_back(q);
        }

        if(q.made_from == quad::END_FUNC) {
            func_started = false;
            if(procedure.size()){
                this -> procedures.push_back(procedure);
                procedure.clear();
            }
        }
    }
}

void task_struct::gen_global() {
    instruction ins;
    ins = instruction(".section\t.rodata", "", "", "", "segment");
    this -> code.push_back(ins);
    
    ins = instruction("integer_format:", ".asciz", "\"%ld\\n\"", "", "ins");
    this -> code.push_back(ins);
    ins = instruction(".LC0:", "", "", "", "segment");
    this->code.push_back(ins);
    ins = instruction(".string", "\"List Index OutofBound!\"");
    this->code.push_back(ins);
    for(auto it:string_list){
        ins = instruction(it.second + ":", "", "", "", "segment");
        this->code.push_back(ins);
        ins = instruction(".string", it.first);
        this->code.push_back(ins);
    }

    ins = instruction(".global", "main", "", "", "segment"); 
    this -> code.push_back(ins);
}

void task_struct::gen_basic_block(vector<quad> BB, procedure_table* sub_table) {
    for(quad q : BB) {
        vector<instruction> insts;
        if(q.made_from == quad::CONDITIONAL){
            int x = sub_table -> lookup_table[q.arg1].offset;
            int y = q.abs_jump;
            insts = this -> make_x86_code(q, x, y);
        }
        else if(q.made_from == quad::GOTO){
            insts = this -> make_x86_code(q, q.abs_jump);
        }
        else if(q.made_from == quad::BINARY){
            int z = sub_table -> lookup_table[q.result].offset;
            int x = sub_table -> lookup_table[q.arg1].offset;
            int y = sub_table -> lookup_table[q.arg2].offset;
            insts = this -> make_x86_code(q, x, y, z);            
        }
        else if(q.made_from == quad::UNARY){    // b(y) = op a(x)
            int y = sub_table -> lookup_table[q.result].offset;
            int x = sub_table -> lookup_table[q.arg1].offset;
            insts = this -> make_x86_code(q, x, y);           
        }
        else if(q.made_from == quad::ASSIGNMENT){   // b(y) = a(x)
            int y = sub_table -> lookup_table[q.result].offset;
            int x = sub_table -> lookup_table[q.arg1].offset;
            insts = this -> make_x86_code(q, x, y);                
        }
        else if(q.made_from == quad::STORE){        // *(r(z) + a2) = a1(x)
            int x = sub_table -> lookup_table[q.arg1].offset;
            int y = sub_table -> lookup_table[q.arg2].offset;   // always 0 since q.arg2 contains a constant always
            int z = sub_table -> lookup_table[q.result].offset;

            insts = this -> make_x86_code(q, x, y, z);
        }
        else if(q.made_from == quad::LOAD){         // r(z) = *(a1(x) + a2)
            int x = sub_table -> lookup_table[q.arg1].offset;
            int y = sub_table -> lookup_table[q.arg2].offset; // always 0 since q.arg2 contains a constant always
            int z = sub_table -> lookup_table[q.result].offset;

            insts = this -> make_x86_code(q, x, y, z);
        }
        else if(q.made_from == quad::PUSH_PARAM){   // push_param a1(x)
            int x = sub_table -> lookup_table[q.arg1].offset;
            sub_table -> number_of_params++;
            insts = this -> make_x86_code(q, x, sub_table -> number_of_params);
        }
        else if(q.made_from == quad::POP_PARAM){   // r(x) = pop_param
            insts = this -> make_x86_code(q);
        }
        else if(q.made_from == quad::FUNC_CALL) {
            insts = this -> make_x86_code(q, sub_table -> number_of_params);
            sub_table -> number_of_params = 0;          // reset variable
        }
        else if(q.made_from == quad::RETURN_VAL) {
            insts = this -> make_x86_code(q, sub_table -> lookup_table[q.result].offset);
        }
        else if(q.made_from == quad::BEGIN_FUNC) { 
            if(q.arg1 == "main") {
                sub_table -> is_main_function = true;
            }
            insts = this -> make_x86_code(q, sub_table -> total_space - 8 * stack_offset, sub_table -> is_main_function); 
        }
        else if(q.made_from == quad::END_FUNC) {    
            insts = this -> make_x86_code(q, sub_table -> is_main_function, sub_table -> total_space - 8 * stack_offset);
        }
        else if(q.made_from == quad::SHIFT_POINTER) {       
            insts = this -> make_x86_code(q);
        }
        else if(q.made_from == quad::RETURN) {   
            insts = this -> make_x86_code(q, sub_table -> total_space - 8 * stack_offset, sub_table -> lookup_table[q.arg1].offset);
        }
        else if(q.made_from == quad::NONE_RETURN_VAL){
            insts = this -> make_x86_code(q);
        }
        else if(q.made_from == quad::PRINT_STR){
            int y = sub_table -> lookup_table[q.arg1].offset;
            insts = this -> make_x86_code(q, y);
        }
        else if(q.made_from == quad::MAKE_STR){
            int y = sub_table -> lookup_table[q.result].offset;
            insts = this -> make_x86_code(q, y);
        }
        else if(q.made_from == quad::EXIT){
            insts = this->make_x86_code(q);
        }
        else{
            insts = this -> make_x86_code(q);
        }
        for(instruction ins : insts) {
            this -> code.push_back(ins);
        }
    }
}

void task_struct::gen_tac_basic_block(vector<quad> procedure, procedure_table* sub_table) {    // generates basic blocks from procedures
    set<int> leaders;
    vector<quad > BB;

    int base_offset = procedure[0].ins_line;
    leaders.insert(base_offset);

    for(quad q : procedure) {
        if(q.made_from == quad::CONDITIONAL || q.made_from == quad::GOTO) {
            leaders.insert(q.abs_jump);
            leaders.insert(q.ins_line + 1);
        }
        else if(q.made_from == quad::FUNC_CALL) {
            leaders.insert(q.ins_line);
            leaders.insert(q.ins_line + 1); // call func is made of a singular basic block
        }
    }

    vector<int> ascending_leaders;
    for(int leader : leaders) { 
        ascending_leaders.push_back(leader); 
    }
    
    int prev_leader = ascending_leaders[0];
    for(int i = 1; i < ascending_leaders.size(); i++) {
        BB.clear();
        
        for(int j = prev_leader; j < ascending_leaders[i]; j++) {
            BB.push_back(procedure[j - base_offset]);
        }
        prev_leader = ascending_leaders[i];

        this -> gen_basic_block(BB, sub_table);
    }

    BB.clear();
    int final_leader = ascending_leaders[ascending_leaders.size() - 1];
    for(int i = final_leader; i - base_offset < procedure.size(); i++) {
        BB.push_back(procedure[i - base_offset]);
    }

    this -> gen_basic_block(BB, sub_table);
}

void task_struct::gen_text() {
    instruction ins(".text", "", "", "", "segment");
    this -> code.push_back(ins);

    func_name_map["print"] = "print";
    func_name_map["allocmem"] = "allocmem";
    func_name_map["strcmp1"] = "strcmp1";


    this -> get_tac_procedures();     

    for(auto procedure : this -> procedures) {
        procedure_table* sub_table = new procedure_table();
        sub_table -> construct_procedure_table(procedure);

        this -> sub_tables .push_back(sub_table);
        this -> gen_tac_basic_block(procedure, sub_table);
    }
}

void task_struct::print_code(string asm_file) {
    ofstream out(asm_file);
    for(auto ins : this -> code) {
        out << ins.code;
    }
    string line;
    ifstream helper_func("helper_func.s");
    while(getline(helper_func, line)){
        out << line << '\n';
    }
}

procedure_entry::procedure_entry() {}

procedure_entry::procedure_entry(string name, int offset) {
    this -> name = name;
    this -> offset = offset;
}

procedure_table::procedure_table(){}

void procedure_table::construct_procedure_table(vector<quad> procedure_ins) {
    int pop_cnt = 2;         // 1 8 byte space for the return address + old base pointer
    int local_offset = 8;    // 8 callee saved registers hence, 8 spaces kept free, rsp shall automatically be restored, rbp too
    
    for(quad q : procedure_ins) {
        if(q.made_from == quad::BEGIN_FUNC || q.made_from == quad::SHIFT_POINTER || q.made_from == quad::FUNC_CALL || q.made_from == quad::GOTO) {  
            continue; 
        }
        if(q.made_from == quad::POP_PARAM) {
            this -> lookup_table[q.result] = procedure_entry(q.result, stack_offset*pop_cnt);
            pop_cnt++;
        }
        else {
            if(q.made_from == quad::CONDITIONAL) {
                if(this -> lookup_table.find(q.arg1) == this -> lookup_table.end() && isVariable(q.arg1)) {
                    this -> lookup_table[q.arg1] = procedure_entry(q.arg1, -stack_offset*local_offset);
                    local_offset++;
                }
            }
            else if(q.made_from == quad::MAKE_STR){
                if(q.result != "" && this -> lookup_table.find(q.result) == this -> lookup_table.end() && isVariable(q.result)) {
                    this -> lookup_table[q.result] = procedure_entry(q.result, -stack_offset*local_offset);
                    local_offset++;
                }
            }
            else {
                if(q.arg1 != "" && this -> lookup_table.find(q.arg1) == this -> lookup_table.end() && isVariable(q.arg1)) {
                    this -> lookup_table[q.arg1] = procedure_entry(q.arg1, -stack_offset*local_offset);
                    local_offset++;
                }
                else if(q.arg2 != "" && this -> lookup_table.find(q.arg2) == this -> lookup_table.end() && isVariable(q.arg2)) {
                    this -> lookup_table[q.arg2] = procedure_entry(q.arg2, -stack_offset*local_offset);
                    local_offset++;
                }
                else if(q.result != "" && this -> lookup_table.find(q.result) == this -> lookup_table.end() && isVariable(q.result)) {
                    this -> lookup_table[q.result] = procedure_entry(q.result, -stack_offset*local_offset);
                    local_offset++;
                }
            }
        }
    }

    this -> total_space = stack_offset * local_offset;   // total space occupied by callee saved registers + locals + temporaries
}
