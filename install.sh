#!/bin/bash

#install vim 8+ see vim_install.sh
set +x

ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/tmux.conf ~/.tmux.conf
ln -s `pwd`/global.rc ~/.global.rc

#cp -r dict ~/.vim/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ "/bin/bash" == "$SHELL" ]; then
    shrc_path="~/.bashrc"
    $my_bashrc="my_bashrc"
    
    flg=`grep "$my_bashrc" $(shrc_path) | wc -l`
    if [ $flg -eq 0 ]; then
        echo '. '"`pwd`/$my_bashrc" >> $(shrc_path)
    else
        sed -i '' "/.*\/$my_bashrc/d" $(shrc_path) &&  echo '. '"`pwd`/$my_bashrc" >> $(shrc_path)
    fi
fi

if [ "/bin/zsh" == "$SHELL" ]; then
    shrc_path="~/.zshrc"
    $my_zshrc="my_zshrc"

    flg=`grep "$my_zshrc" $(shrc_path) | wc -l`
    if [ $flg -eq 0 ]; then
        echo '. '"`pwd`/$my_zshrc" >> $(shrc_path)
    else
        sed -i '' "/.*\/$my_zshrc/d" $(shrc_path) &&  echo '. '"`pwd`/$my_zshrc" >> $(shrc_path)
    fi
fi
