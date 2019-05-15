" 1. put this file in location ~/.vimrc
" 2. install cmake and gcc
" 3. custom plugin bundle groups
"   c/cpp require install cscope and clang-format
"   java/c/cpp require install 'gnu global'
"   java require install JDK8
"   python require install flake8, pylintl, yapfl and autopep8(sudo -H pip install flake8 pylint yapf autopep8)
if !exists('g:bundle_groups')
    " let g:bundle_groups=['base', 'python', 'c', 'cpp', 'golang', 'html', 'javascript', 'markdown', 'java', 'json', 'shell', 'protobuf', 'thrift']
    let g:bundle_groups=['base', 'python', 'c', 'cpp', 'markdown', 'json', 'shell', 'protobuf', 'thrift']
endif

" 4. is enable builty plugin, this require set terminal font to DroidSansMono Nerd\ Font\ 11
" the font will auto install when vim first running
let s:builty_vim = 1
" 5. is enable YouCompleteMe, this need libclang7 above or GLIBC_2.17 above
let s:enable_ycm = 1
" 6. run vim, wait for plugins auto install
" 7. well done!

let s:cpp_clang_highlight = 0
" check is enable system clipboard
if has('clipboard') && !empty($DISPLAY)
    let s:enable_system_clipboard = 1
else
    let s:enable_system_clipboard = 0
endif

" check os
if !exists("s:os")
    if has("win64") || has("win32") || has("win16")
        let s:os = "Windows"
    else
        let s:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" auto install plugin manager
if empty(glob('~/.vim/bundle/vundle/autoload/vundle.vim'))
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    "call InstallAirLineFont()
endif

set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
call vundle#begin()
if count(g:bundle_groups, 'base')
    Bundle 'gmarik/vundle'
    Bundle 'godlygeek/tabular'          
    Bundle 'majutsushi/tagbar'
    Bundle 'scrooloose/nerdtree'                 
    Bundle 'Auto-Pairs'
    Bundle 'tomasr/molokai'
    Bundle 'AndrewRadev/splitjoin.vim'
    Bundle 'SirVer/ultisnips'
    Bundle 'Shougo/echodoc.vim'
    Bundle 'plasticboy/vim-markdown'
    Bundle 'easymotion/vim-easymotion'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'ianva/vim-youdao-translater'
endif

if count(g:bundle_groups, 'python')
    " PyLint, Rope, Pydoc, breakpoints from box
    Bundle 'python-mode/python-mode'
endif

if count(g:bundle_groups, 'golang')
    Bundle 'fatih/vim-go'
endif

if count(g:bundle_groups, 'html')
    " emmet
    Bundle 'mattn/emmet-vim'
    " html hilight
    Bundle 'othree/html5.vim'
    " always highlights the enclosing html/xml tags
    Bundle 'Valloric/MatchTagAlways'
endif

if count(g:bundle_groups, 'javascript')
    " javascript hilight
    Bundle 'pangloss/vim-javascript'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp') || count(g:bundle_groups, 'java')
    " async generate and update ctags/gtags
    Bundle 'ludovicchabant/vim-gutentags'
    Bundle 'skywind3000/gutentags_plus'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " switching between companion source files (e.g. ".h" and ".cpp")
    Bundle 'derekwyatt/vim-fswitch'
endif

    "Bundle 'Valloric/YouCompleteMe'
    "Bundle 'rdnetto/YCM-Generator'
let s:is_system_clang = 0
if s:os == "Linux"
    let s:is_libclang7_install=str2nr(system('ldconfig -p | grep "libclang-[789].so" | wc -l'))
    let s:is_libclang7_install+=str2nr(system('strings `ldconfig -p | grep "libclang.so$" | awk -F" "' . " '" . '{print $NF}'. "'" . '` | grep "version [789].[0-9].[0-9]" | wc -l'))
    if s:is_libclang7_install > 0
        let s:is_system_clang = 1
    endif
endif
" powerful code-completion engine
if exists("s:enable_ycm")  && s:enable_ycm == 1
    Bundle 'rdnetto/YCM-Generator', { 'branch': 'stable'}
    if s:is_system_clang
        Bundle 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --java-completer' }
    else
        Bundle 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --java-completer' }
    endif
endif

