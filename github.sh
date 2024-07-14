#!/bin/bash

# colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter GitHub username/organization: " GH_USER

if [ -d ~/recon_king/ ]; then
  echo " "
else
  mkdir ~/recon_king
fi

if [ -d ~/recon_king/$GH_USER/GitHub_OSINT ]; then
  echo " "
else
  mkdir -p ~/recon_king/$GH_USER/GitHub_OSINT
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
echo "${blue} [+] Started GitHub OSINT ${reset}"
echo " "

# Check if git is installed
if command -v git &> /dev/null; then
  echo "${magenta} [+] Git is installed ${reset}"
else
  echo "${blue} [+] Installing Git ${reset}"
  sudo apt-get update -qq > /dev/null
  sudo apt-get install -y git -qq > /dev/null
  if [ $? -ne 0 ]; then
    echo "${red} [-] Failed to install Git. Please check permissions. ${reset}"
    exit 1
  fi
fi

# Check if jq is installed
if command -v jq &> /dev/null; then
  echo "${magenta} [+] jq is installed ${reset}"
else
  echo "${blue} [+] Installing jq ${reset}"
  sudo apt-get install -y jq -qq > /dev/null
  if [ $? -ne 0 ]; then
    echo "${red} [-] Failed to install jq. Please check permissions. ${reset}"
    exit 1
  fi
fi

# Check if gitLeaks is installed
if command -v gitleaks &> /dev/null; then
  echo "${magenta} [+] GitLeaks is installed ${reset}"
else
  echo "${blue} [+] Installing GitLeaks ${reset}"
  wget https://github.com/zricethezav/gitleaks/releases/download/v8.10.3/gitleaks_8.10.3_linux_x64.tar.gz -O /tmp/gitleaks.tar.gz
  tar -xzf /tmp/gitleaks.tar.gz -C /tmp
  sudo mv /tmp/gitleaks /usr/local/bin/gitleaks
  rm /tmp/gitleaks.tar.gz
  if [ $? -ne 0 ]; then
    echo "${red} [-] Failed to install GitLeaks. Please check permissions. ${reset}"
    exit 1
  fi
fi

# Fetch user/organization information
echo "${blue} [+] Checking user/organization: $GH_USER ${reset}"
user_info=$(curl -s -w "%{http_code}" "https://api.github.com/users/$GH_USER")
user_status=$(echo "$user_info" | tail -n1)
user_data=$(echo "$user_info" | head -n-1)

if [ "$user_status" -ne 200 ]; then
  echo "${red} [-] User/organization: $GH_USER not found (status: $user_status) ${reset}"
  exit 1
fi

# Fetch all public repositories
echo "${blue} [+] Fetching repositories for user/organization: $GH_USER ${reset}"
response=$(curl -s "https://api.github.com/users/$GH_USER/repos?per_page=100")

# Check if the response contains any repositories
repos=$(echo "$response" | jq -r '.[].clone_url' 2>/dev/null)
if [ -z "$repos" ]; then
  echo "${red} [-] No repositories found for user/organization: $GH_USER ${reset}"
  exit 1
fi

echo "${magenta} [+] Cloning repositories ${reset}"
for repo in $repos; do
  repo_name=$(basename $repo .git)
  git clone $repo ~/recon_king/$GH_USER/GitHub_OSINT/$repo_name
done

echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Successfully cloned the repositories ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "

echo "${blue} [+] Starting GitHub dorking ${reset}"
dorks=(
  "password"
  "secret"
  "aws_access_key_id"
  "api_key"
  "token"
  "authorization"
)

for dork in "${dorks[@]}"; do
  echo "${magenta} [+] Searching for $dork ${reset}"
  grep -r --exclude-dir=.git -i "$dork" ~/recon_king/$GH_USER/GitHub_OSINT > ~/recon_king/$GH_USER/GitHub_OSINT/${dork}_results.txt
  echo "${blue} [*] Results saved to ${dork}_results.txt ${reset}"
done

echo "${blue} [+] Running GitLeaks scan ${reset}"
for repo in $(ls ~/recon_king/$GH_USER/GitHub_OSINT); do
  gitleaks detect --source ~/recon_king/$GH_USER/GitHub_OSINT/$repo --report-path ~/recon_king/$GH_USER/GitHub_OSINT/${repo}_gitleaks_report.json
  echo "${blue} [*] GitLeaks report saved to ${repo}_gitleaks_report.json ${reset}"
done

echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
