%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    extern int yylex(); 

    int n, k, i, j ; // k será el tamaño de los segmentos.
    char segmentos[][k] ;
    char* s;

%}

%union {
    char* cadenaBinaria;
}

%token <cadenaBinaria> BIN
%type <cadenaBinaria> OUT

%%
    S: OUT {
        n = strlen($1) ;
        aumentarCantidadBit($1, k) ;
        j = k - 1 ;
        for(i = n - 1; i >= 0; i--) {
            while(j >= 0) {
                segmentos[i][j] = $1[i];
                if(i == (j * 4) - 1) {
                    j-- ;
                }
                printf("%s", segmentos[i][j]);
            }
        }
    }
    ;
    OUT: BIN {$$ = $1;};
%%

char* aumentarCantidadBits(char* $1, int k) {
    if(n % 4 == 0) {
        k = n / 4 ;
    }
    else {
        return aumentarCantidadBits(strcat('0',$1), k) ;
    }
    return $1;
}


int yyerror(char* mensaje) {
    printf("Error en la inserción de datos...\n");
    exit(-1);
}

main() {
    printf("Ingrese una cadena binaria para convertir en hexadecimal: ");
    yyparse();
}
