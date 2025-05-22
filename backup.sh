#!/bin/bash
BACKUPDIR="/Desktop"

BACKUPDIR=$HOME$BACKUPDIR"/styling_backup"
declare -a FILES=(
	$HOME"/.Xresources"
	$HOME"/.config/i3/."
	$HOME"/.wallpaper_backup.png"
	$HOME"/.config/rofi/."
	$HOME"/.config/picom.conf"
#	$HOME"/.local/share/themes/."
#	$HOME"/.local/share/icons/."
	$HOME"/.gtkrc-2.0"
	$HOME"/.config/gtk-3.0/settings.ini"
)
for i in "${FILES[@]}"; do
		OUTPUT=$(echo "$i" | sed  "s|$HOME|$BACKUPDIR|g" )
		cp -r "$i" "$OUTPUT"
done
echo "Backup complete!"
