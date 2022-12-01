%{
    /* Definition section */
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
%}

/* Rule Section */
%%
  
[0-9]+   {yylval.f = yytext; return STR;}
[ \t\n]      {;}
  
%%
  
 int yywrap()
 { 
  return -1; 
 }  
