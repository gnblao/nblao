#!/bin/bash


#install vim 8+ see vim_install.sh


cp -r vimrc ~/.vimrc
cp -r ./dict ~/.vim/
cp -r ./bashrc ~/.bashrc

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
