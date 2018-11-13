#!/bin/bash
# Installer v1.1
######################################################################################################
# Default installation path:
DEFAULT_INSTALL='/usr/bin'
MAN_PATH='/usr/share/man/man1'
######################################################################################################
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
fi # Check if the script is run as root
function Debian() {
        read -p "Installation path [$DEFAULT_INSTALL]: " editedPath
        if [[ "$editedPath" == '' ]]; then
                cp -v "debian/ipchanger" "$DEFAULT_INSTALL"
                chmod -v 755 "$DEFAULT_INSTALL/ipchanger"
                cp -v ipchanger.1 $MAN_PATH
        else
                cp -v "debian/ipchanger" "$editedPath"
                chmod -v 755 "$editedPath/ipchanger"
        fi
        exit 1
} # Debian installation
function RedHat() {
        read -p "Installation path [$DEFAULT_INSTALL]: " editedPath
        if [[ "$editedPath" == '' ]]; then
                cp -v "redhat/ipchanger" "$DEFAULT_INSTALL"
                chmod -v 755 "$DEFAULT_INSTALL/ipchanger"
                cp -v ipchanger.1 $MAN_PATH
        else
                cp -v "redhat/ipchanger" "$editedPath"
                chmod -v 755 "$editedPath/ipchanger"
        fi
        exit 1
} # RedHat installation
possible_OS=`cat /etc/os-release | grep '^ID'`
if [[ $possible_OS == '' || "$possible_OS" != *'debian'* || "$possible_OS" != *'rhel'* ]]; then possible_OS=`cat /etc/os-release | grep '^ID_LIKE'`; fi
IFS='=' inarr=(${possible_OS})
case "${inarr[1]}" in
        *'debian'*) Debian;;
        *'rhel'*) RedHat;;
        *)
                echo "CANNOT FIND OS OR IT IS NOT SUPPORTED. OS found: ${inarr[1]}"
                read -p 'Manual installation mode ? [y/n] ' manual
                if [[ "$manual" == "y" ]]; then
                        read -p 'Based distro [debian/redhat]: ' distro
                        case "$distro" in
                                "debian") Debian;;
                                "redhat") RedHat;;
                                *) echo -e "Unable to find \e[96m$distro\e[0m"; exit 0;;
                        esac
                else
                        echo "Read the README.md file to report bug"
                        exit 0
                fi
esac # Determine OS
echo -e "\e[31mUnknown error\e[0m"
exit 0
