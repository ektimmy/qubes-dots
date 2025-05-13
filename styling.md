### This is a document to track all styling changes and information to track the updating process for all applications to be distributed to all qubes


## Pushing Updates
---
Dom0 has the WM dots. All fedora-styled based qubes will have a terminal and gtk3 theming. The dots are backed up to a central location on the Dom0. This backup then can have its selected parts be pushed to the individual qubes.\

## Installed Packages
---
Dom0 - i3, urxvt, rofi, oxygen-mono-fonts, picom\
fedora-styled - urxvt, oxygen-mono-fonts\

## Styling
---
Colorscheme - Everblush,\
System font - Noto Sans,\
Mono font - Oxygen Mono,\
GTK3 - \
 
## Rofi Items
---
Dbus is set up to be the default launcher with $mod+d. However where application shortcuts leave ambiguity for which host is to be used (I'm looking at you qubes-i3-sensible-terminal), there is a rofi script available to select the host. Each application is set to five default qubes. The following have been made:\
- Terminal (Rxvt-Unicode)
- Navigator (firefox)
- File Manager (Thunar)  
