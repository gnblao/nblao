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

#export http_proxy=sock5://127.0.0.1:1086
#export http_proxy=http://127.0.0.1:1086
#export https_proxy=$http_proxy

export GO111MODULE=on
export GOPROXY=https://goproxy.cn
export PATH=$PATH:${GOPATH//://bin:}/bin
