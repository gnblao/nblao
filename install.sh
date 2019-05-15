#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle

cp -r vimrc ~/.vimrc
cp -r ./dict ~/.vim/
cp -r ./bashrc ~/.bashrc

#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#
#cp -r tmux.conf ~/.tmux.conf
