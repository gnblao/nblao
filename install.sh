#!/bin/bash


#install vim 8+ see vim_install.sh


ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/bashrc ~/.bashrc

cp -r dict ~/.vim/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
