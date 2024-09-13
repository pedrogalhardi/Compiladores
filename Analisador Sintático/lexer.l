identificador [a-zA-Z]([a-zA-Z0-9])*
numero [0-9]+
espaco [ \t]+
novalinha [\n]
%x comentario

%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

programa return T_PROGRAMA;
inicio return T_INICIO;
fimprograma return T_FIM;

leia    return T_LEIA;
escreva  return T_ESCREVA;

se return T_SE;
entao return T_ENTAO;
senao return T_SENAO;
fimse return T_FIMSE;

enquanto return T_ENQTO;
faca return T_FACA;
fimenquanto return T_FIMENQTO;

"+" return T_MAIS;
"-" return T_MENOS;
"*" return T_VEZES;
div return T_DIV;

">" return T_MAIOR;
"<" return T_MENOR;
"=" return T_IGUAL;

e return T_E;
ou return T_OU;
nao return T_NAO;

"<-" return T_ATRIB;
"(" return T_ABRE;
")" return T_FECHA;

inteiro return T_INTEIRO;
logico return T_LOGICO;
V return T_V;
F return T_F;

{identificador} return T_IDENTIF;
{numero} return T_NUMERO;
{espaco} /* nao faz nada */
{novalinha} /* nao faz nada */

"//".*          /* comentario de linha */
"/*"             BEGIN(comentario);
<comentario>"*/" BEGIN(INITIAL);
<comentario>.    /* nao faz nada */
<comentario>\n   /* nao faz nada */

. printf("ERRO LEXICO");/*yyerror("caracter invalido");*/

%%