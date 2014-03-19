%{
    #include <stdio.h>
    #include<string.h>

    #include "actions.h"

    void yyerror(char *s);
    int yylex();

    extern FILE* yyin;
    extern FILE* yyout;
%}

%union{
       char* string;
}
%token RL DECLARATIONS CORPS CORPS_PROG PROGRAM DEBUT FIN FINPROG
%token DEC VAR CONST
%token <string> IDENT TYPE NOMBRE CHAR CHAINE

%type <string> dec_var liste_dec ident_var corps_prog
%type <string> dec_const liste_const val_const
%type <string> declarations

%start prog

%%
prog: PROGRAM IDENT ';' RL declarations RL DEBUT RL corps_prog RL FINPROG { programmePrincipal(yyout, $5, $9);};

declarations : dec_var RL dec_const { $$ = strcat($1,$3); };

dec_var: VAR liste_dec { $$ = $2; };
liste_dec: ident_var ':' TYPE ';' { $$ = strcat($3,strcat($1,";\n")); };
ident_var:
          IDENT { $$ = $1; }
         |IDENT ',' ident_var { $$ = strcat($1,strcat(strdup(","),$3)); }
         ;

dec_const: CONST liste_const { $$ = $2; };
liste_const: IDENT ':' TYPE '=' val_const { $$ = strcat( strdup("#define "),strcat($1,strcat( strdup(" "),$5 )) );};
val_const: NOMBRE { $$ = $1;}
         | CHAR { $$ = $1;}
         | CHAINE { $$ = $1;}
         ;

corps_prog: CORPS_PROG { $$ = "corps\n"; }

%%


void yyerror(char *s)
{
   fprintf(stderr,"erreur %s\n",s);
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

    yyparse();
    printf("\n");
    
    if(f!=NULL)
    {
fclose(f);
    }
    fclose(fic_out);
}
