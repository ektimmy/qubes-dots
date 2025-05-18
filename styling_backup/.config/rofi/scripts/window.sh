#!/bin/bash
#
get_ids() {
	local ids=$(xprop -root _NET_CLIENT_LIST)
	ids=$(cut -d# -f 2 <<< $ids)		
	echo ${ids}	
}
get_desktop() {
	local dt=$(xprop -id $1 | grep '_NET_WM_DESKTOP')
	dt=$(cut -d= -f 2 <<< $dt)
	echo ${dt# *}	
}
get_name() {
	if [[ $(xprop -id $1 | grep 'WM_CLASS' |  grep ':') == *:* ]]; then
		local name=$(xprop -id $1 | grep WM_CLASS)
		name=$(cut -d\" -f 4 <<< $name)	
		vm=$(cut -d: -f 1 <<< $name)
		name=$(cut -d: -f 2 <<< $name)	
		case "$name" in 
			"org.mozilla.firefox") 	name='Firefox' ;;
			*) 			name=$name;;	
		esac	
		echo "$2:_[$vm]_$name"
	else
		local name=$(xprop -id $1 | grep WM_CLASS)
		name=$(cut -d\" -f 4 <<< $name)	
		echo "$2:_[dom0]_$name"
	fi
}
#i3arr := list all workspaces listed by i3
#ewmharr := list all ewmh window ids for all windows
#i3ewmh := ordered non repeating list of ordinals used

wkspaces=$(echo $(i3-msg -t get_workspaces | grep -o '"num":[^;]' | grep -o '[0-9]'))
IFS=" " read -ra i3arr <<< "$wkspaces"
IFS=", " read -ra ewmharr <<< "$(get_ids)" 
declare -a i3ewmh=()
for i in ${ewmharr[@]}; do		
	ordinal=$(get_desktop $i)	
	if [[ ! " ${i3ewmh[@]} " =~ [[:space:]]$ordinal[[:space:]] ]]; then
		i3ewmh+=("$ordinal")
	fi
done	
i3ewmh=($(printf "%s\n" "${i3ewmh[@]}" | sort ))

#Loop through to show all ids and i3 windows they are on
#for i in ${ewmharr[@]}; do 
#	ordinal=$(get_desktop $i)
#	for index in "${!i3ewmh[@]}"; do	
#		if [[ "${i3ewmh[$index]}" = $ordinal ]]; then
#			echo $i	 ${i3arr[$index]}
#		fi
#	done
#done

count=0
for _ in ${ewmharr[@]}; do
	count=$((count+=1))
done
if [[ $count > 0 ]]; then
	print='%s'
	i=0
	while [[ $i <  $((count-1)) ]]; do
		print="$print;%s"
	i=$((i+=1))	
	done
	print="$print\n"

#	namearr := list of all workspaces by "[VM] Name"
	declare -a namearr=()		
	num=0	
	for i in ${ewmharr[@]}; do
			
		namearr+=($(get_name $i $num))
	num=$((num+=1))
	done	
#	start the rofi window 	
	chosen=$(printf $print ${namearr[@]} \
		| sed 's/_/ /g'	\
		| rofi -theme '../themes/window.rasi' \
		-dmenu \
 		-sep ';' \
		-selected-row 0 )		
	chosen=$(cut -d: -f 1 <<< $chosen)			
	coproc ( i3-msg [id=${ewmharr[$chosen]}] focus > /dev/null 2>&1 )	
fi	
