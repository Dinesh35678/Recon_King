#!/bin/bash

function menu {
#colors
blue='\033[0;34m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
reset='\033[0m'
reset='\033[0m'
red=`tput setaf 1`
reset=`tput sgr0`
	clear
	echo -e "\t\t\t${red}
||=================================================================================================||
||	██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗    ██╗  ██╗██╗███╗   ██╗ ██████╗ 		   ||
||	██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║    ██║ ██╔╝██║████╗  ██║██╔════╝ 		   ||
||	██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║    █████╔╝ ██║██╔██╗ ██║██║  ███╗		   ||
||	██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║    ██╔═██╗ ██║██║╚██╗██║██║   ██║		   ||
||	██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║    ██║  ██╗██║██║ ╚████║╚██████╔╝		   ||
||	╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 		   ||
||=========================================== Recon_king- G_7 =====================================||   
${reset}"
echo -e " Developed By:"
echo -e " ${blue}Dinesh G${reset}"
# Welcome Note
echo -e "${yellow}============================================================================================================================================================${reset}"
echo -e "${blue}\nWelcome to Recon_King!${reset}"
echo -e "Your ultimate recon automation tool designed to streamline and enhance your reconnaissance process."
echo -e "Harness the power of advanced dorking and OSINT techniques to uncover hidden vulnerabilities and gain actionable insights efficiently."
echo -e "${yellow}============================================================================================================================================================${reset}\n"

# Guidelines
echo -e "${red}Guidelines:${reset}"
echo -e "      1. Ensure you have the necessary permissions to scan and gather information on the target domain."
echo -e "      2. Use this tool responsibly and ethically, adhering to all applicable laws and regulations."
echo -e "      3. Keep your system and the Recon_King tool updated to avoid any compatibility issues or bugs."
echo -e "      4. Familiarize yourself with the various scan options available to make the most out of this tool.\n"

# Disclaimer
echo -e "${red}Disclaimer:${reset}"
echo -e "This tool is intended for legal and ethical use only. Unauthorized use of Recon_King against systems without permission is illegal and punishable by law."
echo -e "The creators and contributors of Recon_King [Dinesh_G] is not responsible for any misuse or damage caused by this tool."
echo -e "Ensure that you have explicit permission from the system owner before using this tool on any target."

echo -e "${yellow}===========================================================================================================================================================${reset}"



	echo -e "\n\t${red}Single scan: \n${reset}"
	echo -e "\tA. Subdomain Enumeration"
	echo -e "\tB. whois Enumeration"
	echo -e "\tC. Github OSINT and Gitleaks scan"
	echo -e "\tD. Google Dorking"
	echo -e "\tE. SSl Scan"
	echo -e "\tF. Visual Recon"
	echo -e "\tG. Nuclei Vulnerability Scanning"
	echo -e "\tH. Scanning for S3 Open Buckets"
	echo -e "\tI. Scanning for vulneable Wordpress Plugins"
	echo -e "\tJ. Scanning for Open Ports"
	echo -e "\tK. Scanning for CORS Misconfiguration"
	echo -e "\tL. Scan for subdomain takeover \n"

	
	echo -e "\t${red}Multiple scan: \n${reset}"
	echo -e "\t1. Passive Scan ${blue}[Subdomain | Whois | Github | Google Dorking] ${reset}"
	echo -e "\t2. Active Scan ${blue}[SSL | Visual | Nuclei | S3 Bucket | WP scan | Open Ports | CORS | Subdomain Takeover] ${reset}"
	
	echo -e "\t0. Exit Menu\n"
	echo -en "\t${red}Select single or multiple scan: ${reset}"
	read -n 1 option
}

function subenum {
	clear
        bash src/subenum.sh
}

function whois {
	clear
	bash src/whois.sh
}

function github {
	clear
	bash src/github.sh
}

function googledork {
	clear
	bash src/googledork.sh
}

function sslscan {
	clear
	bash src/sslscan.sh
}

function visualrecon {
        clear
        bash src/visual_recon.sh 
}

function nuclei {
	clear
	bash src/nuclei.sh
}

function S3buckets {
        clear
        bash src/S3buckets.sh
}

function wpscan {
	clear
	bash src/wpscan.sh
}

function portscan {
	clear
	bash src/portscan.sh
}

function cors {
	clear
	bash src/corsscan.sh
}

function takeover_check {
	clear
	bash src/takeover.sh
}

function passivescan {
	clear
        bash src/passive_scan.sh
}

function activescan {
	clear
	bash src/active_scan.sh
}

while [ 1 ]
do
	menu
	case $option in
	0)
	break ;;
	A | a)
	subenum ;;
	
	B | b)
	whois ;;

	C | c)
	github ;;

	D | d)
	googledork ;;
	
	E | e)
	sslscan ;;
	
	F | f)
	visualrecon ;;

	G | g)
	nuclei ;;
	
	H | h)
	S3buckets ;;
	
	I | i)
	wpscan ;;
	
	J | j)
	portscan ;;
	
	K | k)
	cors ;;
	
	L | l)
	takeover_check ;;
	
	1)
	passivescan ;;

	2)
	activescan ;;
	
	*)
	clear
	echo "Wrong selection";;
	esac
	echo -en "\n\n\t\t\tHit any key to continue"
	read -n 1 line
done
clear
