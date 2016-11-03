#!/bin/sh

# scripts/bootstrap: Runs ruby related bootstrap
#                    Runs projects related bootstrap

green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}===== bootstrap ruby… =====${reset}"

bash bootstrap_ruby.sh

echo "${green}===== bootstrap projects… =====${reset}"

bash bootstrap_projects.sh
