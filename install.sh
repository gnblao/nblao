#!/bin/bash


#install vim 8+
# yum install http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm
#rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
#yum -y remove vim-minimal vim-common vim-enhanced
#yum -y --enablerepo=gf-plus install vim-enhanced

cp -r vimrc ~/.vimrc
cp -r ./dict ~/.vim/
cp -r ./bashrc ~/.bashrc

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
