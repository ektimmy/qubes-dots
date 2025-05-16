### This is a document to track all styling changes and information to track the updating process for all applications to be distributed to all qubes
---
## Pushing Updates
Dom0 has the WM dots. All fedora-styled based qubes will have a terminal and gtk3 theming. The dots are backed up to a central location on the Dom0. This backup then can have its selected parts be pushed to the individual qubes.

## Installed Packages
Dom0 - i3, urxvt, rofi, oxygen-mono-fonts, picom, qt5-qtstyleplugins\
fedora-styled - urxvt, oxygen-mono-fonts

## Styling
Colorscheme - Everblush,\
System font - Noto Sans,\
Mono font - Oxygen Mono,\
GTK3 - \ 
- Note: To sync QT based qubes apps to GTK themeing use "echo QT_QPA_PLATFORMTHEME=gtk2 | sudo tee -a /etc/environment"  
Icons - \
Bar - \
Compositor - picom 
GTK Manager - xfsettingsd
 
## Rofi Items
Dbus is set up to be the default launcher with $mod+d. However where application shortcuts leave ambiguity for which host is to be used (I'm looking at you qubes-i3-sensible-terminal), there is a rofi script available to select the host. Each application is set to five default qubes. The following have been made:\
- Terminal (Rxvt-Unicode)
- Navigator (firefox)
- File Manager (Thunar) 

Rofi will also be used for other vital functionality such as\
- Change the i3 workspace or cycle through all windows using i3-msg (In Devel)
- Connect to Wifi (To-do)
- Assign USB devices to Qubes (To-do)
- Lock, Logout, Reboot, and Shutdown (To-do)

## Toolbar & Widgets
xfce-panel for toolbar maybe!
