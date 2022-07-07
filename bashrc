# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


function SET_PROXY() {
    #export http_proxy=sock5://192.168.124.9:1080
    export http_proxy=http://192.168.124.9:1081
    export https_proxy=$http_proxy
}

function CLAER_PROXY() {
    unset http_proxy https_proxy
}


#yum install ncurses-term
if [ "$TERM" = "xterm" ]; then
	export TERM=xterm-256color
fi

alias tmux='tmux -2'


export GO111MODULE=on
export GOPROXY=https://goproxy.cn
export PATH=$PATH:${GOPATH//://bin:}/bin
