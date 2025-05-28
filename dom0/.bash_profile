# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs 
#
# Setting Aliases

# Keybinds
bind '"\C-l": "vlock\n"'

# Theming
sh $HOME/.startup/set_colors.sh
setfont $HOME/.startup/OxygenMono-Regular.psf

# Starting Applications