if count(g:bundle_groups, 'markdown')
    " markdown highlight
    Bundle 'plasticboy/vim-markdown'
    " markdown preview
    Bundle 'iamcco/markdown-preview.vim'
    " markdown mathjax preview
    Bundle 'iamcco/mathjax-support-for-mkdp'
endif

if count(g:bundle_groups, 'json')
    " json highlight
    Bundle 'elzr/vim-json'
endif


call vundle#end()


set encoding=utf-8
set nocompatible                " 关闭 vi 兼容模式
set shortmess=atI               " 启动的时候不显示那个援助乌干达儿童的提示 
set showcmd                     " 输入的命令显示出来，看的清楚些 
set laststatus=2                " 启动显示状态行(1),总是显示状态行(2) 
set showmatch                   " 高亮显示匹配的括号
set matchtime=1                 " 匹配括号高亮的时间（单位是十分之一秒）
set tabstop=4                   " Tab键的宽度
set softtabstop=4               " 统一缩进为4 : 设置按BackSpace的时候可以一次删除掉4个空格
set shiftwidth=4                " 设定 << 和 >> 命令移动时的宽度为 4
set autoindent                  " 自动缩进
set smartindent                 " 智能自动缩进
set expandtab                   " 不要用空格代替制表符
set smarttab                    " 在行和段开始处使用制表符
set number                      " 显示行号
set history=1000                " 历史记录数
set incsearch                   " 实时搜索
set hlsearch                    " 搜索时高亮显示被找到的文本
set cmdheight=1                 " 设定命令行的行数为 1
set helplang=cn                 " 显示中文帮助
set langmenu=zh_CN.UTF-8        " 语言设置
set iskeyword+=_,$,@,%,#,-      " 带有如下符号的单词不要被换行分割
set backspace=2                 " 启用backspace key 
set ruler                       " 显示列号
set scrolloff=6                 " 上下可视行数
set nobackup                    " 覆盖文件时不备份
set autochdir                   " 自动切换当前目录为当前文件所在的目录
set autoread                    " 设置当文件被改动时自动载入
set noswapfile                  " 禁止生成临时文件
set wildmenu                    " 增强模式中的命令行自动完成操作
set whichwrap+=<,>,h,l          " 允许backspace和光标键跨越行边界
set diffopt+=iwhite             " 设置diff模式忽略空行
set nocul                       " 高亮光标所在行 ，行线
set nocuc                       " 显示光标所在的列，列线
set background=dark             " 设置背景
set smartcase
set cindent
set confirm
set textwidth=79
set wrap
"set linespace=0
set t_Co=256
set whichwrap=b,s,<,>,[,]
"if &term=="xterm"
"    set t_Co=8
"    set t_Sb=^[[4%dm
"    set t_Sf=^[[3%dm
"endif

set foldenable                 " 允许折叠   
set foldmethod=manual          " 手动折叠  
set foldcolumn=0
"set foldmethod=syntax 
set foldlevel=3 
" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
"set ignorecase

"状态行显示的内容 
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ [PWD=%{getcwd()}]\ 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"set completeopt=preview,menu 
set completeopt=menu 

"自动语法高亮
syntax on
" 打开语法高亮
syntax enable                
" 检测文件类型
filetype on
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal g'\"" | endif
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用vundle管理vim插件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
set nocompatible              
filetype off      
filetype plugin indent on

" 设置背景主题     
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

"通过事件设置文件类型
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{py}   set filetype=python
"au BufRead,BufNewFile *.{go}   set filetype=go
"au BufRead,BufNewFile *.{js}   set filetype=javascript

"根据文件类型设置词典
au FileType php        setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css        setlocal dict+=~/.vim/dict/css.dict
au FileType c          setlocal dict+=~/.vim/dict/c.dict
au FileType cpp        setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale      setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html       setlocal dict+=~/.vim/dict/javascript.dict
au FileType html       setlocal dict+=~/.vim/dict/css.dict

" quickfix模式
autocmd FileType cpp,c map <buffer> <leader><space> :w<cr>:make<cr>

