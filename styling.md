### This is a document to track all styling changes and the updating process for all qubes
---
## Pushing Updates
Dom0 has the WM dots. All fedora-styled based qubes will have a terminal and gtk3 theming. The dots are backed up to a central location on the Dom0. This backup then can have its selected parts be pushed to the individual qubes.

## Installed Packages
Dom0 - \
fedora-styled - i3, urxvt, rofi, oxygen-mono-fonts, picom, qt5-qtstyleplugins

## Styling
Colorscheme - Everblush,\
System font - Noto Sans,\
Mono font - Oxygen Mono,\
Console font - \
GTK - \
Icons - \
Bar - xfce4-panel\
Compositor - picom
 
## Rofi Items
Dbus is set up to be the default launcher with $mod+d. However where application shortcuts leave ambiguity for which host is to be used (I'm looking at you qubes-i3-sensible-terminal), there is a rofi script available to select the host. Each application is set to five qubes (disposable, work, personal, vault, and sys-gui). The following have been made:\
- Terminal (Rxvt-Unicode)
- Navigator (firefox)
- File Manager (Thunar) 

Rofi will also be used for other vital functionality such as\
- Change the i3 workspace or cycle through all windows using i3-msg (In Devel)
- Lock, Logout, Reboot, and Shutdown (To-do)

## Toolbar & Widgets
Todo
