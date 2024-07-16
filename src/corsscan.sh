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

if [ -d ~/recon_king/$DOM ]
then
  echo " "
else
  mkdir ~/recon_king/$DOM

fi

if [ -d ~/recon_king/$DOM/CORS_Scan ]
then
  echo " "
else
  mkdir ~/recon_king/$DOM/CORS_Scan

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
echo "${blue} [+] Started Scanning for CORS Misconfiguration${reset}"
echo " "

#corsy
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/recon_king/tools/Corsy/corsy.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/recon_king/tools/Corsy/corsy.py -i ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/recon_king/$DOM/CORS_Scan/CORS_result.json
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/s0md3v/Corsy ~/recon_king/tools/Corsy
  pip install -r ~/recon_king/tools/Corsy/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/recon_king/tools/Corsy/corsy.py -i ~/recon_king/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/recon_king/$DOM/CORS_Scan/CORS_result.json
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
