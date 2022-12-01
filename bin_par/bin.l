%{
   /* Seccion de definicion */
  #include "y.tab.h"
%}

/* Seccion de reglas */
%%
[0] {return A;}
[1] {return B;}
\n {return NL;}
.  return yytext[0];
%%

int yywrap(){ 
return 1;}
