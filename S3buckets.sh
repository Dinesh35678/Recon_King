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

if [ -d ~/recon_king/$DOM/S3_Buckets ]; then
  echo " "
else
  mkdir -p ~/recon_king/$DOM/S3_Buckets
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
echo "${blue} [+] Started Scanning for Open S3 Buckets ${reset}"
echo " "

# Check if awscli is installed
if command -v aws &> /dev/null; then
  echo "${magenta} [+] AWS CLI is already installed ${reset}"
else
  echo "${blue} [+] Installing AWS CLI ${reset}"
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y awscli -qq > /dev/null
  if [ $? -ne 0 ]; then
    echo "${red} [-] Failed to install AWS CLI. Please check permissions. ${reset}"
    exit 1
  fi
fi

echo "${magenta} [+] Running S3 Bucket Scan ${reset}"
while read -r bucket; do
  bucket_name=$(echo $bucket | awk -F/ '{print $3}')
  if aws s3 ls s3://$bucket_name &> /dev/null; then
    echo "Bucket $bucket_name is accessible" >> ~/recon_king/$DOM/S3_Buckets/open_buckets.txt
  else
    echo "Bucket $bucket_name is not accessible or does not exist" >> ~/recon_king/$DOM/S3_Buckets/closed_buckets.txt
  fi
done < ~/recon_king/$DOM/Subdomains/all-alive-subs.txt

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
