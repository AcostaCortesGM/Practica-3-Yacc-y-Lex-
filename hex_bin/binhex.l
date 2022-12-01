%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}

%%
[01]* {yylval.cadenaBinaria = yytext; return BIN;}
. {return yytext[0];}
%%

int yywrap() {
    return 1 ;
}
