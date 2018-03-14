#!/bin/sh

# This is needed because we set the needed environment variables in .bashrc
. $HOME/.bashrc

set -e

green=`tput setaf 2`
cyan=`tput setaf 6`
red=`tput setaf 1`
blue=`tput setaf 4`
yellow=`tput setaf 3`

reset=`tput sgr0`

api_token=$(printenv LOKALISE_API_TOKEN)
guest_project_id=$(printenv LOKALISE_GUEST_PROJECT_ID)
merchant_project_id=$(printenv LOKALISE_MERCHANT_PROJECT_ID)

echo "Which action to take? ${cyan}add${reset}, ${yellow}update${reset}, or ${red}delete?${reset}"
read action
echo "$action"

echo "Which project to apply to? ${blue}guest${reset} or ${yellow}merchant${reset}"
read target
if [ $target == "guest" ]
  then
    target_id=$guest_project_id
else
    target_id=$merchant_project_id
fi

echo "${cyan}key${reset} to ${yellow}$action${reset}"
read default_english_key

if [ $action == "add" ] || [ $action == "update" ]
  then
    echo "the key's default english value"
    read default_value_for_key
fi

function delete_key () {
  curl -X POST https://api.lokalise.co/api/string/remove \
     -d "api_token=$api_token" \
     -d "id=$target_id" \
     -d "keys=['$default_english_key']"
  return 0
}

function add_key () {
  curl -X POST https://api.lokalise.co/api/string/set \
     -d "api_token=$api_token" \
     -d "id=$target_id" \
     --data-urlencode "data=[ \
           { \
              \"key\": \"$default_english_key\", \
              \"platform_mask\": 1, \
              \"context\": \"\", \
              \"description\": \"en.strings\", \
              \"translations\": { \
                 \"en\": \"$default_value_for_key\", \
                 \"de\": \"\", \
                 \"zh_CN\": \"\", \
                 \"it\": \"\", \
                 \"fr\": \"\", \
                 \"es\": \"\" \
              } \
           } \
        ]"
  return 0
}

case $action in
    #List patterns for the conditions you want to meet
    add) 
      echo "${cyan}===== adding... =====${reset}"
      add_key
      ;;
    update) 
      echo "${blue}===== updating... =====${reset}"
      add_key
      ;;
    delete) 
      echo "${red}===== deleting... =====${reset}"
      delete_key
      ;;
    *) 
      echo "wrong."
      ;;
esac

