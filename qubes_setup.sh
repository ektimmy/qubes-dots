#!/bin/bash
# I have not ran this script. It should work, but use at your own risk!

if (( $EUID != 0 )); then
  echo "Please run as root"
  exit 1
fi
# Todo:
# qvm-ls | grep fedora-[0-9] or debian-[0-9] -> set var os-release

# Installing packages to dom0
qubes-dom0-update i3 urxvt rofi oxygen-mono-fonts picom qt5-qtstyleplugins

# Creating a fedora based themed template 
qvm-clone fedora-41 fedora-41-styled
qvm-run fedora-41-styled xterm  --hold --command "sudo dnf install urxvt oxygen-mono-fonts"
qvm-shutdown --wait fedora-41-styled

# Setting up app vms to use new styled template
qvm-prefs personal template fedora-41-styled
qvm-prefs work template fedora-41-styled
qvm-prefs untrusted template fedora-41-styled
qvm-prefs vault template fedora-41-styled

# Importing user files from template
sh ./import_to_qubes.sh

# Configuring dom0 system files
echo QT_QPA_PLATFORMTHEME=gtk2 | tee -a /etc/environment
echo ForwardToSyslog=yes | tee -a /etc/systemd/journald.conf

reboot now
