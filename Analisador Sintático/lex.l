%option noyywrap

%{
#define T_PROGRAMA 1
#define T_INICIO 2
#define T_FIM 3

#define T_SE 4
#define T_ENTAO 5
#define T_SENAO 6
#define T_FIMSE 7

#define T_ENQTO 8
#define T_FIMENQTO 9

#define T_LEIA 10
#define T_ESCREVA 11

#define T_FACA 12

#define T_MAIS 13
#define T_MENOS 14
#define T_VEZES 15
#define T_DIV 16

#define T_MAIOR 17
#define T_MENOR 18
#define T_IGUAL 19

#define T_E 20
#define T_OU 21
#define T_NAO 22

#define T_ATRIB 23
#define T_ABRE 24
#define T_FECHA 25

#define T_INTEIRO 26
#define T_LOGICO 27

#define T_V 28
#define T_F 29

#define T_IDENTIF 30
#define T_NUMERO 31
%}

identificador [a-zA-Z]([a-zA-Z0-9])*
numero [0-9]+
espaco [ \t]+
novalinha [\n]

%x comentario

%%

programa printf("%11s:_palavra_reservada\n", yytext); return T_PROGRAMA;
inicio printf("%11s:_palavra_reservada\n", yytext); return T_INICIO;
fimprograma printf("%11s:_palavra_reservada\n", yytext); return T_FIM;

leia printf("%11s:_palavra_reservada\n", yytext); return T_LEIA;
escreva printf("%11s:_palavra_reservada\n", yytext); return T_ESCREVA;

se printf("%11s:_palavra_reservada\n", yytext); return T_SE;
entao printf("%11s:_palavra_reservada\n", yytext); return T_ENTAO;
senao printf("%11s:_palavra_reservada\n", yytext); return T_SENAO;
fimse printf("%11s:_palavra_reservada\n", yytext); return T_FIMSE;

enquanto printf("%11s:_palavra_reservada\n", yytext); return T_ENQTO;
faca printf("%11s:_palavra_reservada\n", yytext); return T_FACA;
fimenquanto printf("%11s:_palavra_reservada\n", yytext); return T_FIMENQTO;

"+" printf ("%11s:_operador_aritmetico_soma\n", yytext); return T_MAIS;
"-" printf ("%11s:_operador_aritmetico_subtracao\n", yytext); return T_MENOS;

"*" printf ("%11s:_operador_aritmetico_multiplicacao\n", yytext); return T_VEZES;
"div" printf ("%11s:_operador_aritmetico_divisao\n", yytext); return T_DIV;

">" printf ("%11s:_operador_relacional_maior\n", yytext); return T_MAIOR;
"<" printf ("%11s:_operador_relacional_menor\n", yytext); return T_MENOR;
"=" printf ("%11s:_operador_relacional_igual\n", yytext); return T_IGUAL;

"e" printf ("%11s:_operador_logico_conjucao\n", yytext); return T_E;
"ou" printf ("%11s:_operador_logico_disjuncao\n", yytext); return T_OU;
"nao" printf ("%11s:_operador_logico_negacao\n", yytext); return T_NAO;

"<-" printf ("%11s:_operador_de_atribuicao\n", yytext); return T_ATRIB;
"(" printf ("%11s:_simbolo_abre_parenteses\n", yytext); return T_ABRE;
")" printf ("%11s:_simbolo_fecha_parenteses\n", yytext); return T_FECHA;

"inteiro" printf ("%11s:_palavra_reservada\n", yytext); return T_INTEIRO;
"logico" printf ("%11s:_palavra_reservada\n", yytext); return T_LOGICO;
"V" printf ("%11s:_constante_logica_de_verdade\n", yytext); return T_V;
"F" printf ("%11s:_constante_logica_de_falsidade\n", yytext); return T_F;

"//".* {/*comentario de linha*/}
"/*" BEGIN(comentario);
<comentario>"*/" BEGIN(INITIAL);
<comentario>. {/*NADA*/}

{identificador} printf ("%11s:_identificador\n", yytext); return T_IDENTIF;
{numero} printf ("%11s:_numero\n", yytext); return T_NUMERO;
{espaco} /* não faz nada */ ;
{novalinha} /* não faz nada */ ;

%%

int main (void){
  yyin = fopen("teste.simples", "r");
  int token;
  while((token = yylex()) != 0) {
    printf("Token: %d\n", token);
  }
  fclose(yyin);
  return 0;
}
