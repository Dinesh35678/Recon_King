#!/bin/bash

# colors
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

if [ -d ~/recon_king/$DOM/SSL_TLS ]; then
  echo " "
else
  mkdir -p ~/recon_king/$DOM/SSL_TLS
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
echo "${blue} [+] Started SSL/TLS Version Enumeration ${reset}"
echo " "

# Check if sslscan is installed
if command -v sslscan &> /dev/null; then
  echo "${magenta} [+] sslscan is installed ${reset}"
else
  echo "${blue} [+] Installing sslscan ${reset}"
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y sslscan -qq > /dev/null
  if [ $? -ne 0 ]; then
    echo "${red} [-] Failed to install sslscan. Please check permissions. ${reset}"
    exit 1
  fi
fi

# SSLScan
echo "${magenta} [+] Running sslscan for domain: $DOM ${reset}"
sslscan --no-colour $DOM > ~/recon_king/$DOM/SSL_TLS/sslscan.txt

# SSL Shopper
echo "${magenta} [+] Fetching SSL information from SSL Shopper ${reset}"
curl -s "https://www.sslshopper.com/ssl-checker.html#hostname=$DOM" -o ~/recon_king/$DOM/SSL_TLS/sslshopper.html

# crt.sh
echo "${magenta} [+] Fetching certificate information from crt.sh ${reset}"
curl -s "https://crt.sh/?q=$DOM" -o ~/recon_king/$DOM/SSL_TLS/crtsh.html

echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
