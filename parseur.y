%{
    #include <stdio.h>
    #include<string.h>

    #include "actions.h"

    void yyerror(char *s);
    int yylex();

    extern FILE* yyin;
    extern FILE* yyout;

    char *entetes;  // variable de concatenation de tout ce qui doit etre comme entete en langage C
    char *sous_programmes; // variable de concatenation de tout ce qui doit etre comme sous-programme en langage C
   
    T_Pile pile = NULL;
%}

%union{
       char* string;
}

%nonassoc IDENT VIR
%left ';' RL '(' ')'
%left ',' ':' '.' TYPE
%left DEBUT FIN
%right PROGRAM
%right FUNCTION PROCEDURE

%token RL PROGRAM DEBUT FIN CORPS_PROG
%token DEC VAR CONST
%token <string> IDENT TYPE NOMBRE CHAR CHAINE
%token <string> FUNCTION
%token <string> PROCEDURE

%type <string> declarations
%type <string> dec_var liste_dec ident_var 
%type <string> dec_const liste_const val_const
%type <string> dec_fonc list_arg
%type <string> dec_proc


%type <string> bloc_inst

%start prog

%%
prog: PROGRAM IDENT ';' RL declarations DEBUT RL bloc_inst RL FIN '.' {
      programmePrincipal(yyout,entetes,sous_programmes, $5, $8);

        //declaration d'une nouvelle table de symbole
      T_Table tableSymbole = newTable();
      empilerTable(pile,tableSymbole);
};

declarations : dec_var declarations { $$ = concat($1,concat(strdup("\n"),$2)); } 
             | dec_const declarations {$$ = concat($1,$2); }
             | dec_fonc declarations { $$ = concat($1,$2); }
             | dec_proc declarations { $$ = concat($1,$2); }
             | { $$ = ""; }
             ;

dec_var: VAR liste_dec { $$ = $2; };
liste_dec: ident_var ':' TYPE ';' RL liste_dec { $$ = concat($3,concat(" ", concat($1, concat(";\n",$6)))); }
         | { $$ = ""; }
         ;

ident_var:
          IDENT { $$ = $1; }
         | IDENT ',' ident_var { $$ = concat($1,concat(",", $3)); }
         ;

dec_const: CONST liste_const { entetes = concat($2, concat("\n",entetes)); $$ =""; };
liste_const: IDENT ':' TYPE '=' val_const ';' RL liste_const { $$ = concat("#define ",concat($1,concat(" ",concat($5,concat("\n",$8)))));}
           | { $$ = ""; }
           ;
val_const: NOMBRE { $$ = $1;}
         | CHAR { $$ = $1;}
         | CHAINE { $$ = $1;}
         ;

dec_fonc: FUNCTION IDENT '(' list_arg ')' ':' TYPE ';' RL dec_var DEBUT RL bloc_inst RL FIN ';' RL { 
         $$ = "";
         sous_programmes = concat(sous_programmes, concat("\n", fonction($7, $2, $4, $10, $13 ))); 
};

dec_proc: PROCEDURE IDENT '(' list_arg ')' ';' RL dec_var DEBUT RL bloc_inst RL FIN ';' RL { 
         $$ = "";
         sous_programmes = concat( sous_programmes, concat( "\n", fonction("void", $2, $4, $8, $11 ))); 
};

list_arg: IDENT ':' TYPE ',' list_arg { $$ = concat($3, concat(" ", concat($1, concat(", ",$5)))); }
        | IDENT ':' TYPE { $$ =  concat($3, concat(" ",$1)); }
        |  { $$ =""; }
        ;

bloc_inst: CORPS_PROG { $$ = "corps\n"; }

%%


void yyerror(char *s)
{
   fprintf(stderr,"%s\n",s);
}

  //FONCTION MAIN
int main(int argc, char *argv[])
{
    FILE *f = NULL;
    FILE *fic_out = NULL;

    if(argc > 1)
    {
      f = fopen(argv[1],"r");
      if(f==NULL)
      {
        return -1;
      }
      yyin = f;
    }
    
    fic_out = fopen("program.c","w");
    yyout = fic_out;

    entetes = strdup("");
    sous_programmes = strdup("");

    yyparse();
    printf("\n");

    if(f!=NULL)
    {
      fclose(f);
    }
    fclose(fic_out);
}
