/* File........ scanner3.lex 
 * Contents.... Example of small scanner using LEX 
 */



/* ---------------- Definitions space ----------------- */
%option noyywrap
%{
#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

  int students = 0;
%}

DIGIT          [0-9]
STUDENT_ID     {DIGIT}{6,7}

/* ------------------- Rules space -------------------- */
%%
{STUDENT_ID}   { ++students; }
            
.|\n               { } // do nothing for all other characters
%%

/* ----------------- User code space ------------------ */
main()
{
  printf("Hit ^Z followed by enter to finish\n");
  yylex();
  printf("--- Students : %d\n", students);

}