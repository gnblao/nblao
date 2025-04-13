
function SET_PROXY() {
    #export http_proxy=sock5://127.0.0.1:1086
    export http_proxy=http://127.0.0.1:1087
#    export http_proxy=http://192.168.124.20:1087
    export https_proxy=$http_proxy
}

function CLAER_PROXY() {
    unset http_proxy https_proxy
}

SET_PROXY

#yum install ncurses-term
if [ "$TERM" = "xterm" ]; then
	export TERM=xterm-256color
fi


alias tmux='tmux -2'

export GOPROXY=https://goproxy.cn
export PATH=$PATH:${GOPATH//://bin:}/bin
export PATH="/opt/homebrew/bin:$PATH"

unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1


