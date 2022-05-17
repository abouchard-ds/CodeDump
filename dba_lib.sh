#!/bin/bash -
#-----------------------------------------------
## DBA Toolbox library
## Librairie de fonctions bash pour DBA Oracle

# Pour obtenir toute la documentation sur la librairie faire un
# grep "#@" toolbox.sh

# ne pas activer, reference recursives
# source $ORACLE_BASE/admin/scripts/lib/toolbox.sh

# Bash scripting best practices (pour une librarie c'est moins valide)
set -o errexit      # exit on error (bypass avec "||TRUE" si tu veux laisser une commande echouee mais le script continuer)
set -o nounset      # declaration et initialisation obligatoire des variables
set -o pipefail     #
# set -o xtrace     # activer pour debug

# Variable de version
declare -l -r "${LIB_VER}"=1.0

#@-----------------------------------------------------------------------------------
#@ Fonction     is_NUMBER()
#@ Description: Valide si le parametre donnee est un nombre
#@ Argument:    un string a valider
#@ Retour:      booleen
#@
function is_NUMBER()
{
  if [ "$1" -eq "$1" 2> /dev/null ]
  then
    return 1
  else
    return 0
  fi
}


#@ -----------------------------------------------------------------------------------
#@ Fonction     is_ARRAY()
#@ Description: Valide si le parametre donnee est un array
#@ Argument:    une variable a valider
#@ Retour:      booleen
#@ Notes:       ne marchera pas car la fonction telle qu'ecrite doit etre rouler dans le script lui-meme.
#@
function is_ARRAY()
{
  if [[ "$(declare -p variable_name)" =~ "declare -a" ]]; then
      return FALSE
  else
      return TRUE
  fi
}


# -----------------------------------------------------------------------------------
# methode alternative
#   [ $(id -u) -eq 0 ] && return $TRUE || return $FALSE
function is_ROOT()
{
  if [[ ${EUID} -ne 0 ]]; then
    return 1
  else
    return 0
  fi
}


# -----------------------------------------------------------------------------------
# id -u username retourne le UID et donc sont exit est 0 lorsque le user existe et 1 quand il existe pas
function is_USER()
{
  id -u $1 > /dev/null
  if [ $? != 0 ]; then
    return 1
  else
    return 0
  fi
}

#@ -----------------------------------------------------------------------------------
function is_USER2()
{
  grep ^$username: /etc/passwd
  if [ $? != 0 ]; then
      echo "No such user: $username"
      exit 1
  fi
}

# -----------------------------------------------------------------------------------
function is_FILE_EXISTS {
  local file=${1}
  if [[ ! -f "${file}" ]]; then
    return 1
  else
    return 0
  fi
}


# -----------------------------------------------------------------------------------
# test si un programme existe
function is_AVAIL()
{
  type $1 >/dev/null 2>&1
  if [ $? != 0 ]; then
    return 1
  else
    return 0
  fi
}

# ----------------------------------------------------------
# on assume: qu'un test a deja eu lieu pour voir si le serveur contient des BDs (/etc/oratab)
# on assume: sur le serveur 1 seule instance ASM existe. Donc pas besoin de SID, etc.
# on pourrait valider par v$database cluster=true mais on ne sais si le test aura lieu avec un DB up
function is_RAC()
{
  local asm=$(grep "^+ASM" /etc/oratab | grep -v "^#" | grep -v '^$' | cut -f1 -d:)
  local last="${asm: -1}"
  if [ "$last" -eq "$last" 2> /dev/null ]
  then
    return 1
  else
    return 0
  fi
}


# ----------------------------------------------------------
function is_ORACLE_SID
{
  grep "^$1" /etc/oratab &>/dev/null
  if [ $? != 0 ]
  then
    return 1
  else
    return 0
  fi
}


# ----------------------------------------------------------
function list_INST_NAME()
{
  INSTNAME=$(cat /tmp/oratab  | grep ASM | cut -d: -f1 | sed -r -e 's/\+ASM//')
  echo $(grep -v "^+ASM" /etc/oratab | grep -v "^#" | grep -v '^$' | cut -f1 -d: | grep "$INSTNAME$" )
}


