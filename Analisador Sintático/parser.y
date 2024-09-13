%{
    
    int yylex(void);
    void yyerror(char *);
    #include <stdio.h>
    extern FILE *yyin;
%}

%token T_PROGRAMA T_INICIO T_FIM T_SE T_SENAO T_ENQTO T_FIMENQTO T_LEIA T_ESCREVA T_ENTAO T_FIMSE T_FACA T_MAIS T_MENOS T_VEZES T_DIV T_MAIOR T_MENOR T_IGUAL T_E T_OU T_NAO T_ATRIB T_ABRE T_FECHA T_INTEIRO T_LOGICO T_V T_F T_IDENTIF T_NUMERO;

%%

programa:
    cabecalho variaveis T_INICIO lista_comandos T_FIM
    ;

cabecalho:
    T_PROGRAMA T_IDENTIF
    ;

variaveis:
    | declaracao_variaveis
    |
    ;

declaracao_variaveis:
    tipo lista_variaveis declaracao_variaveis
    | tipo lista_variaveis
    ;

tipo:
    T_LOGICO
    | T_INTEIRO
    ;

lista_variaveis:
    T_IDENTIF lista_variaveis
    |   T_IDENTIF
    ;

lista_comandos:
    comando lista_comandos
    |
    ;

comando:
    entrada_saida
    | repeticao
    | selecao
    | atribuicao
    ;

entrada_saida:
    leitura
    | escrita
    ;

leitura:
    T_LEIA T_IDENTIF
    ;

escrita:
    T_ESCREVA expressao
    ;

repeticao:
    T_ENQTO expressao T_FACA
    lista_comandos T_FIMENQTO
    ;

selecao:
    T_SE    expressao T_ENTAO lista_comandos
    T_SENAO lista_comandos T_FIMSE
    ;

atribuicao:
    T_IDENTIF T_ATRIB expressao
    ;
    
expressao:
    expressao T_VEZES expressao
    | expressao T_DIV expressao
    | expressao T_MAIS expressao
    | expressao T_MENOS expressao
    | expressao T_MAIOR expressao
    | expressao T_MENOR expressao
    | expressao T_IGUAL expressao
    | expressao T_E expressao
    | expressao T_OU expressao
    | termo
    ;

termo:
    T_IDENTIF
    | T_NUMERO
    | T_V
    | T_F
    | T_NAO termo
    | T_ABRE expressao T_FECHA
    ;

%%

void yyerror(char *s){
    printf("%s ERRO SINTATICO\n", s);
}

int yywrap(void){return 1;}

int main(){
    int i = 0;
    yyin=fopen("teste.simples","r+");
    do{
        if(yyin==NULL){
            printf("Error in OPEN!");
        }else{
            yyparse();
        }
    }while(!feof(yyin));
}