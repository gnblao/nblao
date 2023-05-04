#!/bin/bash

#install vim 8+ see vim_install.sh
set +x

ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/tmux.conf ~/.tmux.conf
ln -s `pwd`/global.rc ~/.global.rc

#cp -r dict ~/.vim/
# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install yarn for coc.nvim nodejs
sudo yum -y install nodejs-devel && curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

if read -p "tmux prefix is C-a? [y/n]:" read_flg
then
    if [ "$read_flg" == "y" ]; then
		sed -i -e '1s/.*\(unbind C-b\)/\1/g' ./tmux.conf
		sed -i -e '2s/.*\(set -g prefix C-a\)/\1/g' ./tmux.conf
	else
		sed -i -e '1s/.*\(unbind C-b\)/#\1/g' ./tmux.conf
		sed -i -e '2s/.*\(set -g prefix C-a\)/#\1/g' ./tmux.conf
	fi
else
    echo "\n抱歉，你输入超时了。"
fi


# shell
if [ "/bin/bash" == "$SHELL" ]; then
    shrc_path="$HOME/.bashrc"
    my_bashrc="my_bashrc"
    
    #flg=`grep "$my_bashrc" ~/.bashrc | wc -l`
    flg=`grep "$my_bashrc" $shrc_path | wc -l`
    if [ $flg -eq 0 ]; then
        echo '. '"`pwd`/$my_bashrc" >> $shrc_path
    else
        sed -i -e "/.*\/$my_bashrc/d" $shrc_path &&  echo '. '"`pwd`/$my_bashrc" >> $shrc_path
    fi
    #sudo dnf install powerline-fonts
fi

if [ "/bin/zsh" == "$SHELL" ]; then
    shrc_path="$HOME/.zshrc"
    my_zshrc="my_zshrc"

    flg=`grep "$my_zshrc" $shrc_path | wc -l`
    if [ $flg -eq 0 ]; then
        echo '. '"`pwd`/$my_zshrc" >> $shrc_path
    else
        sed -i -e "/.*\/$my_zshrc/d" $shrc_path &&  echo '. '"`pwd`/$my_zshrc" >> $shrc_path
    fi
    
    wget https://raw.githubusercontent.com/powerline/fonts/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf
    wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Monokai%20Remastered.itermcolors
    wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/GitHub%20Dark.itermcolors
fi
