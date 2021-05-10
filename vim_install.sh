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

#install llvm clangd (https://llvm.org/docs/GettingStarted.html#checkout)
#sorece https://mirrors.tuna.tsinghua.edu.cn/help/llvm-project.git/
#tar -xvf llvm-project-11.0.0.tar.xz
#cd llvm-project-11.0.0
#mkdir build
#cd build
#cmake3 -DLLVM_ENABLE_PROJECTS=clang\;clang-tools-extra  -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=~/dev_env ../llvm/ -DCMAKE_BUILD_TYPE=Release
#make -j64
 

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
cd vim  && ./configure --prefix=/home/liwanchuan/dev_env --disable-selinux \
    --enable-luainterp=yes \
    -enable-perlinterp=yes \
    --enable-python3interp=yes \
    --enable-cscope --enable-multibyte --enable-fontset && cd ..

if [ $? -ne 0  ]; then
    echo " Install vim Failed"
    exit -1
fi

cd ..

