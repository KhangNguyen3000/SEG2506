/* File........ scanner.c 
 * Contents.... C program getting tokens using lex 
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"

main() {
  /* declaration of yytext, global variable defined in yy.lex.c
   * which contains the text (chars) corresponding to a token 
   */
  extern yytext;
  
  /* declaration of integer token, used to get return value from
   * the call of the yylex() function 
   */
  int token;

  /* call of yylex() to get the next token */
  printf("Hit ^Z followed by enter to end the scanning\n");
  token = yylex();

  /* we loop until either EOF or ^D is encountered, or a bad 
   * token (anything except one reconized by lex) is found.
   */
  while(token > 0 && token != ERROR) {
    printf("  %s\t", yytext);
    printf("Token = ");
    if(token == 1) {
      printf("VARIABLE\n");
    } else if (token == 2) {
      printf("DIGIT\n");
    } else if (token == 3) {
      printf("OPERATOR\n");
    } else if (token == 4) {
      printf("EQUALS\n");
    } else if (token == 5) {
      printf("ASSIGN\n");
    } else if (token == 6) {
      printf("SEPARATOR\n");
    }
    token = yylex();
  }
  
  if(token == ERROR) {
    printf("Token '%s' is not a valid token !\n", yytext);
  }
  
}
