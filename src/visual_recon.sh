#!/bin/bash

# colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
reset=$(tput sgr0)

# Prompt for domain name
read -p "Enter domain name: " DOM

# Create necessary directories
mkdir -p ~/recon_king/$DOM/Visual_Recon

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

echo "${blue} [+] Starting Visual Recon ${reset}"
echo " "

# Ensure Go is installed
if ! command -v go &> /dev/null; then
    echo "${blue} [+] Installing Go${reset}"
    curl -OL https://golang.org/dl/go1.19.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xvf go1.19.5.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
fi

# Set GOPATH and update PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "

# Install and run Aquatone
if ! command -v aquatone &> /dev/null; then
    echo "${blue} [+] Installing Aquatone ${reset}"
    
    # Manually install Aquatone with a fix
    if [ -d $GOPATH/src/github.com/michenriksen/aquatone ]; then
        rm -rf $GOPATH/src/github.com/michenriksen/aquatone
    fi
    git clone https://github.com/michenriksen/aquatone.git $GOPATH/src/github.com/michenriksen/aquatone
    cd $GOPATH/src/github.com/michenriksen/aquatone
    git checkout v1.7.0
    
    # Apply fix to the regex.go file
    sed -i 's/xurls.Relaxed()/xurls.Relaxed/g' parsers/regex.go

    # Initialize Go module and tidy up dependencies
    go mod init github.com/michenriksen/aquatone
    go mod tidy

    go install
    
    export PATH=$PATH:$HOME/go/bin
fi

if command -v aquatone &> /dev/null; then
    echo "${magenta} [+] Running Aquatone for screenshotting alive subdomains${reset}"
    cat ~/recon_king/$DOM/Subdomains/unique.txt | aquatone -http-timeout 10000 -scan-timeout 300 -ports xlarge -out ~/recon_king/$DOM/Visual_Recon
else
    echo "${red} [-] Aquatone installation failed${reset}"
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using Recon_king By: G_7 ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