""""begin根据文件类型插入内容""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
let g:project_root = ""
func SetTitle() 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("$"), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("$"),"# coding=utf-8")
        call append(line("$"), "") 
        call append(line("$"), "") 
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("$"),"# encoding: utf-8")
        call append(line("$"), "")
    elseif &filetype == 'mkd'
        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    elseif &filetype == 'php'
       call setline(1, "<?php")
       call append(line("$"), "/*************************************************************************")
       call append(line("$"), "* $Id$")
       call append(line("$"), "*************************************************************************/")
       call append(line("$"), "")
       call append(line("$"), "")
       call append(line("$"), "")
       call append(line("$"), "/**")
       call append(line("$"), " * @file    : ".expand("%"))
       call append(line("$"), " * @date    : ".strftime("%c"))
       call append(line("$"), " * @version :  $Revision$")
       call append(line("$"), " * @brief   :  ")
       call append(line("$"), " **/")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("$"), "    > File Name: ".expand("%")) 
        call append(line("$"), "    > Author: ") 
        call append(line("$"), "    > Mail: ") 
        call append(line("$"), "    > Created Time: ".strftime("%c")) 
        call append(line("$"), " ************************************************************************/") 
        call append(line("$"), "")
    endif
    if expand("%:e") == 'cpp'
        call append(line("$"), "#include<iostream>")
        call append(line("$"), "using namespace std;")
        call append(line("$"), "")
        call append(line("$"), "int main(int argc, char **argv){")
        call append(line("$"), "")
        call append(line("$"), "\treturn 0;")
        call append(line("$"), "}")
    endif
    if &filetype == 'c'
        call append(line("$"), "#include<stdio.h>")
        call append(line("$"), "")
        call append(line("$"), "")
        call append(line("$"), "int main(int argc, char **argv) {")
        call append(line("$"), "")
        call append(line("$"), "\treturn 0;")
        call append(line("$"), "}")
    endif
    if expand("%:e") == 'h' 
        if g:project_root == ''
            call append(line("$"), "#ifndef _".toupper(expand("%:r"))."_H")
            call append(line("$"), "#define _".toupper(expand("%:r"))."_H")
            call append(line("$"), "#endif")
        else 
            call append(line("$"), "#ifndef ".toupper(substitute(substitute(expand("%:p:r"), g:project_root, "", ""), "/" , "_", "g")."_H_"))
            call append(line("$"), "#define ".toupper(substitute(substitute(expand("%:p:r"), g:project_root, "", ""), "/" , "_", "g")."_H_"))
            call append(line("$"), "#endif  // ".toupper(substitute(substitute(expand("%:p:r"), g:project_root, "", ""), "/" , "_", "g")."_H_"))
        endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc 
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
""""end根据文件类型插入内容"""""

"""""""""" Vim自动补全神器：YouCompleteMe"""""""""""""""""""""""
" 这个leader就映射为逗号“，”
let mapleader ="," 
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 0
"let g:ycm_server_log_level = 'debug'
let g:ycm_global_ycm_extra_conf = '/data1/nblao/ycm_extra_conf.py'  
"let g:ycm_global_ycm_extra_conf = '/data1/nblao/linux_ycm_extra_conf.py'  
"let g:ycm_global_ycm_extra_conf = '/data1/nblao/ngx_ycm_extra_conf.py'  
"打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-S-TAB>','<Up>']
let g:ycm_key_list_select_completion = ['', '']
let g:ycm_key_list_previous_completion = ['','']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_invoke_completion = '<leader><tab>'
let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.', 're!(?=[a-zA-Z_])'],
            \   'objc' : ['->', '.'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::'],
            \   'perl' : ['->'],
            \   'php' : ['->', '::'],
            \   'cs,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'java,jsp' : ['.'],
            \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \ }
"""""""end Ycm""""""""""""""""""""""""""""""""""""""""""""""""""""

if &filetype != 'go'
    "nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif
"nmap <F4> :YcmDiags<CR>

"for golang
let mapleader = ","
" vim-go custom mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gs <Plug>(go-def-split)
au FileType go nmap <Leader>gv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gt <Plug>(go-def-tab)

" k=wiki
au FileType go nmap <Leader>kd <Plug>(go-doc)
au FileType go nmap <Leader>kv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>kb <Plug>(go-doc-browser)

" vim-go settings
let g:go_fmt_command = "goimports"

" for python
au FileType python set omnifunc=pythoncomplete#Complete

""""""""""""end YouCompleteme""""""""""""""""""