# ----------------------------------------------------------
# amelioration: ca exclu une BD dont le DB_NAME contiendrait un chiffre
function list_DB_NAME()
{
  echo $(grep -v "^+ASM" /etc/oratab | grep -v "^#" | grep -v '^$' | cut -d: -f1 | sed -r 's/[0-9]+//' | sort -u)
}


# ----------------------------------------------------------
function sql_DB_UNIQUE_NAME()
{
  local ORACLE_SID=$1
  local ORAENV_ASK=NO
  source /usr/local/bin/oraenv &>/dev/null
  local DBUNAME=`sqlplus -s '/ as sysdba' << EOF 2>&1
  	set echo off
  	set feedback off
  	set pagesize 0
  	SELECT UPPER(DB_Unique_Name) FROM V\\$Database;
  EOF`
  echo $DBUNAME
}
# ----------------------------------------------------------
function sql_DB_NAME()
{
  local ORACLE_SID=$1
  local ORAENV_ASK=NO
  source /usr/local/bin/oraenv &>/dev/null
  local DBNAME=`sqlplus -s '/ as sysdba' << EOF 2>&1
  	set echo off
  	set feedback off
  	set pagesize 0
  	SELECT UPPER(Name) FROM V\\$Database;
  EOF`
  echo $DBNAME
}
# ----------------------------------------------------------
function sql_RECOV_DEST()
{
  local ORACLE_SID=$1
  local ORAENV_ASK=NO
  source /usr/local/bin/oraenv &>/dev/null
  local RECODEST=`sqlplus -s '/ as sysdba' << EOF 2>&1
  	set echo off
  	set feedback off
  	set pagesize 0
    SELECT Value from V\\$Parameter WHERE Name = 'db_recovery_file_dest';
  EOF`
  echo $RECODEST
}
# ----------------------------------------------------------
function sql_USER_DUMP()
{
  local ORACLE_SID=$1
  local ORAENV_ASK=NO
  source /usr/local/bin/oraenv &>/dev/null
  local RECODEST=`sqlplus -s '/ as sysdba' << EOF 2>&1
  	set echo off
  	set feedback off
  	set pagesize 0
	SELECT Value from V\\$Parameter WHERE Name = 'user_dump_dest';
  EOF`
  echo $RECODEST
}
# ----------------------------------------------------------
function list_ORA_HOME()
{
  echo $(cat /etc/oratab | grep -v "^#" | grep -v '^$' | cut -d: -f2 | sort -u)
}
# ----------------------------------------------------------
function get_ASM_SID()
{
  echo $(grep "^+ASM" /etc/oratab | grep -v "^#" | grep -v '^$' | cut -f1 -d:)
}
# ----------------------------------------------------------
function get_INST_TYPE()
{
  local ORACLE_SID=$1
  local ORAENV_ASK=NO
  source /usr/local/bin/oraenv &>/dev/null
  local INSTANCE_TYPE=`sqlplus -s '/ as sysdba' << EOF 2>&1
  	set echo off
  	set feedback off
  	set pagesize 0
  	SELECT Value FROM V\\$Parameter
  	WHERE Name = 'instance_type';
EOF`
  echo $INSTANCE_TYPE
}
# ----------------------------------------------------------
# SELECT * FROM PRODUCT_COMPONENT_VERSION;
# SELECT version FROM v$instance;
# select * from v$version;
#   SET SERVEROUTPUT ON
#   EXEC dbms_output.put_line( dbms_db_version.version );  # donne "11"
function sql_ORA_VER()
{
local ORACLE_SID=$1
local ORAENV_ASK=NO
source /usr/local/bin/oraenv &>/dev/null
local ORAVER=`sqlplus -s '/ as sysdba' << EOF 2>&1
  set echo off
  set feedback off
  set pagesize 0
  SELECT SUBSTR(Version,1,2) FROM V\\$Instance;
EOF`
echo $ORAVER
}
# ----------------------------------------------------------
function get_ORA_VER()
{
  opatch
}
