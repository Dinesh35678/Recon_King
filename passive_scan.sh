#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM


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
#whois
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
#github

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
read -p "Enter target domain (e.g., example.com): " DOMAIN

if [ -d ~/recon_king/ ]; then
  echo " "
else
  mkdir ~/recon_king
fi

if [ -d ~/recon_king/$DOMAIN/Google_Dorking ]; then
  echo " "
else
  mkdir -p ~/recon_king/$DOMAIN/Google_Dorking
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
echo "${blue} [+] Started Google Dorking ${reset}"
echo " "

# Google dorks categories and queries
declare -A dorks=(
  ["Directory listing vulnerabilities"]="intitle:index.of"
  ["Exposed Configuration files"]="ext:cfg | ext:conf | ext:cnf | ext:reg | ext:inf | ext:rdp | ext:ora | ext:ini"
  ["Exposed Database files"]="ext:sql | ext:dbf | ext:mdb"
  ["Find WordPress"]="inurl:wp-content | inurl:wp-includes"
  ["Exposed log files"]="ext:log"
  ["Backup and old files"]="ext:bkf | ext:bkp | ext:bak | ext:old | ext:backup"
  ["Login pages"]="inurl:login"
  ["SQL errors"]="intext:'sql syntax near' | intext:'syntax error has occurred' | intext:'incorrect syntax near'"
  ["Publicly exposed documents"]="ext:doc | ext:docx | ext:odt | ext:pdf | ext:rtf | ext:sxw | ext:psw | ext:ppt | ext:pptx | ext:pps | ext:csv"
  ["phpinfo()"]="ext:php intitle:phpinfo 'published by the PHP Group'"
  ["Finding Backdoors"]="inurl:c99.php | inurl:cmd.php | inurl:sh3ll.php | inurl:st3alth.php"
  ["Install / Setup files"]="intitle:setup | intitle:install"
  ["Open Redirects"]="inurl:redirect | inurl:url | inurl:next | inurl:src | inurl:r | inurl:u | inurl:q | inurl:target | inurl:out"
  ["Apache STRUTS RCE"]="intitle:index.of struts | inurl:struts"
  ["Find Pastebin entries"]="site:pastebin.com"
  ["Employees on LINKEDIN"]="site:linkedin.com employees"
  [".htaccess sensitive files"]="ext:htaccess"
  ["Search in OpenBugBounty"]="site:openbugbounty.org"
  ["Search in Reddit"]="site:reddit.com"
  ["Test CrossDomain"]="ext:xml intitle:crossdomain.xml"
  ["Check in ThreatCrowd"]="site:threatcrowd.org"
  ["Find .SWF file (Google)"]="ext:swf"
  ["Find .SWF file (Yandex)"]="site:*.yandex.com ext:swf"
  ["Search SWF in WayBack Machine"]="site:web.archive.org ext:swf"
  ["Search in WayBack Machine [List/All]"]="site:web.archive.org"
  ["Search in SHODAN"]="site:shodan.io"
)

echo "${blue} [+] Generating Google Dork URLs ${reset}"
for category in "${!dorks[@]}"; do
  dork_query="${dorks[$category]}"
  search_url="https://www.google.com/search?q=site:$DOMAIN+${dork_query}"
  echo "${yellow} [+] Category: $category ${reset}"
  echo "${green} $search_url ${reset}"
  echo "$search_url" >> ~/recon_king/$DOMAIN/Google_Dorking/dorks.txt
done

echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Successfully saved the dorking URLs ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
