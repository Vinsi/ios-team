#!/bin/sh

# scripts/bootstrap_projects: Creates conichi directory.
#                             Clones all conichi ios projects.

set -e

green=`tput setaf 2`
reset=`tput sgr0`

cd $($HOME)

echo "${green}===== Creating home for all ios projects… =====${reset}"
if [ ! -d "conichi" ]; then
	mkdir conichi
fi


echo "${green}===== Moving into conichi directory… =====${reset}"
cd conichi

### ios-guest setup

echo "${green}===== Cloning ios-guest repo… =====${reset}"
git clone git@github.com:conichiGMBH/ios-guest.git ios-guest
cd ios-guest
make bootstrap
cd $($HOME/conichi)

### ios-merchant setup

echo "${green}===== Cloning ios-merchant repo… =====${reset}"
git clone git@github.com:conichiGMBH/ios-merchant.git ios-merchant
cd ios-merchant
make bootstrap
cd $($HOME/conichi)

### ios-beacon-tool setup

echo "${green}===== Cloning ios-beacon-tool repo… =====${reset}"
git clone git@github.com:conichiGMBH/ios-beacon-tool.git ios-beacon-tool
cd ios-beacon-tool
make bootstrap
cd $($HOME/conichi)

### ios-sdk setup

echo "${green}===== Cloning ios-sdk repo… =====${reset}"
git clone git@github.com:conichiGMBH/ios-sdk.git ios-sdk
cd ios-sdk
make bootstrap
cd $($HOME/conichi)

### ios-utilities setup

echo "${green}===== Cloning ios-utilities repo… =====${reset}"
git clone git@github.com:conichiGMBH/ios-utilities.git
cd ios-utilities
make bootstrap
cd $($HOME/conichi)
