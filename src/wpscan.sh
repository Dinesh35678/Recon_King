#!/bin/bash

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/recon_king/ ]; then
  echo " "
else
  mkdir ~/recon_king
fi

if [ -d ~/recon_king/$DOM/wpscan ]; then
  echo " "
else
  mkdir -p ~/recon_king/$DOM/wpscan
fi

echo "${red}

||=================================================================================================||
||                                                   						   || 
||  ██████  ███████  ██████  ██████  ███    ██         ██   ██ ██ ███    ██  ██████    		   ||
||  ██   ██ ██      ██      ██    ██ ████   ██         ██  ██  ██ ████   ██ ██        		   ||
||  ██████  █████   ██      ██    ██ ██ ██  ██         █████   ██ ██ ██  ██ ██   ███  		   ||
||  ██   ██ ██      ██      ██    ██ ██  ██ ██         ██  ██  ██ ██  ██ ██ ██    ██  		   ||
||  ██   ██ ███████  ██████  ██████  ██   ████ ███████ ██   ██ ██ ██   ████  ██████    		   ||
||                                                                                  		   ||
||========================================== Recon_king- G_7 ======================================||             

${reset}"
echo "${blue} [+] Started WPScan Plugin Vulnerability Scanning ${reset}"
echo " "

# wpscan
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if command -v wpscan &> /dev/null; then
  echo "${magenta} [+] WPScan is installed ${reset}"
  echo "${blue} [+] Updating WPScan to the latest version ${reset}"
  gem update wpscan
else
  echo "${blue} [+] Installing WPScan ${reset}"
  gem install wpscan
fi

echo "${magenta} [+] Running WPScan for plugin vulnerabilities ${reset}"
wpscan --url https://$DOM --ignore-main-redirect --random-user-agent --enumerate p --output ~/recon_king/$DOM/wpscan/plugin_vulnerabilities.txt

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the plugin vulnerabilities results ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
