
function SET_PROXY() {
    #export http_proxy=sock5://127.0.0.1:1086
    export http_proxy=http://127.0.0.1:1087
#    export http_proxy=http://192.168.124.20:1087
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
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

if [ -d "$HOME/.oh-my-zsh" ]; then

    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && p10k configure
    fi

    ZSH_THEME="powerlevel10k/powerlevel10k"
    export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
else
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


