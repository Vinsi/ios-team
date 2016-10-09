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

if [ -z $(which rvm) ]; then
  echo "${green}===== Requesting keys to install rvm… =====${reset}"
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

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
echo "${green}===== Please put next two lines into your .bash_profile =====${reset}"
echo "${green}[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && source \"$HOME/.rvm/scripts/rvm\"${reset}"
echo "${green}export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem${reset}"
