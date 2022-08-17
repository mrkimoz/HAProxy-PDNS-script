#!/bin/env bash
######  NOTES  #######################################################
# Created By : Eng. Mohamed Kamal                                    #
# Phone : +201062008120                                              #
# Email : Mr.peacock2@gmail.com                                      #
# 10/Mar/2022 :  Original code created be the developer              #
#                                                                    #
# WARNING: For use on RHEL/CentOS 7.x and up only.                   #
#	-Use at your own risk!                                           #
#	-Use only for new installations of Guacamole!                    #
# 	-Read all documentation (wiki) prior to using this script!       #
#	-Test prior to deploying on a production system!                 #
#                                                                    #
######  PRE-RUN CHECKS  ##############################################

######  PRE-RUN CHECKS  ##############################################
if ! [ $(id -u) = 0 ]; then echo "This script must be run as sudo or root, try again..."; exit 1; fi
if ! [ $(getenforce) = "Enforcing" ]; then echo "This script requires SELinux to be active and in \"Enforcing mode\""; exit 1; fi
if ! [ $(uname -m) = "x86_64" ]; then echo "This script will only run on 64 bit versions of RHEL/CentOS"; exit 1; fi
# Check that firewalld is installed
if ! rpm -q --quiet "firewalld"; then echo "This script requires firewalld to be installed on the system"; exit 1; fi

# Allow trap to work in functions
set -E

######  UNIVERSAL VARIABLES  #########################################
# Formats
Black=`tput setaf 0`	#${Black}
Red=`tput setaf 1`	#${Red}
Green=`tput setaf 2`	#${Green}
Yellow=`tput setaf 3`	#${Yellow}
Blue=`tput setaf 4`	#${Blue}
Magenta=`tput setaf 5`	#${Magenta}
Cyan=`tput setaf 6`	#${Cyan}
White=`tput setaf 7`	#${White}
Bold=`tput bold`	#${Bold}
UndrLn=`tput sgr 0 1`	#${UndrLn}
Rev=`tput smso`		#${Rev}
Reset=`tput sgr0`	#${Reset}
######  END UNIVERSAL VARIABLES  #####################################

# Determine if OS is RHEL, CentOS or something else
if grep -q "CentOS" /etc/redhat-release; then
	OS_NAME="CentOS"
elif grep -q "Red Hat Enterprise" /etc/redhat-release; then
	OS_NAME="RHEL"
else
	echo "Unable to verify OS from /etc/redhat-release as CentOS or RHEL, this script is intended only for those distro's, exiting."
	exit 1
fi


