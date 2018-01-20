#!/bin/sh

# scripts/bootstrap_ruby: Installs homebrew.
#                         Installs rvm.
#                         Installs ruby.
#                         Installs Bundler.

set -e

green=`tput setaf 2`
reset=`tput sgr0`

if [ -z $(which brew) ]; then
  echo "${green}===== Installing Homebrew… =====${reset}"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "${green}===== Updating Homebrew… =====${reset}"
  brew update
fi

echo "${green}===== Installing openssl… =====${reset}"
brew install openssl

if [ $(xcode-select -p) = 2 ]; then
  echo "${green}===== Installing command line tools… =====${reset}"
  xcode-select --install
fi

echo "${green}===== Installing gnupg… =====${reset}"
brew install gnupg gnupg2

if brew ls --versions appledoc > /dev/null; then
  echo "${green}===== appledoc is already installed. =====${reset}"
else
  echo "${green}===== Installing appledoc… =====${reset}"
  brew install appledoc
fi

if brew ls --versions carthage > /dev/null; then
  echo "${green}===== carthage is already installed. =====${reset}"
else
  echo "${green}===== Installing carthage… =====${reset}"
  brew install carthage
fi

if [ -z $(which rvm) ]; then
  echo "${green}===== Requesting keys to install rvm… =====${reset}"
  gpg --keyserver wwwkeys.uk.pgp.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

  echo "${green}===== Installing rvm… =====${reset}"
  \curl -sSL https://get.rvm.io | bash -s stable
fi

echo "${green}===== Setting rvm environment… =====${reset}"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem

echo "${green}===== Installing ruby 2.3.1… =====${reset}"
rvm install 2.3.1 --disable-binary
rvm alias create default ruby-2.3.1
rvm use ruby-2.3.1

echo "${green}===== Installing gems… =====${reset}"
gem install bundler

echo "${green}===== Script is succeeded… =====${reset}"
echo "${green}===== Please add the next lines into your .bash_profile =====${reset}"
echo "${green}[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && source \"$HOME/.rvm/scripts/rvm\"${reset}"
echo "${green}export DANGER_GITHUB_API_TOKEN='please ask the team to provide it to you'${reset}"
echo "${green}export CONICHI_CI_GITHUB_TOKEN='please ask the team to provide it to you'${reset}"
echo "${green}export LOKALISE_API_TOKEN='please ask the team to provide it to you'${reset}"
echo "${green}export LOKALISE_GUEST_PROJECT_ID='please ask the team to provide it to you'${reset}"
echo "${green}export LOKALISE_MERCHANT_PROJECT_ID='please ask the team to provide it to you'${reset}"

# After adding SSL_CERT_FILE into .bash_profile, Homebrew will warn the following when running 'brew doctor'.
# Setting SSL_CERT_FILE can break downloading files;
# if that happens you should unset it before running Homebrew.
# Homebrew uses the system curl which uses system certificates by default.
# Setting SSL_CERT_FILE makes it use an outdated OpenSSL, which does not support modern OpenSSL certificate stores.
# Therefore, comment the following line temporarily.
# echo "${green}export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem${reset}"
