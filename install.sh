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
    ln -s `pwd`/bashrc ~/.bashrc
fi

if [ "/bin/zsh" == "$SHELL" ]; then
    ln -s `pwd`/zshrc ~/.zshrc
    
    flg=`grep 'my_zshrc.sh' $(pwd)/zshrc | wc -l`
    if [ $flg -eq 0 ]; then
        echo '. '"`pwd`/my_zshrc.sh" >> $(pwd)/zshrc
    else
        sed -i '' '/.*\/my_zshrc.sh/d' $(pwd)/zshrc &&  echo '. '"`pwd`/my_zshrc.sh" >> $(pwd)/zshrc
    fi
fi
