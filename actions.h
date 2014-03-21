#ifndef ACTIONS_H
#define ACTIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void programmePrincipal(FILE *fic,char* entetes, char* sous_programmes, char* dec, char* corps);

char * fonction(char* type, char* ident, char* liste_arg, char* dec_var, char* bloc_inst );

char *converType(char * type);

#endif
