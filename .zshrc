export ZSH=/Users/mattpryor/.oh-my-zsh
plugins=(git history-substring-search zsh-syntax-highlighting tmuxinator brew)
ZSH_THEME="af-magic"

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=* r:|=* l:|=*' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=* r:|=* l:|=*'
zstyle :compinstall filename '/Users/mattpryor/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch notify correct histignoredups

#setopt globdots

# End of lines configured by zsh-newuser-install
#

alias dirs="dirs -v"
alias ls="ls -alG"

set -o vi

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/mattpryor/scripts:/Users/mattpryor/scripts:/Users/mattpryor/Applications/mongodb/bin:/Applications/Couchbase Server.app/Contents/Resources/couchbase-core/bin"
export EDITOR='vim'
export DISABLE_AUTO_TITLE=true

source ~/scripts/aliases
source ~/scripts/load_configs

muxstart () {
	tmuxprojs=$(mux l | grep -v "tmuxinator projects:")

	setopt shwordsplit
	for word in $tmuxprojs; do
		mux start $word & 
	done
	unsetopt shwordsplit
	wait;

	firstsession=$(tmux ls | head -1 | awk '{print $1}' | sed 's/://g')
	echo $firstsession

	tmux attach-session -t $firstsession
}


#muxstart() {
	#mux start configs & mux start mindmap & wait; tmux attach-session -t configs
#}
#
