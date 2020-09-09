remove_if_exists() {
	if [ -d $1 ]; then 
		rm -rf $1;
	fi

	if [ -f $1 ]; then 
		rm $1;
	fi
}

remove_if_exists ~/.vim
cp -r .vim ~/

remove_if_exists ~/.zshrc
cp .zshrc ~/

remove_if_exists ~/.config/terminator/config
if [ ! -d ~/.config/terminator ]; then
	mkdir -p ~/.config/terminator
fi
cp terminator-config ~/.config/terminator/config

remove_if_exists ~/.config/Code/User/settings.json
if [ ! -d ~/.config/Code/User ]; then
	mkdir -p ~/.config/Code/User
fi
cp vscode-settings.json ~/.config/Code/User/settings.json
