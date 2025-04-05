#!/bin/bash

BACKUPDIR=$HOME"/Desktop/styling_backup"

declare -a FILES=(
	$HOME"/.Xresources"
	$HOME"/.config/i3/config"
	$HOME"/.config/i3/assignments.conf"
	$HOME"/.wallpaper_backup.png"
	$HOME"/.config/rofi/scripts/app_launcher.sh"
	$HOME"/.config/rofi/themes/terminals.rasi"
	$HOME"/.config/rofi/themes/firefox.rasi"
	$HOME"/.config/rofi/themes/shared/style.rasi"

)
COUNTER=0
for i in "${FILES[@]}"; do
	if test -f "$i"; then
		OUTPUT=$(echo "$i" | sed  "s|$HOME|$BACKUPDIR|g" )
		cp "$i" "$OUTPUT"
	else 
		echo "file "$i" does not exist"
		COUNTER=$(($COUNTER + 1))
	fi
done
echo "Backup complete! "$COUNTER" files failed."
