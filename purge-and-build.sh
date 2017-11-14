#!/usr/bin/env bash
RESET="\e[0m"
YELLOW="\e[93m"
GREEN="\e[32m"
RED="\e[31m"
BOLD="\e[1m"
INVERT="\e[7m"
PROJECTNAME=`cat pom.xml | grep "finalName" | sed -e 's/>/ /g' | sed -e 's/</ /g' | sed -e 's/\// /g' | sed -e 's/finalName/ /g' | sed -e 's/^[ \t]*//'`

regenerate_dir () {
    if [[ ! -e $1 ]]; then
        mkdir $1
        chmod 777 $1
    elif [[ ! -d $dir ]]; then
        EXIST=1
    fi
    touch $1/README.md
    echo "# $2" >> $1/README.md
    echo "---"      >> $1/README.md
    echo ""         >> $1/README.md
}



echo "+-------------------------------------------+"
echo -e "| ${INVERT}${BOLD} Purge ${RESET} and ${INVERT}${BOLD} build ${RESET} commandline w. ${BOLD}maven${RESET}  |"
echo "+-------------------------------------------+"
echo ""
echo -e "1. Project name from ${BOLD}${YELLOW}pom.xml${RESET}: ${BOLD}${GREEN}$PROJECTNAME${RESET}"
echo ""
echo "2. Purging the folders"
rm -fr target/
rm -fr lib/

echo -e "3. Building... ${BOLD}${YELLOW}mvn clean package${RESET}"
mvn clean package > target/build.log

echo -e "4. Adding... ${BOLD}${YELLOW}README.md${RESET} files."
regenerate_dir "target/" "Target"
regenerate_dir "lib/" "lib"
echo ""

ARTEFACTS=`ls target/*.jar 2>/dev/null | sed 's/\r/ /g' | sed 's/\n/ /g'`
if [ "$ARTEFACTS" == "" ]
then
    # Failed build
    echo -e "   ${BOLD}${RED}Error!${RESET} Please check ${BOLD}${YELLOW}target/build.log${RESET} (if exist)"
    echo "--- Done ---"
    echo ""
    exit 1
else
    # Build complete
    echo -e "   ${BOLD}${GREEN}OK!${RESET}"
    echo "   Artifacts produced: "
    echo -e "${BOLD}${YELLOW}${ARTEFACTS}${RESET}"
    echo "--- Done ---"
    echo ""
    exit 0
fi
