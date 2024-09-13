identificador [a-zA-Z]([a-zA-Z0-9])*
digit [0-9]

%{
  int conta = 0;
%}

%%
{identificador} printf("cont = %d\n", ++conta);
%%

int yywrap(void){return 1;}


int main (int argc, char *argv[]){
  //yyin = fopen(argv[1], "r");
  yylex();
  return 0;
  //fclose(yyin);
  
}