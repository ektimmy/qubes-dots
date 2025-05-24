#!/bin/bash

BACKUPDIR="/Document/qubes-dots"

BACKUPDIR=$HOME$BACKUPDIR"/xfce_template"
declare -a FILES=(
	".Xresources"
)

declare -a QUBES=(
	"personal"
	"work"
	"vault"
	"untrusted"
)

for qube in "${QUBES[@]}"; do
	for file in "${FILES[@]}"; do 
		cat "$BACKUPDIR""/""$file" | qvm-run --pass-io "$qube" 'cat > /home/user/'"$file"
	done
done
