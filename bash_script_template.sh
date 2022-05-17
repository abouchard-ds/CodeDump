#!/bin/bash -
# #!/usr/bin/env bash

# Library Source
# source $PATH/toolbox.sh

# Bash scripting best practices
set -o errexit      # exit on error (bypass avec "||TRUE" si tu veux laisser une commande echouee mais le script continuer)
set -o nounset      # declaration et initialisation obligatoire des variables
set -o pipefail     #
# set -o xtrace     # activer pour debug

# Place your traps here
# Trap signals(interrupts) are as follow:
# source: http://man7.org/linux/man-pages/man7/signal.7.html
#   EXIT        EXIT      0
#   SIGHUP      HUP       1
#   SIGINT      INT       2         control+C
#   SIGQUIT     QUIT      3
#   SIGKILL     KILL      9
#   SIGTERM     TERM      15
trap trap_int INT     # lance fonction trap_int s'il pogne un ctrl+c
trap trap_ex  EXIT    # lance fonction trap_ex s'il fini correct. Peut-etre cleaner les variables.

# Declaration de variables
## best practice: Strive to put everything readonly and private local where possible
##                always declare a SCRIPT_VER variable
##                when debugging declare with -t   (trace)
## source: https://ss64.com/bash/syntax-expand.html
#   Quotes help to prevent issues when variable contains spaces
#   string interpolation: "${variable}.yml"
#   default/fallback values: "${variable:-something_else}"
#   string replacement: "${variable//from/to}".
declare -l -r "${SCRIPT_VER}"=1.0

#
# Usage statement
#

if [ $# == 0 ]; then
    echo "Usage: $0 filename"
    exit 1
fi
