%option yylineno
%option noyywrap

%{
    #include <bits/stdc++.h>
	#include "parser.tab.h"
    using namespace std;
    bool indentation_flag = false;
    bool newline_flag = true;
    stack<char> implicit_line_join;
	string text_block;
    stack<int> indentation_checking;
    int spaceCount = 0;
    void err (const char* s) {
        if(s == NULL) {
            printf("Error in memory allocation");
            exit(0);
        }
    }

%}


EXPLICIT_LINE_JOINING           \\(?:\r\n?|\n)[ \t]*
WHITESPACE                      [ \t\r\f\n]|\r\n

DIGIT                           [0-9]
NON_ZERO_DIGIT                  [1-9]
BIN_DIGIT                       [0-1]
OCT_DIGIT                       [0-7]
HEX_DIGIT                       {DIGIT}|[a-fA-F]

DEC_INTEGER                     ({NON_ZERO_DIGIT}(["_"]?{DIGIT})*)|("0"+(["_"]?"0")*)
BIN_INTEGER                     "0"("b"|"B")(["_"]?{BIN_DIGIT})+
OCT_INTEGER                     "0"("o"|"O")(["_"]?{OCT_DIGIT})+
HEX_INTEGER                     "0"("x"|"X")(["_"]?{HEX_DIGIT})+
INTEGER                         {DEC_INTEGER}|{BIN_INTEGER}|{OCT_INTEGER}|{HEX_INTEGER}

DIGIT_PART                      {DIGIT}(["_"]?{DIGIT})*
FRACTION                        "."{DIGIT_PART}
POINT_FLOAT                     ({DIGIT_PART}?{FRACTION})|({DIGIT_PART}".")
EXPONENT                        ("e"|"E")["+"|"-"]?{DIGIT_PART}
EXPONENT_FLOAT                  ({DIGIT_PART}|{POINT_FLOAT}){EXPONENT}
FLOAT_NUMBER                    {POINT_FLOAT}|{EXPONENT_FLOAT}

IMAGINARY_NUMBER                ({FLOAT_NUMBER}|{DIGIT_PART})("J"|"j")

NEWLINE                         "\n"|"\r"|"\r\n"

