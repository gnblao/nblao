#!/bin/bash

set -x

cd ~/.vim/bundle  && git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe && git submodule update --init --recursive

mkdir ~/ycm_tmp
cd ~/ycm_tmp && wget http://releases.llvm.org/3.9.1/clang+llvm-3.9.1-aarch64-linux-gnu.tar.xz 
tar -xvf clang+llvm-3.9.1-aarch64-linux-gnu.tar.xz && mv clang+llvm-3.9.1-aarch64-linux-gnu llvm_root_dir

cd ~
mkdir ycm_build
cd ycm_build  && cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

cmake -G 'Unix Makefiles' -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir -DEXTERNAL_LIBCLANG_PATH=~/ycm_temp/llvm_root_dir/lib/ . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core



