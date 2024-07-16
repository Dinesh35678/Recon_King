#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/recon_king/ ]
then
  echo " "
else
  mkdir ~/recon_king
fi

if [ -d ~/recon_king/$DOM/nuclei ]
then
  echo " "
else
  mkdir ~/recon_king/$DOM/nuclei
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
echo "${blue} [+] Started Nuclei Vulnerability Scanning ${reset}"
echo " "

#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/recon_king/$DOM/nuclei/cves_results.txt
  nuclei -l ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/recon_king/$DOM/nuclei/files_results.txt
  nuclei -l ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/recon_king/$DOM/nuclei/vulnerabilities_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/recon_king/$DOM/nuclei/cves_results.txt
  nuclei -l ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/recon_king/$DOM/nuclei/files_results.txt
  nuclei -l ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/recon_king/$DOM/nuclei/vulnerabilities_results.txt
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
