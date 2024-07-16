#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name: " DOM

if [ -d ~/recon_king/ ]; then
  echo " "
else
  mkdir ~/recon_king
fi

if [ -d ~/recon_king/$DOM/Whois ]; then
  echo " "
else
  mkdir -p ~/recon_king/$DOM/Whois
fi

echo "${red}

||=================================================================================================||
||												   || 
||	██████  ███████  ██████  ██████  ███    ██         ██   ██ ██ ███    ██  ██████  	   ||
||	██   ██ ██      ██      ██    ██ ████   ██         ██  ██  ██ ████   ██ ██       	   ||
||	██████  █████   ██      ██    ██ ██ ██  ██         █████   ██ ██ ██  ██ ██   ███ 	   ||
||	██   ██ ██      ██      ██    ██ ██  ██ ██         ██  ██  ██ ██  ██ ██ ██    ██ 	   ||
||	██   ██ ███████  ██████  ██████  ██   ████ ███████ ██   ██ ██ ██   ████  ██████  	   ||
||                                                                                 		   ||
||=========================================== Recon_king- G_7 =====================================||             

${reset}"
echo "${blue} [+] Started Scanning for Whois Info ${reset}"
echo " "

# Check if whois is installed
if command -v whois &> /dev/null; then
  echo "${magenta} [+] Running Whois for domains ${reset}"
else
  echo "${blue} [+] Installing Whois ${reset}"
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y whois -qq > /dev/null
  if [ $? -ne 0 ]; then
    echo "${red} [-] Failed to install whois. Please check permissions. ${reset}"
    exit 1
  fi
fi

echo "${magenta} [+] Running Whois for domains ${reset}"
for url in $(cat ~/recon_king/$DOM/Subdomains/all-alive-subs.txt); do
  domain=$(echo $url | awk -F/ '{print $3}')
  whois $domain > ~/recon_king/$DOM/Whois/$domain.txt
done

echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Successfully saved the results ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
