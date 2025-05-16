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
for i in ${ewmharr[@]}; do 
	ordinal=$(get_desktop $i)
	for index in "${!i3ewmh[@]}"; do	
		if [[ "${i3ewmh[$index]}" = $ordinal ]]; then
			echo $i	 ${i3arr[$index]}
		fi
	done
done
