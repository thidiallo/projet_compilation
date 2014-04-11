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
   return  concat(type, concat(" ",concat(ident,concat("(",concat(liste_arg,concat(")\n{\n", concat(dec_var, concat(bloc_inst,"\n}"))) ) )))); 
}


  //fonction de concatenation de deux chaines de caracteres
char* concat(const char *ch1, const char *ch2)
{
   int taille = strlen(ch1) + strlen(ch2);
   char * tmpConcat = (char*) malloc((taille+1)*sizeof(char));
 
   char* tmp = tmpConcat;

   while(*ch1 != '\0')
   {
     *tmp = *ch1;
     ch1++;
     tmp++;
   }
   while(*ch2 != '\0')
   {
     *tmp = *ch2;
     ch2++;
     tmp++;
   }
   *tmp = '\0';
   return tmpConcat;
}
/////////////////////////////////////////////////////////////////////////////////////////////
   // fonctions d'initialisation d'identificateur et de table de symbole
T_Table newTable()
{
   T_Table table = (T_Table)malloc(sizeof(T_Table));

   table->nom = NULL;
   table->nature = T_PORTEE;
   table->type = T_VOID;
   table->args = NULL;
   table->nbArgs = 0;
   table->bas = NULL;
   table->suivant = NULL;
   
   return table;
}


T_Ident newIdent(char * nom, T_NATURE nature, T_TYPE type )
{
   T_Ident identificateur = (T_Ident)malloc(sizeof(T_Ident));

   identificateur->nom = nom;
   identificateur->nature = nature;
   identificateur->type = type;
   identificateur->args = NULL;
   identificateur->nbArgs = 0;
   identificateur->bas = NULL;
   identificateur->suivant = NULL;
   
   return identificateur;
}

T_Pile  newPile()
{
  return NULL;
}

////////////////////////////////////////////////////////////////////////////////////////////
/// definition des fonctions de la table des symboles
   
    //fonction empiler
void empilerTable(T_Pile pile, T_Table tableSymbole)
{
   if( pile ==NULL )
   {
      pile = tableSymbole;
   }else{
            tableSymbole->bas = pile;
            pile = tableSymbole;
        }
}

   //fonction depiler
void depilerTable(T_Pile pile)
{
   if( pile !=NULL )
   {
      pile = pile->bas;
   }
}

   //fonction de recherche d'un identificateur
T_Ident rechercherIndent(T_Pile pile, char* indent)
{
   T_Pile iterPile = pile;
   while(iterPile != NULL)
   {
       T_Table iterTable = iterPile->suivant;
       while(iterTable != NULL)
       {
         if( strcmp(iterTable->nom, indent) )
         {
            return iterTable;
         }
         iterTable = iterTable->suivant;
       }
      iterPile = iterPile->bas;
   }
   return NULL;
}

  //procedure d'jout d'un identificateur 
void ajouterIndent(T_Pile pile, T_Ident ident)
{
   if(pile == NULL)
   {
      pile = ident;
   }else{
           if(pile->suivant == NULL)
           {
              pile->suivant = ident;
           }else{
                   T_Table iterTable = pile->suivant;
                   while(iterTable->suivant !=NULL)
                   {
                     iterTable = iterTable->suivant;
                   }
                   iterTable = ident;
                }           
        }

}

  //fonction de verification d'un argument
T_Bool verifierArg(T_Ident fonc, int indexArg, T_TYPE type)
{
   if(indexArg > fonc->nbArgs )
   {
     return T_faux;
   }else{
           int i=1;
           T_Ident iterArg = fonc->args;
           while( i < indexArg)
           {
              if(iterArg != NULL)
              {
                 iterArg = iterArg->args;
              }
              i++;
           }
           
           if(iterArg != NULL && iterArg->type == type )
           {
              return T_vrai;
           }
           return T_faux;
        }
}

/////////////////////////////////////////////////////////////////////////////////////










