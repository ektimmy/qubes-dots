#!/bin/bash
# I have not ran this script. It should work, but use at your own risk!

if (( $EUID != 0 )); then
  echo "Please run as root"
  exit 1
fi
# Todo:
# qvm-ls | grep fedora-[0-9] or debian-[0-9] -> set var os-release
# for now just assuming fedora-41

# Creating a sys-gui
if [[ qvm-ls | grep sys-gui = "" ]]; then
  qubesctl top.enable qvm.sys-gui
  qubesctl top.enable qvm.sys-gui pillar=True
  qubesctl --all state.highstate
  qubesctl top.disable qvm.sys-gui
  
  # Allowing sys-gui able to use sys-net and sys-usb (in theory)
  qubes prefs default_guivm sys-gui
  
  # Updating all qubes app menus in sys-gui
  qvm-run sys-gui xterm --hold --command "qvm-sync appmenus fedora-41-xfce"
  qvm-run sys-gui xterm --hold --command "qvm-sync appmenus default-dvm“
  
  # Hiding xfce session to make sys-gui only login option
  mv /usr/share/xsessions/xfce.desktop /usr/share/xsessions/xfce.desktop.hidden
  
  # Changing TTY settings to limit to 2
  echo NAutoVTs=2 | tee -a /etc/systemd/logind.conf
  echo ReserveVT=2 | tee -a /etc/systemd/logind.conf

  reboot now
else
  # Ran in tty2 after restart
  # Creating a fedora based themed template 
  qvm-clone fedora-41-xfce fedora-41-styled
  qvm-run fedora-41-styled xterm  --hold --command "sudo dnf install i3 urxvt rofi oxygen-mono-fonts picom qt5-qtstyleplugins"
  qvm-shutdown --wait fedora-41-styled

  # Setting up app vms to use new styled template
  qvm-prefs sys-gui template fedora-41-styled  
  qvm-prefs personal template fedora-41-styled
  qvm-prefs work template fedora-41-styled
  qvm-prefs untrusted template fedora-41-styled
  qvm-prefs vault template fedora-41-styled

  # Configuring styled template system files 
  qvm-run fedora-41-styled xterm  --hold --command "sudo echo QT_QPA_PLATFORMTHEME=gtk2 | tee -a /etc/environment"
  qvm-run fedora-41-styled xterm  --hold --command "sudo echo ForwardToSyslog=yes | tee -a /etc/systemd/journald.conf"
  
  reboot now
fi
