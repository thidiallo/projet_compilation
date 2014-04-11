#ifndef ACTIONS_H
#define ACTIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum T_NATURE { T_VAR, T_CONST, T_FONCTION, T_PROCEDURE, T_PORTEE};
enum T_TYPE {T_ENTIER, T_REEL, T_BOOLEEN, T_CHAINE, T_VOID};
enum T_Bool {T_vrai, T_faux};

  // definition de la table des symboles
struct T_Symbole{                
                char * nom;
                enum T_NATURE nature;
                enum T_TYPE type;
                
                struct T_Symbole * args ;
                int nbArgs;

                struct T_Symbole * bas ;
                struct T_Symbole * suivant;
              };

typedef enum T_Bool T_Bool;
typedef enum T_TYPE T_TYPE;
typedef enum T_NATURE T_NATURE;
typedef struct T_Symbole* T_Ident;
typedef struct T_Symbole* T_Table;
typedef struct T_Symbole* T_Pile;

   // fonctions d'initialisation d'identificateur et de table de symbole
T_Pile  newPile();
T_Table newTable();
T_Ident newIdent(char * nom, T_NATURE nature, T_TYPE type );

   // fonctions de gestion de la table des symboles
void empilerTable(T_Pile pile, T_Table tableSymbole);
void depilerTable(T_Pile pile);
T_Ident rechercherIndent(T_Pile pile, char* indent);
void ajouterIndent(T_Pile pile, T_Ident ident);
T_Bool verifierArg(T_Ident fonc, int indexArg, T_TYPE type); 

  // fonctions diverses 
void programmePrincipal(FILE *fic,char* entetes, char* sous_programmes, char* dec, char* corps);
char * fonction(char* type, char* ident, char* liste_arg, char* dec_var, char* bloc_inst );

char *converType(char * type);
char* concat(const char *ch1, const char *ch2);

#endif
