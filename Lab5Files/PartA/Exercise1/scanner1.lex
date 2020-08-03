/* File........ scanner1.lex 
 * Contents.... Example of small scanner using LEX 
 *
 */


/* ---------------- Definitions space ----------------- */
%option noyywrap
%{
#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

  int num_lines = 0;
%}


/* ------------------- Rules space -------------------- */
%%

\n           { ++num_lines; }
.            { }// do nothing for all other characters

%%

/* ----------------- User code space ------------------ */
main()
{
  printf("Hit ^Z followed by enter to finish\n");
  yylex();
  printf("--- Lines           : %d\n", num_lines);
}
