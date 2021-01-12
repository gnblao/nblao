#!/bin/bash

yum install -y ncurses-devel libtool-ltdl-devel cmake

set -x
mkdir -p  tmp && cd tmp

#git clone https://github.com/nmathewson/Libevent.git
#cd Libevent && pwd && ./autogen.sh  && ./configure --prefix=$HOME/env && make install && cd ..
#if [ $? -ne 0  ]; then
#    echo " Install Libevent Failed"
#    exit -1
#fi


git clone https://github.com/tmux/tmux.git
cd tmux && ./autogen.sh && ./configure --prefix=$HOME/env && make install && cd ..
if [ $? -ne 0  ]; then
    echo " Install tmux Failed"
    exit -1
fi

sudo yum install -y ruby ruby-devel lua lua-devel luajit \
    luajit-devel ctags git python python-devel \
    python36 python36-devel tcl-devel \
    perl perl-devel perl-ExtUtils-ParseXS \
    perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
    perl-ExtUtils-Embed

git clone https://github.com/vim/vim.git
cd vim  && ./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-python3interp=yes \
    --with-python3-command=~/work/anaconda2/envs/py36env/bin/python3 \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk2 --enable-cscope --prefix=$HOME/env && make install && cd ..

#    --enable-pythoninterp=yes \
#    --with-python-config-dir=/usr/lib/python2.7/config \

if [ $? -ne 0  ]; then
    echo " Install vim Failed"
    exit -1
fi

cd ..

