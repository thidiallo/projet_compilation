%{
    #include <stdio.h>
    #include<string.h>

    #include "actions.h"

    void yyerror(char *s);
    int yylex();

    extern FILE* yyin;
    extern FILE* yyout;

    char *defines;
%}

%union{
       char* string;
}

%nonassoc IDENT VIR
%left ';' RL
%left ',' ':'

%token RL DECLARATIONS CORPS CORPS_PROG PROGRAM DEBUT FIN FINPROG
%token DEC VAR CONST
%token <string> IDENT TYPE NOMBRE CHAR CHAINE

%type <string> dec_var liste_dec ident_var 
%type <string> dec_const liste_const val_const
%type <string> declarations
%type <string> corps_prog

%start prog

%%
prog: PROGRAM IDENT ';' RL declarations DEBUT RL corps_prog RL FINPROG { programmePrincipal(yyout,defines, $5, $8);};

declarations : declarations dec_var { $$ = strcat($1,strcat(strdup("\n"),$2)); } 
             | declarations dec_const {$$ = strcat($1,$2); }
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

dec_const: CONST liste_const { defines = strcat($2, strcat(strdup("\n"),defines)); $$ = strdup(""); };
liste_const: liste_const IDENT ':' TYPE '=' val_const ';' RL { $$ = strcat($1,strcat(strdup("\n"), strcat(strdup("#define "),strcat($2,strcat( strdup(" "),$6)))));}
           | { $$ = strdup(""); }
           ;
val_const: NOMBRE { $$ = $1;}
         | CHAR { $$ = $1;}
         | CHAINE { $$ = $1;}
         ;

corps_prog: CORPS_PROG { $$ = "corps\n"; }

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

    defines = strdup("");

    yyparse();
    printf("\n");

    if(f!=NULL)
    {
      fclose(f);
    }
    fclose(fic_out);
}
