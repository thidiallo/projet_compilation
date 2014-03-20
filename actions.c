#include "actions.h"

void programmePrincipal(FILE *fic,char* defines, char* dec, char* corps)
{
   fprintf(fic,"#include <stdio.h>\n");
   fprintf(fic,"  %s\n",defines);
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

