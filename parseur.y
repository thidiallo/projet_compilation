%{
    #include <stdio.h>
    #include<string.h>

    #include "actions.h"

    void yyerror(char *s);
    int yylex();

    extern FILE* yyin;
    extern FILE* yyout;

    char *entetes;
    char *sous_programmes;
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
prog: PROGRAM IDENT ';' RL declarations DEBUT RL bloc_inst RL FIN '.' { programmePrincipal(yyout,entetes,sous_programmes, $5, $8);};

declarations : declarations dec_var { $$ = strcat($1,strcat(strdup("\n"),$2)); } 
             | declarations dec_const {$$ = strcat($1,$2); }
             | declarations dec_fonc { $$ = strcat($1,$2); }
             | declarations dec_proc { $$ = strcat($1,$2); }
             | { $$ = strdup(""); }
             ;

dec_var: VAR liste_dec { $$ = $2; };
liste_dec: liste_dec ident_var ':' TYPE ';' RL { $$ = strcat($1,strcat(strdup("\n"),strcat($4,strcat($2,";")))); }
         | { $$ = strdup(""); }
         ;
ident_var:
          IDENT { $$ = $1; }
         | ident_var ',' IDENT { $$ = strcat($3,strcat(strdup(","),$1)); }
         ;

dec_const: CONST liste_const { entetes = strcat($2, strcat(strdup("\n"),entetes)); $$ = strdup(""); };
liste_const: liste_const IDENT ':' TYPE '=' val_const ';' RL { $$ = strcat($1,strcat(strdup("\n"), strcat(strdup("#define "),strcat($2,strcat( strdup(" "),$6)))));}
           | { $$ = strdup(""); }
           ;
val_const: NOMBRE { $$ = $1;}
         | CHAR { $$ = $1;}
         | CHAINE { $$ = $1;}
         ;

dec_fonc: FUNCTION IDENT '(' list_arg ')' ':' TYPE ';' RL dec_var DEBUT RL bloc_inst RL FIN ';' RL { 
         $$ =  strdup("");
         sous_programmes = strcat(strcat(fonction($7, $2, $4, $10, $13 ) , strdup("\n")),sous_programmes); 
};

dec_proc: PROCEDURE IDENT '(' list_arg ')' ';' RL dec_var DEBUT RL bloc_inst RL FIN ';' RL { 
         $$ =  strdup("");
         sous_programmes = strcat(strcat(fonction("void", $2, $4, $8, $11 ) , strdup("\n")),sous_programmes); 
};

list_arg:list_arg ',' IDENT ':' TYPE { $$ = strcat($1, strcat(strdup(", "), strcat($5, strcat(strdup(" "),$3)))); }
        | IDENT ':' TYPE { $$ =  strcat($3, strcat(strdup(" "),$1)); }
        |  { $$ = strdup(""); }
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
