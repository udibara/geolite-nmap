#!/bin/bash 

####################################
# Geolite Database Installer       #
# For Nmap                         #
# Coded by Mr.Doel                 #
# Contact me : doel@mc-crew.or.id  #
####################################

#   _____         .__                          _________        ___.                  _________                        
#  /     \ _____  |  | _____    ____    ____   \_   ___ \___.__.\_ |__   ___________  \_   ___ \_______   ______  _  __
# /  \ /  \\__  \ |  | \__  \  /    \  / ___\  /    \  \<   |  | | __ \_/ __ \_  __ \ /    \  \/\_  __ \_/ __ \ \/ \/ /
#/    Y    \/ __ \|  |__/ __ \|   |  \/ /_/  > \     \___\___  | | \_\ \  ___/|  | \/ \     \____|  | \/\  ___/\     / 
#\____|__  (____  /____(____  /___|  /\___  /   \______  / ____| |___  /\___  >__|     \______  /|__|    \___  >\/\_/  
#       

#importkl
lwh='\e[1;37m'
wh='\E[0;37m'
lrd='\e[1;31m'
rd='\E[0;31m'
cyn='\E[0;36m'
lcyn='\e[1;36m'
ylw='\E[0;33m'
lylw='\E[1;33m'
grn='\e[0;32m'
lgrn='\E[1;32m'
fin='\033[0m'

function chkroot {
echo && echo -e "Please wait . ."
echo && echo -e "${lwh}Checking Root user . . .${fin}";sleep 1
  if [[ $(id -u) = 0 ]]; then
  echo && echo -e ${grn}"Root user Ok. ."${fin};
  else
    echo && echo -e "${lrd}You must run this script as Root${fin}";sleep 1
    echo && echo -e "exiting . .";sleep 2
    exit
  fi
}

function chkapp {
if [ -x "/usr/share/nmap" ] && [ -x "/usr/bin/xsltproc" ] ; then
	echo && echo -e "${lwh}Checking Application . . .${fin} "
	sleep 1
	echo -e "${grn}OK${fin}"
	sleep 1
else
	xterm -e sudo apt-get install -y nmap 
	xterm -e sudo apt-get install -y xsltproc
	chkapp

fi
}

function chkwget {
    if [ -x "/usr/bin/wget" ]; then
		cmd=doel
	else
		echo -e ${lrd}"\nUnable to find download manager(wget) " ${fin};sleep 1;echo -e "Installing wget. . "; apt-get install wget;echo && echo -e ${grn}"Wget Ok. ."${fin};sleep 1
	fi
}

function chkinet {
    echo && echo -e "${lwh}Checking internet connection . . .${fin}";
    
    WGET="/usr/bin/wget"

$WGET -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
if [ ! -s /tmp/index.google ];then
    echo && echo -e "${rd}No internet connection! ${fin}"
    echo && echo -e "exiting . .";sleep 2
    exit
else
    echo && echo -e "${grn}Internet Connection Ok . . ${fin}";
    sleep 1
fi
}    

function head {
    clear
    echo -e " ${lrd}
               ------------------------------------
               || Database Geolocation For Nmap  ||
               ||      	                         ||
               ||                                ||
               ||       Malang Cyber Crew        ||
               ||                                ||
               ||       Coded by : Mr.Doel       ||
               ||       doel@mc-crew.or.id       ||
               ||                                ||
               ||      http://mc-crew.or.id      ||
               -----------------------------------${fin}"
}

function main {
cd /usr/share/nmap/nselib/data/
echo -e "${lylw}Please wait, Downloading database . . ${fin}"
xterm -e wget -c http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
if [ ! -f /usr/share/nmap/nselib/data/GeoLiteCiy.dat.gz ]; then
    echo && echo -e "${lrd}Download Failed! File Not Found! ${fin}"
    echo && echo -e "${lylw}Downloading again, please wait . .${fin}"
    xterm -e wget -c http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
fi
echo && echo -e "${lylw}Extracting Database . .  ${fin}"
xterm -e gunzip -v GeoLiteCity.dat.gz
if [ ! -f /usr/share/nmap/nselib/data/GeoLiteCity.dat ]; then
    echo && echo -e "${$lrd}Extracting Failed . .  ${fin}"
    echo && echo -e "${$lylw}Extracting Again . .  ${fin}"
    xterm -e gunzip -v GeoLiteCity.dat.gz
fi
echo && echo -e "${lgrn}Instalation Complete . .  ${fin}"
}

chkroot
chkwget
chkinet
chkapp
head
main
