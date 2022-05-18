
. $(dirname `readlink -f $0`)/common.sh

unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

if [ -d "$HOME/.oh-my-zsh" ]; then

    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi

    ZSH_THEME="powerlevel10k/powerlevel10k"
    export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
fi


