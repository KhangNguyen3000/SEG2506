/* File........ scanner2.lex 
 * Contents.... Example of small scanner using LEX 
 */


/* ---------------- Definitions space ----------------- */
%option noyywrap
%{
#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

  int num_lines = 0;
  int lower_case_chars = 0;
  int upper_case_chars = 0;
  int digits = 0;
  int others = 0;
%}


/* ------------------- Rules space -------------------- */
%%
\n          ++num_lines;
[a-z]       ++lower_case_chars;
[A-Z]       ++upper_case_chars;
[0-9]       ++digits;
.           ++others;
%%

/* ----------------- User code space ------------------ */
main()
{
  printf("Hit ^Z followed by enter to finish\n");
  yylex();
  printf("--- Lines           : %d\n", num_lines);
  printf("--- Lower case chars: %d\n", lower_case_chars);
  printf("--- Upper case chars: %d\n", upper_case_chars);
  printf("--- Digits          : %d\n", digits);
  printf("--- Others          : %d\n", others);

}

