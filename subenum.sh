#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

if [ -d ~/recon_king ]
then
  echo " "
else
  mkdir ~/recon_king 
fi

if [ -d ~/recon_king/tools ]
then
  echo " "
else
  mkdir ~/recon_king/tools 
fi

if [ -d ~/recon_king/$DOM ]
then
  echo " "
else
  mkdir ~/recon_king/$DOM 
fi

if [ -d ~/recon_king/$DOM/Subdomains ]
then
  echo " "
else
  mkdir ~/recon_king/$DOM/Subdomains 
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
echo "${blue} [+] Started Subdomain Enumeration ${reset}"
echo " "

#assefinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/assetfinder ]
then
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/recon_king/$DOM/Subdomains/assetfinder.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  go install github.com/tomnomnom/assetfinder@latest
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/recon_king/$DOM/Subdomains/assetfinder.txt
fi 
echo " "
echo "${blue} [+] Succesfully saved as assetfinder.txt  ${reset}"
echo " "

#amass
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/amass ]
then
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/recon_king/$DOM/Subdomains/amass.txt
else
  echo "${blue} [+] Installing Amass ${reset}"
  echo "${blue} [+] This may take few minutes hang tight... ${reset}"
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/recon_king/$DOM/Subdomains/amass.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as amass.txt  ${reset}"
echo " "

#subfinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/subfinder ]
then
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/recon_king/$DOM/Subdomains/subfinder.txt 
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/recon_king/$DOM/Subdomains/subfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as subfinder.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Fetching unique domains ${reset}"
echo " "
cat ~/recon_king/$DOM/Subdomains/*.txt | sort -u >> ~/recon_king/$DOM/Subdomains/unique.txt
echo "${blue} [+] Succesfully saved as unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/recon_king/$DOM/Subdomains/unique.txt | httpx >> ~/recon_king/$DOM/Subdomains/all-alive-subs.txt
  cat ~/recon_king/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/recon_king/$DOM/Subdomains/protoless-all-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go install github.com/projectdiscovery/httpx/cmd/httpx@latest
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/recon_king/$DOM/Subdomains/unique.txt | httpx >> ~/recon_king/$DOM/Subdomains/all-alive-subs.txt
  cat ~/recon_king/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/recon_king/$DOM/Subdomains/protoless-all-alive-subs.txt
fi
echo " "
echo "${blue} [+] Successfully saved the results"
echo " "

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
