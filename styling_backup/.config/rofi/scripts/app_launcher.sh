#!/bin/bash
#
# Qubes list
firstQubeDisplay='Dom0'

secondQube='personal'; secondQubeDisplay='Personal'

thirdQube='work'; thirdQubeDisplay='Work'

forthQube='untrusted'; forthQubeDisplay='Untrusted'

fifthQube='vault'; fifthQubeDisplay='Vault'



# This is used to launch terminals from i3 with the mod+Enter keys.
# Below is ripped from qubes-i3-sensible-terminal 
get_id() {
	local id=$(xprop -root _NET_ACTIVE_WINDOW)
	echo ${id##* }
}

get_vm() {
	local id=$(get_id)
	local vm=$(xprop -id $id | grep '_QUBES_VMNAME(STRING)')
	local vm=${vm#*\"}
	echo ${vm%\"*}
}
case "$1" in 
	"terminal")	config='terminals.rasi'; app='rxvt-unicode'; dom0_app='urxvt';;
	"browser")	config='firefox.rasi'; app='org.mozilla.firefox';dom0_app='firefox';;
	*)		echo "The following options are available: terminal or browser"; return 127;;
esac

activeQube=$(get_vm)
case "$activeQube" in 
	"$secondQube")	selection='1' ;;
	"$thirdQube")	selection='2' ;;
	"$forthQube")	selection='3' ;;
	"$fifthQube")	selection='4' ;;
	*)		selection='0' ;;
esac

chosen=$(printf '%s;%s;%s;%s;%s\n' "$firstQubeDisplay" "$secondQubeDisplay" "$thirdQubeDisplay" "$forthQubeDisplay" "$fifthQubeDisplay" \
	| rofi -theme '../themes/'"$config" \
	-dmenu \
	-sep ';' \
	-selected-row "$selection" )

case "$chosen" in
	"$firstQubeDisplay") 	action="$dom0_app";;
	"$secondQubeDisplay") 	action="qvm-run -q -a --service -- "$secondQube" qubes.StartApp+""$app" ;;
	"$thirdQubeDisplay")	action="qvm-run -q -a --service -- "$thirdQube"  qubes.StartApp+""$app" ;;
	"$forthQubeDisplay")	action="qvm-run -q -a --service -- "$forthQube"  qubes.StartApp+""$app" ;;
	"$fifthQubeDisplay")	action="qvm-run -q -a --service -- "$fifthQube"  qubes.StartApp+""$app" ;;
	*)			exit 1 ;;
esac

coproc ( ${action} > /dev/null 2>&1 )
