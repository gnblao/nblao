# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#yum install ncurses-term
if [ "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi

alias tmux='tmux -2'

