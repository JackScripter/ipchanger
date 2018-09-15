#!/bin/bash
# Installer v1.0
######################################################################################################
# Default installation path:
DEFAULT_INSTALL='/usr/bin'
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
        else
                cp -v "debian/ipchanger" "$editedPath"
                chmod -v 755 "$editedPath/ipchanger"
        fi
} # Debian installation
function RedHat() {
        read -p "Installation path [$DEFAULT_INSTALL]: " editedPath
        if [[ "$editedPath" == '' ]]; then
                cp -v "redhat/ipchanger" "$DEFAULT_INSTALL"
                chmod -v 755 "$DEFAULT_INSTALL/ipchanger"
        else
                cp -v "redhat/ipchanger" "$editedPath"
                chmod -v 755 "$editedPath/ipchanger"
        fi
} # RedHat installation
possible_OS=`cat /etc/os-release | grep --color '^ID'`
IFS='=' inarr=(${possible_OS})
case "${inarr[1]}" in
        *'debian'*) Debian;;
        *'centos'*) RedHat;;
        *'fedora'*) RedHat;;
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
