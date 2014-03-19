%{
   #include "actions.h"
   #include "parseur.tab.h"
   extern int yyparse();
%}

CHIFFRE [0-9]
LETTRE [a-zA-Z]
 
%%

"PROGRAM"|"program" { return PROGRAM;}

"BEGIN"|"begin" { return DEBUT;}
"END"|"end" { return FIN;}
"END."|"end." { return FINPROG;}
"corps" {return CORPS_PROG;}

"integer"|"boolean"|"real"|"char"|"string" { yylval.string = converType(yytext);  return TYPE;}

"var" {return VAR;}
"const" {return CONST;}
":" { return yytext[0];}
";" { return yytext[0];}
"," { return yytext[0];}
"=" { return yytext[0];}

{LETTRE}({LETTRE}|"_"|{CHIFFRE})* {  yylval.string = strdup(yytext);
				     return IDENT;}

{CHIFFRE}+("."{CHIFFRE}+)? { yylval.string = strdup(yytext);
		             return NOMBRE;}

\'{LETTRE}\' { yylval.string = strdup(yytext);
                   return CHAR; }

\"{LETTRE}+\" { yylval.string = strdup(yytext);
                   return CHAINE; }


(\n)* { return RL; }
<<EOF>> {exit(1);}

%%