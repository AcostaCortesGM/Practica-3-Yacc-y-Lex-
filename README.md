# Acosta Cortes Gerardo Michel
# Castillo Salgado Edgar Sebastian

# Yacc-y-lex
Yacc es un generador es un generador de analizador LALR(LookAhead, Left-to-right), fue diseñado originalmente para ser complementado por Lex.

El archivo de entrada YACC se divide en tres partes:
>1. Definiciones
>2. Reglas
>3. Rutinas auxiliares

## Definiciones:
Incluye informacion sobre los tokens utilizados en la definición de sintaxis, ejemplo:
>%token Number

Yacc asigna automaticamente números para tokens, pero se puede anular asignando un valor
>%token ID 624

Yacc también reconoce caracteres individuales como tokens. Por lo tanto, los números de token asignados no deben superponerse a los códigos ASCII.La parte de definición puede incluir código C externo a la definición del analizador y las declaraciones de variables, dentro de %{y%} en la primera columna.

También puede incluir la especificación del símbolo inicial en la gramática:
>%start nonterminal

## Reglas:
Contiene la definición gramatical en una forma BNF, por otro lado, Actions es código C en {} y se puede incluir dentro

## Rutinas auxiliares:
Esta parte es solo codigo C, incluye definiciones de funciones para cada función necesaria en la parte de reglas, tambien puede contener la definición de la función main() si el analizador se va a ejecutar como un programa, esta a su vez debe llamar a la función yyparse().

# Archivo de entrada:
Si yylex() no está definido en las secciones de rutinas auxiliares, entonces debe incluirse:
>#include "lex.yy.c"  

El archivo de entrada YACC generalmente termina con:
>.y 

# Archivo de salida:
La salida de YACC es un archivo llamado
>y.tab.c

Si contiene la definiciónmain(), debe compilarse para que sea ejecutable, de lo contrario, el código puede ser una definición de función externa para la funciónint yyparse() 
 
Si se llama con la opción –den la línea de comandos, Yacc produce como salida un archivo de encabezadoy.tab.hcon toda su definición específica (particularmente importantes son las definiciones de token que se incluirán, por ejemplo, en un archivo de entrada Lex).
 
Si se llama con la opción –v, Yacc genera como salida un archivoy.outputque contiene una descripción textual de la tabla de análisis LALR utilizada por el analizador. Esto es útil para rastrear cómo el analizador resuelve conflictos.