"""""""""""" cscope setting""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")                                                                                                                              
	set csprg=/usr/bin/cscope                                                                                                       
	set csto=0                                                                                                                            
	set cst                                                                                                                               
	set nocsverb                                                                                                                          
	" add any database in current directory                                                                                               
	if filereadable("cscope.out")                                                                                                         
		cs add cscope.out                                                                                                                 
		" else add database pointed to by environment                                                                                         
	elseif $CSCOPE_DB != ""                                                                                                               
		cs add $CSCOPE_DB                                                                                                                 
	endif                                                                                                                                 
	set csverb                                                                                                                            
endif                   

nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>


"""""""""""""""""""""" nerdtree begin """""""""""""""""""""""
""使用NERDTree插件查看工程文件。设置快捷键，速记：filelist
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"设置NERDTree子窗口宽度
"let NERDTreeWinSize=40
""设置NERDTree子窗口位置
let NERDTreeWinPos="left"
"设置当打开文件后自动关闭NERDtree窗口
let NERDTreeQuitOnOpen=1
"""""""""""""""""""""" nerdtree end """""""""""""""""""""""

"""""""""tagbar begin""""""""""""""""""""""""""""""""""
"当前文件taglist 窗口  
map <F7>  :TagbarToggle<CR>
imap <F7>  <ESC> :TagberToggle<CR>
"go的tags窗口也
"go的跳转
let g:godef_split=2
let g:tagbar_type_go = {                  
			\    'ctagstype' : 'go',
			\    'kinds'     : [
			\        'p:package',
			\        'i:imports:1',
			\        'c:constants',
			\        'v:variables',
			\        't:types',
            \        'n:interfaces',
            \        'w:fields',
            \        'e:embedded',
            \        'm:methods',
            \        'r:constructor',
            \        'f:functions'
            \    ],
            \    'sro' : '.',
            \    'kind2scope' : {
            \        't' : 'ctype',
            \        'n' : 'ntype'
            \    },
            \    'scope2kind' : {
            \        'ctype' : 't',
            \        'ntype' : 'n'
            \    },
            \    'ctagsbin'  : 'gotags',
            \    'ctagsargs' : '-sort -silent'
            \ }
""""""""""end tagbar""""""""""""""""""""""""""""""""""""""""""""""""""""


" for style
"调用AStyle程序，进行代码美化  
func CodeFormat()  
          "取得当前光标所在行号  
          let lineNum = line(".")  
          "C源程序  
          if &filetype == 'c'  
                    "执行调用外部程序的命令  
                    "exec "%! astyle -A3Lfpjk3NS"  
                    exec "%! astyle --style=google"  
          "H头文件(文件类型识别为cpp)，CPP源程序  
          elseif &filetype == 'cpp'  
                    "执行调用外部程序的命令  
                    "exec "%! astyle -A3Lfpjk3NS"  
                    "exec "%! astyle --style=linux"  
                    exec "%! astyle --style=google"  
          "JAVA源程序  
          elseif &filetype == 'java'  
                    "执行调用外部程序的命令  
                    exec "%! astyle -A2Lfpjk3NS"  
          elseif &filetype == 'py'|| &filetype == 'python'
                    exec "%! yapf --style='{based_on_style: google, indent_width: 4}'"
          else   
                    "提示信息  
                    echo "不支持".&filetype."文件类型。"  
          endif  
          "返回先前光标所在行  
          exec lineNum  
endfunc  
"映射代码美化函数到Shift+f快捷键  
map <F12> <Esc>:call CodeFormat()<CR>  

vnoremap <silent> <C-F> :<C-u>Ydv<CR>
nnoremap <silent> <C-F> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']

" 设置easymotion的触发键
let g:EasyMotion_leader_key = '\'
" 允许设置默认快捷键
let g:EasyMotion_do_mapping = 1
" 智能大小写匹配
let g:EasyMotion_smartcase = 1
" 按回车自动跳到第一个匹配
let g:EasyMotion_enter_jump_first = 1
" s查找字符
nmap <Leader>f <Plug>(easymotion-overwin-f)
xmap <Leader>f <Plug>(easymotion-bd-f)
omap <Leader>f <Plug>(easymotion-bd-f)

nmap tl :Tlist<cr>
"map lw oBd_Log::warning("***********lw*************".var_export($, true));<ESC>F$1li


"cs kill 0
"cs add /data1/dev/cmap /data1/dev/cmap
