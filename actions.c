#include "actions.h"

void programmePrincipal(FILE *fic,char* entetes, char* sous_programmes, char* dec, char* corps)
{
   fprintf(fic,"#include <stdio.h>\n");
   fprintf(fic,"  %s\n",entetes);
   fprintf(fic,"  %s\n",sous_programmes);
   fprintf(fic,"int main(int argc, char *argv[])\n");
   fprintf(fic,"{\n");
   fprintf(fic,"  %s\n",dec);
   fprintf(fic,"  %s\n",corps);
   fprintf(fic,"  return 0;\n");
   fprintf(fic,"}\n");
}


char *converType(char * type)
{
   if(strcmp(type,"integer")==0 || strcmp(type,"boolean")==0 )
   {
     return strdup("int ");
   }else if(strcmp(type,"real")==0)
         {
           return strdup("float ");
         }else if(strcmp(type,"string")==0)
               {
                  return strdup("char* ");
               }else{
                      return strdup("char ");
                    }
}


char * fonction(char* type, char* ident, char* liste_arg, char* dec_var, char* bloc_inst )
{    
   if(strcmp(type,"void")==0)
   {
      return strdup("PROCEDURE");
   }else return strdup("FONCTION");

   /*
      strcat( strcat( strcat($7, strcat(strdup(" "),strcat($2,strcat(strdup("("),strcat($4,strdup(") \n"))))))
                              ,
                              strcat($10, strdup("\n")) 
                            )
                            ,
                            strcat(strdup("\n { \n"),strcat($13,strdup("\n }")))  
                   );
   */
}















