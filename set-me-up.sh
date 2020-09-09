remove_if_exists() {
	if [ -d $1 ]; then 
		rm -rf $1;
	fi

	if [ -f $1 ]; then 
		rm $1;
	fi
}

# Install vim config
remove_if_exists ~/.vim
cp -r .vim ~/

# Install zshrc
remove_if_exists ~/.zshrc
cp .zshrc ~/

# Install powerlevel 10k config
remove_if_exists ~/.p10k.zsh
cp .p10k.zsh ~/

# Install gitconfig
remove_if_exists ~/.gitconfig
cp .gitconfig ~/

remove_if_exists ~/.config/terminator/config
if [ ! -d ~/.config/terminator ]; then
	mkdir -p ~/.config/terminator
fi
# Install terminator configs
cp terminator-config ~/.config/terminator/config

remove_if_exists ~/.config/Code/User/settings.json
if [ ! -d ~/.config/Code/User ]; then
	mkdir -p ~/.config/Code/User
fi
# Install vscode settings
cp vscode-settings.json ~/.config/Code/User/settings.json
