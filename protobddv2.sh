#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # #
# Auteur : Adel Fortin
# Version : v0.0.1
# date : 30-06-2023
# # # # # # # # # # # # # # # # # # # # # # # # # #

# TODO
# Installe et configure une vm pour l'exploiter 
# - Résumé des options à renseigner pour le script
# $1 = l'option ou encore le type de distribution linux 
# $2 l'url du proxy utilisé
# $3 l'adresse où trouver les dépôts privés

VOLUME_LOGIQUE_BOOL=0
NOM_BDD=""
UTILISATEURS_BDD=("jam:1" "jjam:1" "nominoe:2")
MOT_DE_PASSE_BDD=""
ENCODING="UTF8"
NOM_HOTE=""

# You can use PGPASSWORD to avoid password prompt, but consider this can be insecure
export PGPASSWORD=$MOT_DE_PASSE_BDD

# Create a user
psql -U postgres -h localhost -c "CREATE ROLE $DB_USER LOGIN PASSWORD '$DB_PASS';"

# Create a database
psql -U postgres -h localhost -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"

# For security, unset the PGPASSWORD to avoid accidental use elsewhere
unset PGPASSWORD
creer_role() {
local utilisateur=$1
local profile=$2
  psql -U postgres -h $NOM_HOTE -c "CREATE ROLE $utilisateur LOGIN NOSUPERUSER INHERIT NOCREATEROLE NOREPLICATION;"
  
  if [ $profile -eq 2 ]; then
    psql -U postgres -h $NOM_HOTE -c "ALTER ROLE $utilisateur SET search_path = $utilisateur;"
  fi
}

injection_des_utilisateurs() {
  for item in $UTILISATEURS_BDD
  do
    UTILISATEUR=$(echo $item | cut -d':' -f1)
    PROFILE=$(echo $item | cut -d':' -f2)
    creer_role $UTILISATEUR $PROFILE
  done
  if [ $? == 0 ]; then
}
injection_des_donnees() {
  NOM_BDD="$1db"
  echo "$NOM_BDD"
  injection_des_utilisateurs
}

##########################################################
### Fonctions dédiés au traitement des arguments
##########################################################
## Fonction traitement DESCRIPTION :
# effectue le traitement attendu sur l'argument en cours de traitement.

traitement() {
  creation des 
  injection_des_donnees "$@"
  gestion_des_options "$@"
}

## Fonction usage DESCRIPTION :
# Programme d'amorce (main) qui lance le déroulement du script, et le termine avec le code retour correspondant à la résolution du script.
usage() {
  traitement "$@"
}

##########################################################
### PROGRAMME PRINCIPAL
##########################################################

# usage "$@"
usage "$@"
exit 0
#### FIN DU PROGRAMME