### Archivo Yacc (.y)
![image](https://user-images.githubusercontent.com/107780688/204977163-3a278c4e-73a4-42a7-a797-564ee916f442.png)

### Archivo Lex (.l)
![image](https://user-images.githubusercontent.com/107780688/204977384-b2a07bf8-86b6-415c-b1d2-950d77db3fea.png)

###### Para compilar el programa YACC: 
 
>1. Escribir el programa lex en un archivo file.l y yacc en un archivo file.y

>2. Abra Terminal y navegue hasta el Directorio donde ha guardado los archivos.

>3. Escriba lex file.l

>4. Escriba yacc file.y

>5. Escriba cc lex.yy.c y.tab.h -ll

>6. Escriba ./a.out
## DESARROLLO
#### Palindromo
En este programa se evalua si una cadena introducida es un palindromo, utilizando lex y yacc, En la parte de Lex solo se le ointroduce los simbolos aceptados que en este caso es de A-Z tanto minusculas como mayusculas, y retorna cualquier otro simbolo.

```
%%

[a-zA-Z]+ {yylval.f = yytext; return STR;}
[-+()*/] {return yytext[0];}
[ \t\n]	 {;}

%%
```
Despues manda a llamar a yywrap(), que es la interaccion con el archivo pal.y , esye se define primero las librerias y el yylex() del archivo pal.l, se hace la declaracion de flag y algunas variables que vamos a usar para identificar si es palindromo:
```
/* Rule Section */
%%

S : E {
		flag = 0;
		k = strlen($1) - 1;
		if(k%2==0){
		
		for (i = 0; i <= k/2; i++) {
		if ($1[i] == $1[k-i]) {
			} else {
			flag = 1;
			}
		}
		if (flag == 1) printf("Not palindrome\n");
		else printf("palindrome\n");
		printf("%s\n", $1);
		
		}else{
		
		for (i = 0; i < k/2; i++) {
		if ($1[i] == $1[k-i]) {
		} else {
			flag = 1;
			}
			}
		if (flag == 1) printf("Not palindrome\n");
		else printf("palindrome\n");
		printf("%s\n", $1);	
		}
	}
;```
Aqui se hace la evaluacion paramertro a parametro y seva comprobando si es igual de izquierda a derecha que de derecha a izquierda.
Su ejecución es la siguiente:

![image](https://github.com/AcostaCortesGM/Practica-3-Yacc-y-Lex-/blob/main/images/IMG-20221201-WA0008.jpg)


###Gramatica en a y b 
En este, el archivo lex se declara el lenguaje que va a usar el programa en este caso A y B y a y b, y en el archivo yacc se le hace la declaracion de token y su forma en la que se evalua que se haga la elevación de n números:
```%token A B NL

/* Rule Section */
%%
stmt: S NL { printf("valid string\n");
			exit(0); }
;
S: A S B |
;
%%

int yyerror(char *msg)
{
printf("invalid string\n");
exit(0);
}

//driver code
main()
{
printf("enter the string\n");
yyparse();
}
```
## Binario a Decimal 
Aqui se hace una declaracion de lenguaje binario (0 y 1) y se pone varias funciones de bison para poder manejar las cadenas introducidas tanto para validarlas como para rechazarlo:
```%{
/* Definition section */
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
extern int yylval;
%}

/* Rule Section */
%%
0 {yylval=0;return ZERO;}
1 {yylval=1;return ONE;}

[ \t] {;}
\n return 0;
. return yytext[0];
%%

	
int yywrap()
{
return 1;
}
```
Luego en la parte de yacc se hace la conversion a decimal, aqui se hace leyendo parametro por parametro "$" y aqui se hace que cada parte de el numerobinario sea 2 a la n, donde n es la posicion de izquierda a derecha de la casdena y asi es como se convierte a decimal
```/* Rule Section */
%%
N: L {printf("\n%d", $$);}
L: L B {$$=$1*2+$2;}
| B {$$=$1;}
B:ZERO {$$=$1;}
|ONE {$$=$1;};
%%

//driver code``
###Código par de 0s y 1s 
En la parte de lex se declaran los simbolos del lenguaje que son 0 y 1 y vamos a definir variables para usar funciones en el codigo yacc:
```
%%
[0] {return A;}
[1] {return B;}
\n {return NL;}
.  return yytext[0];
%%
```
En la parte de yacc definimos funciones para hacer contadores de 0s y 1s, se van haciendo una lectura de la cadena y cada cero y cada uno se va guardando en un arreglo, despues se mete a un bucle en el que se valida si es par o no cada arreglo y se va imprimiendo si es valido para la expresion o no.
```
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
```
##Numeros capicua de 0 al 1000
En la parte de lex se define el lenguaje con los numeros del 1 - 10:
```
%%
  
[0-9]+   {yylval.f = yytext; return STR;}
[ \t\n]      {;}
  
%%
```
En la parte sde yacc se hace la comprobación para identificar si es capicua o no, se hace una lectura por parametros, mas o menos como en la parte de palindromos pero ahora con numeros:
```
/* Seccion de reglas */
%%

S : E {
		flag = 0;
        k = strlen($1) - 1;
        if (k % 2 != 0) {

            for (i = 0; i <= k / 2; i++) {
                if ($1[i] == $1[k - i]) {} else {
                    flag = 1;
                }
            }
             if (flag == 1) printf("%s no es capicua\n", $1);
                else printf("%s si es capicua\n", $1);

            exit(0);

        } else {

            for (i = 0; i < k / 2; i++) {
                if ($1[i] == $1[k - i]) {} else {
                    flag = 1;
                }
            }
            if (flag == 1) printf("%s no es capicua\n", $1);
            else printf("%s si es capicua\n", $1);

            exit(0);

        }
	}
;
```
##Ejecuciones de los programas en la carperta de imagenes 
