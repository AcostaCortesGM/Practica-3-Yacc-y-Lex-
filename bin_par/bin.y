%{
   /* Definition section */
   #include<stdio.h>
   #include<stdlib.h>

   int unos = 0;
   int ceros = 0;
%}
  
%token A B NL
  
/* Seccion de reglas */
%%
stmt: S NL  { validar();
              exit(0); }
;
S: A {aumentarCeros();}
| B {aumentarUnos();}
| B S {aumentarUnos();}
| A S {aumentarCeros();}
;
%%
  
int yyerror(char *msg)
 {
  printf("Cadena invalida\n");
  exit(0);
  return 0;}
  
//driver code 
void main() {
  printf("Ingresa la cadena binaria: ");
  yyparse();}

void aumentarCeros() {
	ceros++;
}

void aumentarUnos() {
	unos++;
}

void validar() {

    printf("\nCeros: %d\n", ceros);
    printf("Unos: %d\n\n", unos);

	if((ceros%2 == 0 && ceros != 0 ) || (unos %2 == 0 && unos != 0)) {
        printf("Cadena valida\n");
    }else{
        printf("Cadena invalida\n");
    }
}
