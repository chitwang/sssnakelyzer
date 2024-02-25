%option yylineno
%option noyywrap

%{
    #include <bits/stdc++.h>
	// #include "parser.tab.h"
    using namespace std;
    bool identation_flag = false;
    bool initial_line_ident = true;
	string text_block;
    stack<int> indentation_checking;  // make it extern variable
    int spaceCount = 0;
    bool newline_flag = true;
    void err (const char* s) {
        if(s == NULL) {
            printf("Error in memory allocation");
            exit(0);
        }
    }

%}


EXPLICIT_LINE_JOINING          \\(?:\r\n?|\n)
WHITESPACE_PURANA   [ \t\r\f\n]|\r\n
KEYWORD             False|await|else|import|pass|None|break|except|in|raise|True|class|finally|is|return|and|continue|for|lambda|try|as|def|from|nonlocal|while|assert|del|global|not|with|async|elif|if|or|yield

DIGIT               [0-9]
NON_ZERO_DIGIT      [1-9]
BIN_DIGIT           [0-1]
OCT_DIGIT           [0-7]
HEX_DIGIT           {DIGIT}|[a-fA-F]

DEC_INTEGER         ({NON_ZERO_DIGIT}(["_"]?{DIGIT})*)|("0"+(["_"]?"0")*)
BIN_INTEGER         "0"("b"|"B")(["_"]?{BIN_DIGIT})+
OCT_INTEGER         "0"("o"|"O")(["_"]?{OCT_DIGIT})+
HEX_INTEGER         "0"("x"|"X")(["_"]?{HEX_DIGIT})+
INTEGER             {DEC_INTEGER}|{BIN_INTEGER}|{OCT_INTEGER}|{HEX_INTEGER}

DIGIT_PART          {DIGIT}(["_"]?{DIGIT})*
FRACTION            "."{DIGIT_PART}
POINT_FLOAT         ({DIGIT_PART}?{FRACTION})|({DIGIT_PART}".")
EXPONENT            ("e"|"E")["+"|"-"]?{DIGIT_PART}
EXPONENT_FLOAT      ({DIGIT_PART}|{POINT_FLOAT}){EXPONENT}
FLOAT_NUMBER        {POINT_FLOAT}|{EXPONENT_FLOAT}

IMAGINARY_NUMBER    ({FLOAT_NUMBER}|{DIGIT_PART})("J"|"j")

OPERATORS           "+"|"-"|"*"|"**"|"/"|"//"|"%"|"@"|">>"|"&"|"|"|"^"|"~"|":="|">"|"<="|">="|"=="|"!="

NEWLINE             "\n"|"\r"|"\r\n"

STRING_ESCAPE_SEQ   "\"[.]
LONG_STRING_CHAR    [^\\] 
SHORT_STRING_CHAR   [^\\'\n\"]
LONG_STRING_ITEM    {LONG_STRING_CHAR}|{STRING_ESCAPE_SEQ}
STRING_PREFIX        "r"|"u"|"R"|"U"|"f"|"F"|"fr"|"Fr"|"fR"|"FR"| "rf"|"rF"|"Rf"|"RF"
SHORT_STRING_ITEM   {SHORT_STRING_CHAR}|{STRING_ESCAPE_SEQ}
SHORT_STRING        ([\"]'[\"]{SHORT_STRING_ITEM}*[\"]'[\"])|('[\"]'{SHORT_STRING_ITEM}*'[\"]')
LONG_STRING         ([\"]'''[\"]{LONG_STRING_ITEM}*[\"]'''[\"])|('[\"][\"][\"]'{LONG_STRING_ITEM}*'[\"][\"][\"]')
STRING_LITERAL      {STRING_PREFIX}?({SHORT_STRING}|{LONG_STRING})

ESCAPE_SEQUENCE     \\(?:'|"|a|b|f|n|r|t|v)

NAME                [a-zA-Z_][a-zA-Z0-9_]*

COMMENT             #[^\n]*

%% 

{EXPLICIT_LINE_JOINING} {
    
}

^[\t ]*{NEWLINE} {
    // yylval.strval = strdup(yytext);
    printf("blank line %d\n", yylineno);
}

{NEWLINE}/[^ \t\n] {
    if(newline_flag)
    {
        char *copy_string = strdup(yytext);
        for (int i = yyleng - 1; i >= 0; --i )
            unput(copy_string[i]);
        free(copy_string);
        newline_flag = false;
        // yylval.strval = strdup(yytext);
        printf("newline_next_is_empty %d\n", yylineno);
    }
    else
    {
        // bool flag = false;
        while(!indentation_checking.empty() && indentation_checking.top() > 0)
        {
            // flag = true;
            char *copy_string = strdup(yytext);
            for (int i = yyleng - 1; i >= 0; --i )
                unput(copy_string[i]);
            free(copy_string);
            indentation_checking.pop();
            printf("DEDENT %d\n", yylineno);
            return 1;
        }
        newline_flag = true;
    }

}

{NEWLINE} { 
    spaceCount = 0;
    // yylval.strval = strdup(yytext);
    printf("normal newline %d\n", yylineno);
    // return NEWLINE;
}


^[\t ]* {
    if(indentation_checking.empty())
    {
        indentation_checking.push(0);
    }
    string whitespace = strdup(yytext);
    int wspace_tab = count(whitespace.begin(), whitespace.end(), '\t');
    int wspace_space = count(whitespace.begin(), whitespace.end(), ' ');
    int total = wspace_tab * 4 + wspace_space;
    if(total == indentation_checking.top()) {
        identation_flag = false;
    }
    else if(total > indentation_checking.top()) {
        if(!identation_flag) {
            indentation_checking.push(total);
            //return INDENT;
            printf("INDENT %d\n", yylineno);
        }
        else {
            printf("Indentation Error %d\n", yylineno);
            exit(0);
        }
    }
    else {
        while(indentation_checking.top() != 0 && total < indentation_checking.top()) {
            char *copy_string = strdup(yytext);
            for (int i = yyleng - 1; i >= 0; --i )
                unput(copy_string[i]);
            free(copy_string);
            indentation_checking.pop();
            identation_flag = true;
            printf("DEDENT %d\n", yylineno);
            return 1;
        }
    }
}

. { }

%%

int main(){
    indentation_checking.push(0);
    yylex();


}