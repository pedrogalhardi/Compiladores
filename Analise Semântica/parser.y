%{
    
    int yylex(void);
    void yyerror(char *);
    #include <stdio.h>
    extern FILE *yyin;
%}

%token T_PROGRAMA T_INICIO T_FIM T_SE T_SENAO T_ENQTO T_FIMENQTO T_LEIA T_ESCREVA T_ENTAO T_FIMSE T_FACA T_MAIS T_MENOS T_VEZES T_DIV T_MAIOR T_MENOR T_IGUAL T_E T_OU T_NAO T_ATRIB T_ABRE T_FECHA T_INTEIRO T_LOGICO T_V T_F T_IDENTIF T_NUMERO;
%left T_E T_OU
%left T_IGUAL
%left T_MAIOR T_MENOR
%left T_MAIS T_MENOS
%left T_VEZES T_DIV
%%

programa:
    cabecalho{ printf("\tINPP\n");} variaveis T_INICIO lista_comandos T_FIM{printf("\tFIMP\n");}
    ;

cabecalho:
    T_PROGRAMA T_IDENTIF
    ;

variaveis:
    | declaracao_variaveis {printf("\tAMEM\n");} 
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
    T_IDENTIF lista_variaveis {printf("\tCRVG\n");} 
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
    T_LEIA {printf("\tLEIA\n");} T_IDENTIF
    ;

escrita:
    T_ESCREVA{printf("\tESCR\n");}  expressao
    ;

repeticao:
    T_ENQTO expressao T_FACA {printf("\tDSVS\n");} 
    lista_comandos T_FIMENQTO {printf("\tDSVF\n");}
    ;

selecao:
    T_SE {printf("\tDSVS\n");}    expressao T_ENTAO lista_comandos
    T_SENAO {printf("\tDSVF\n");}  lista_comandos T_FIMSE
    ;

atribuicao:
    T_IDENTIF T_ATRIB {printf("\tARGZ\n");} expressao
    ;
    
expressao:
    expressao T_VEZES {printf("\tMULT\n");} expressao 
    | expressao T_DIV {printf("\tDIVI\n");} expressao
    | expressao T_MAIS {printf("\tSOMA\n");} expressao
    | expressao T_MENOS {printf("\tSUBT\n");}  expressao 
    | expressao T_MAIOR {printf("\tCMMA\n");} expressao
    | expressao T_MENOR {printf("\tCMME\n");} expressao
    | expressao T_IGUAL {printf("\tCMIG\n");}  expressao
    | expressao T_E {printf("\tCONJ\n");}  expressao
    | expressao T_OU {printf("\tDISJ\n");} expressao
    | termo
    ;

termo:
    T_IDENTIF
    | T_NUMERO
    | T_V
    | T_F
    | T_NAO {printf("\tNEGA\n");} termo
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