STRING_ESCAPE_SEQ               \\(?:'|\"|a|b|f|n|r|t|v)
LONG_STRING_CHAR                [^\\] 
SHORT_STRING_CHAR               [^\\'\n\"]
LONG_STRING_ITEM                {LONG_STRING_CHAR}|{STRING_ESCAPE_SEQ}
STRING_PREFIX                   ("r"|"u"|"R"|"U"|"f"|"F"|"fr"|"Fr"|"fR"|"FR"|"rf"|"rF"|"Rf"|"RF")
SHORT_STRING_ITEM               {SHORT_STRING_CHAR}|{STRING_ESCAPE_SEQ}
SHORT_STRING                    ([']({SHORT_STRING_ITEM}|[\"])*['])|([\"]({SHORT_STRING_ITEM}|['])*[\"])
LONG_STRING                     ([']['][']{LONG_STRING_ITEM}*['][']['])|([\"][\"][\"]{LONG_STRING_ITEM}*[\"][\"][\"])
STRING_LITERAL                  {STRING_PREFIX}?({SHORT_STRING}|{LONG_STRING})

NAME                            [a-zA-Z_][a-zA-Z0-9_]*

COMMENT                         [\t ]*#[^\n]*


%% 

{EXPLICIT_LINE_JOINING} {}

{COMMENT} {}

{NEWLINE}/[^ \t\n\r#] {
    if(implicit_line_join.empty()) {
        if(newline_flag) {
            char *copy_string = strdup(yytext);
            for (int i = yyleng - 1; i >= 0; --i )
                unput(copy_string[i]);
            free(copy_string);
            newline_flag = false;
            yylval.strval = strdup(yytext);
            return NEWLINE;
        }
        else {
            while(!indentation_checking.empty() && indentation_checking.top() > 0) {
                char *copy_string = strdup(yytext);
                for (int i = yyleng - 1; i >= 0; --i )
                    unput(copy_string[i]);
                free(copy_string);
                indentation_checking.pop();
                return DEDENT;
            }
            newline_flag = true;
        }
    }
}

{NEWLINE} {
    if(implicit_line_join.empty() ) { 
        spaceCount = 0;
        yylval.strval = strdup(yytext);
        return NEWLINE;
    }
}

^[\t ]*{NEWLINE} {
    if(implicit_line_join.empty()) {
        yylval.strval = strdup(yytext);
        string copy_string = strdup(yytext);
        unput(copy_string.back());
    }
}

^[\t ]* {
    if(implicit_line_join.empty()) {
        if(indentation_checking.empty()) {
            indentation_checking.push(0);
        }
        string whitespace = strdup(yytext);
        int wspace_tab = count(whitespace.begin(), whitespace.end(), '\t');
        int wspace_space = count(whitespace.begin(), whitespace.end(), ' ');
        int total = wspace_tab * 4 + wspace_space;
        if(total == indentation_checking.top()) {
            indentation_flag = false;
        }
        else if(total > indentation_checking.top()) {
            if(!indentation_flag) {
                indentation_checking.push(total);
                return INDENT;
            }
            else {
                exit(0);
            }
        }
        else {
            while(indentation_checking.top() != 0 && total < indentation_checking.top()) {
                char *copy_string = strdup(yytext);
                for (int i = yyleng - 1; i >= 0; --i)
                    unput(copy_string[i]);
                yy_set_bol(1);
                free(copy_string);
                indentation_checking.pop();
                indentation_flag = true;
                return DEDENT;
            }
        }
    }
}

{WHITESPACE} {}

<<EOF>> {
    while(!indentation_checking.empty() && indentation_checking.top() != 0) {
        char *copy_string = strdup(yytext);
        for (int i = yyleng - 1; i >= 0; --i)
            unput(copy_string[i]);
        yy_set_bol(1);
        free(copy_string);
        indentation_checking.pop();
        indentation_flag = true;
        return DEDENT;
    }
    return 0;
}

"int" {
    yylval.strval = strdup(yytext);
    return TYPE_INT;
}

"float" {
    yylval.strval = strdup(yytext);
    return TYPE_FLOAT;
}

"str" {
    yylval.strval = strdup(yytext);
    return TYPE_STRING;
}

"bool" {
    yylval.strval = strdup(yytext);
    return TYPE_BOOL;
}

"list" {
    yylval.strval = strdup(yytext);
    return TYPE_LIST;
}

"dict" {
    yylval.strval = strdup(yytext);
    return TYPE_DICT;
}

"__name__" {
    yylval.strval = strdup(yytext);
    return DUNDER_NAME;    
}

"\"__main__\""|'__main__' {
    yylval.strval = strdup(yytext);
    return DUNDER_MAIN;
}

{STRING_LITERAL} {
    yylval.strval = strdup(yytext);
    return STRING_LITERAL;
}

{INTEGER} {
    yylval.strval = strdup(yytext);
    return INTEGER;
}

{FLOAT_NUMBER} {
    yylval.strval = strdup(yytext);
    return FLOAT_NUMBER;
}

{IMAGINARY_NUMBER} {
    yylval.strval = strdup(yytext);
    return IMAGINARY_NUMBER;
}

"False" {
    yylval.strval = strdup(yytext);
    return KEY_FALSE;
}


"else" {
    yylval.strval = strdup(yytext);
    return KEY_ELSE;
}

"pass" {
    yylval.strval = strdup(yytext);
    return KEY_PASS;
}

"None" {
    yylval.strval = strdup(yytext);
    return KEY_NONE;
}

"break" {
    yylval.strval = strdup(yytext);
    return KEY_BREAK;
}

"except" {
    yylval.strval = strdup(yytext);
    return KEY_EXCEPT;
}

"in" {
    yylval.strval = strdup(yytext);
    return KEY_IN;
}

"True" {
    yylval.strval = strdup(yytext);
    return KEY_TRUE;
}

"class" {
    yylval.strval = strdup(yytext);
    return KEY_CLASS;
}

"finally" {
    yylval.strval = strdup(yytext);
    return KEY_FINALLY;
}

"is" {
    yylval.strval = strdup(yytext);
    return KEY_IS;
}

"return" {
    yylval.strval = strdup(yytext);
    return KEY_RETURN;
}

"and" {
    yylval.strval = strdup(yytext);
    return KEY_AND;
}

"continue" {
    yylval.strval = strdup(yytext);
    return KEY_CONTINUE;
}

"for" {
    yylval.strval = strdup(yytext);
    return KEY_FOR;
}

"try" {
    yylval.strval = strdup(yytext);
    return KEY_TRY;
}



"def" {
    yylval.strval = strdup(yytext);
    return KEY_DEF;
}

"nonlocal" {
    yylval.strval = strdup(yytext);
    return KEY_NONLOCAL;
}

"while" {
    yylval.strval = strdup(yytext);
    return KEY_WHILE;
}

"assert" {
    yylval.strval = strdup(yytext);
    return KEY_ASSERT;
}

"global" {
    yylval.strval = strdup(yytext);
    return KEY_GLOBAL;
}

"not" {
    yylval.strval = strdup(yytext);
    return KEY_NOT;
}


"elif" {
    yylval.strval = strdup(yytext);
    return KEY_ELIF;
}

"if" {
    yylval.strval = strdup(yytext);
    return KEY_IF;
}

"or" {
    yylval.strval = strdup(yytext);
    return KEY_OR;
}

"+" {
    yylval.strval = strdup(yytext);
    return OP_ADD;
}

"-" {
    yylval.strval = strdup(yytext);
    return OP_SUBTRACT;
}

"*" {
    yylval.strval = strdup(yytext);
    return OP_MULTIPLY;
}

"**" {
    yylval.strval = strdup(yytext);
    return OP_POWER;
}

"/" {
    yylval.strval = strdup(yytext);
    return OP_DIVIDE;
}

"//" {
    yylval.strval = strdup(yytext);
    return OP_FLOOR_DIVIDE;
}

"%" {
    yylval.strval = strdup(yytext);
    return OP_MODULO;
}

"@" {
    yylval.strval = strdup(yytext);
    return OP_AT;
}

"<<" {
    yylval.strval = strdup(yytext);
    return OP_LEFT_SHIFT;
}

">>" {
    yylval.strval = strdup(yytext);
    return OP_RIGHT_SHIFT;
}

"&" {
    yylval.strval = strdup(yytext);
    return OP_BITWISE_AND;
}

"|" {
    yylval.strval = strdup(yytext);
    return OP_BITWISE_OR;
}

"^" {
    yylval.strval = strdup(yytext);
    return OP_BITWISE_XOR;
}

"~" {
    yylval.strval = strdup(yytext);
    return OP_BITWISE_NOT;
}


"<" {
    yylval.strval = strdup(yytext);
    return OP_LESS_THAN;
}

">" {
    yylval.strval = strdup(yytext);
    return OP_GREATER_THAN;
}

"<=" {
    yylval.strval = strdup(yytext);
    return OP_LESS_THAN_EQUAL;
}

">=" {
    yylval.strval = strdup(yytext);
    return OP_GREATER_THAN_EQUAL;
}

"==" {
    yylval.strval = strdup(yytext);
    return OP_EQUAL;
}

"!=" {
    yylval.strval = strdup(yytext);
    return OP_NOT_EQUAL;
}

"(" {
    implicit_line_join.push('(');
    yylval.strval = strdup(yytext);
    return DELIM_LEFT_PAREN;
}

")" {
    if(!implicit_line_join.empty()) implicit_line_join.pop();
    yylval.strval = strdup(yytext);
    return DELIM_RIGHT_PAREN;
}

"[" {
    implicit_line_join.push('[');
    yylval.strval = strdup(yytext);
    return DELIM_LEFT_BRACKET;
}

"]" {
    if(!implicit_line_join.empty()) implicit_line_join.pop();
    yylval.strval = strdup(yytext);
    return DELIM_RIGHT_BRACKET;
}

"{" {
    implicit_line_join.push('{');
    yylval.strval = strdup(yytext);
    return DELIM_LEFT_CURLY;
}

"}" {
    if(!implicit_line_join.empty()) implicit_line_join.pop();
    yylval.strval = strdup(yytext);
    return DELIM_RIGHT_CURLY;
}

"," {
    yylval.strval = strdup(yytext);
    return DELIM_COMMA;
}

":" {
    yylval.strval = strdup(yytext);
    return DELIM_COLON;
}

"." {
    yylval.strval = strdup(yytext);
    return DELIM_DOT;
}

";" {
    yylval.strval = strdup(yytext);
    return DELIM_SEMICOLON;
}

"=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN;
}

"->" {
    yylval.strval = strdup(yytext);
    return DELIM_ARROW;
}

"+=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_ADD;
}

"-=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_SUBTRACT;
}

"*=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_MULTIPLY;
}

"/=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_DIVIDE;
}

"//=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_FLOOR_DIVIDE;
}

"%=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_MODULO;
}

"&=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_BITWISE_AND;
}

"|=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_BITWISE_OR;
}

"^=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_BITWISE_XOR;
}

">>=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_RIGHT_SHIFT;
}

"<<=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_LEFT_SHIFT;
}

"**=" {
    yylval.strval = strdup(yytext);
    return DELIM_ASSIGN_POWER;
}

"..." {
    yylval.strval = strdup(yytext);
    return DELIM_ELLIPSIS;
}


{NAME} {
    yylval.strval = strdup(yytext);
    return NAME;
}

%%