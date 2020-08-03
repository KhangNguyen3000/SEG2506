/* File........ tokens.lex 
 * Contents.... rules to get tokens from standard input
 * 
 */


/* ---------------- Definitions space ----------------- */
%option noyywrap
%{
#include "tokens.h"
%}


/* ------------------- Rules space -------------------- */
%%

[a-zA-Z][0-9a-zA-Z]*     return VARIABLE; 
[0-9]+                   return DIGIT;
[\+\-\/\*]               return OPERATOR;
\=                       return EQUALS;
\:\=                     return ASSIGN;
\;                       return SEPARATOR;

[\ ]+					 {}// do nothing for empty space
\n                       {}// do nothing for new line
.                        return ERROR;
%%

