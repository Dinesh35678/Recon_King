#!/bin/bash

# colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

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
