#define TAM_TSIMB 100
#define TAM_PSEMA 100

int TOPO_TSIMB=0;
int TOPO_PSEMA=0;
int ROTULO=0;
int CONTA_VARS=0;
int POS_SIMB;
int aux;
int numLinha=1;
char atomo[30];

struct  elem_tab_simbolos{
    char id[30];
    int desloca;
}TSIMB[TAM_TSIMB], elem_tab;

int PSEMA[TAM_PSEMA];

int busca_simbolo(char *ident){
    int i = TOPO_TSIMB-1;
    for(;strcmp(TSIMB[i].id, ident) && i>=0; i--);
    return i;
}

void insere_simbolo(struct elem_tab_simbolos *elem){
    if(TOPO_TSIMB == TAM_TSIMB){
        printf("OVERFLOW - tabela de simbolos");
    }
    else{
        POS_SIMB = busca_simbolo(elem->id);
        if(POS_SIMB != -1){
            printf("Identificador [%s] duplicado", elem->id);
        }
        TSIMB[TOPO_TSIMB] = *elem;
        TOPO_TSIMB++;
    }
}

void insere_variavel(char *ident){
    strcpy(elem_tab.id, ident);
    elem_tab.desloca = CONTA_VARS;
    insere_simbolo(&elem_tab);
}

void empilha(int n){
    if(TOPO_PSEMA == TAM_PSEMA){
        printf("OVERFLOW - Pilha Semantica");
    }
    PSEMA[TOPO_PSEMA++] = n;
}

int desempilha(){
    if(TOPO_PSEMA == 0){
        printf("UNDERFLOW - Pilha Semantica");
    }
    return PSEMA[--TOPO_PSEMA];
}