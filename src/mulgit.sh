#!/bin/bash
#PS4='$LINENO: '
#set -x
CYAN="\033[0;36m" 
WHITE="\033[1;37m"
NC="\033[0m"
RED="\033[0;31m"

exe() { echo "\$ $@" ; "$@" ; }
anykey() { printf "${WHITE}Press any key to continue...${NC}"; read -n1; }

GITREPOBASE=`git rev-parse --show-toplevel`
CONFIG="$GITREPOBASE/.mulgit"

if [ ! -f "$CONFIG" ]
then
    echo "${RED}Unable to find $CONFIG${NC}"
    exit 1
fi

readarray -t REPOS < <(tr -d "\r" < $GITREPOBASE/.mulgit)

printf "${WHITE}Verifying repository paths...${NC}\n"

for i in "${REPOS[@]}"
do
    cd $GITREPOBASE 
    cd $i > /dev/null 2>&1
    if [ $? != "0" ]
    then
        printf "${RED}Path does not exist: ${NC}$i"
        anykey
        exit 1
    fi

    ISGITDIR=`git rev-parse --is-inside-work-tree`
    if [ "$ISGITDIR" != "true" ]
    then
        anykey
        exit 1
    fi
    
done

printf "${WHITE}Executing commands...${NC}\n\n"

for i in "${REPOS[@]}"
do
    cd $GITREPOBASE
    cd $i
    printf "${CYAN}Output from $i\n"
    printf "===========================${NC}\n\n"
    exe git "${@}"
    printf "\n\n"
done

anykey