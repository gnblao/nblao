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
set smartcase
set cindent
set confirm
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

" 设置背景主题     
"color desert    
"colorscheme molokai
color pablo      
"color corporation    
"状态行显示的内容 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   

"自动语法高亮
syntax on
" 打开语法高亮
syntax enable                
" 检测文件类型
filetype on
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用vundle管理vim插件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
call vundle#begin()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here:
" original repos on github
Bundle 'Valloric/YouCompleteMe'
"Bundle 'rdnetto/YCM-Generator'
Bundle 'tpope/vim-fugitive'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'L9'
Bundle 'FuzzyFinder'

"左窗口文件目录
Bundle 'scrooloose/nerdtree'                 
Bundle 'scrooloose/syntastic'                 

"for golang
Bundle 'fatih/vim-go'
Bundle 'SirVer/ultisnips'
Bundle 'majutsushi/tagbar'
"Bundle 'dgryski/vim-godef'
"Bundle 'nsf/gocode', {'rtp': 'vim/'}

" non github repos
Bundle 'Yggdroot/indentLine'
Bundle 'Auto-Pairs'
Bundle 'python-imports.vim'
Bundle 'last_edit_marker.vim'
Bundle 'synmark.vim'
Bundle 'Python-mode-klen'
Bundle 'SQLComplete.vim'
Bundle 'jslint.vim'
Bundle "pangloss/vim-javascript"
"Bundle 'Vim-Script-Updater'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'jsbeautify'

"django
"Bundle 'django_templates.vim'
"Bundle 'Django-Projects'
"Bundle 'FredKSchott/CoVim'
"Bundle 'djangojump'
" ...
call vundle#end()

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


"通过事件设置文件类型
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript

"根据文件类型设置词典
au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict


""""""""""""""""""begin golang语言"""""""""""""""""""""""""""""""""""""""""""""
" set mapleader
 let mapleader = ","
 " vim-go custom mappings
 au FileType go nmap <Leader>s <Plug>(go-implements)
 au FileType go nmap <Leader>i <Plug>(go-info)
 au FileType go nmap <Leader>gd <Plug>(go-doc)
 au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
 au FileType go nmap <leader>r <Plug>(go-run)
 au FileType go nmap <leader>b <Plug>(go-build)
 au FileType go nmap <leader>t <Plug>(go-test)
 au FileType go nmap <leader>c <Plug>(go-coverage)
 au FileType go nmap <Leader>ds <Plug>(go-def-split)
 au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
 au FileType go nmap <Leader>dt <Plug>(go-def-tab)
 au FileType go nmap <Leader>e <Plug>(go-rename)

" vim-go settings
let g:go_fmt_command = "goimports"

""""""""""""""""""end golang语言""""""""""""""""


""""begin根据文件类型插入内容""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("$"), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("$"),"# coding=utf-8")
        call append(line("$"), "") 
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("$"),"# encoding: utf-8")
        call append(line("$"), "")
    elseif &filetype == 'mkd'
        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
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
        call append(line("$"), "int main(int argc, char **argv){")
        call append(line("$"), "")
        call append(line("$"), "\treturn 0;")
        call append(line("$"), "}")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc 
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
""""end根据文件类型插入内容"""""

"""""键盘命令""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"去空行  
"nnoremap <F2> :g/^\s*$/d<CR> 

"C，C++ 按F5编译运行
"map <F5> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"    exec "w"
"    if &filetype == 'c'
"        exec "!g++ % -o %<"
"        exec "!time ./%<"
"    elseif &filetype == 'cpp'
"        exec "!g++ % -o %<"
"        exec "!time ./%<"
"    elseif &filetype == 'java' 
"        exec "!javac %" 
"        exec "!time java %<"
"    elseif &filetype == 'sh'
"        :!time bash %
"    elseif &filetype == 'python'
"        exec "!time python2.7 %"
"    elseif &filetype == 'html'
"        exec "!firefox % &"
"    elseif &filetype == 'go'
""        exec "!go build %<"
"        exec "!time go run %"
"    elseif &filetype == 'mkd'
"        exec "!~/.vim/markdown.pl % > %.html &"
"        exec "!firefox %.html &"
"    endif
"endfunc




""""""""""代码格式优化化"""""""""""""""""""""""""""""""""""
map <F6> :call FormartSrc()<CR><CR>
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc

"C,C++的调试
"map <F8> :call Rungdb()<CR>
"func! Rungdb()
"    exec "w"
"    exec "!g++ % -g -o %<"
"    exec "!gdb ./%<"
"endfunc
""""""""end"""""""""""""""""""""""""""""""""


"""""""""""""""记录上次编辑位置""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("autocmd")
"      autocmd BufReadPost *
"          \ if line("'\"") > 0 && line("'\"") <= line("$") |
"          \   exe "normal g`\"" |
"          \ endif
"endif



" quickfix模式
autocmd FileType cpp,c map <buffer> <leader><space> :w<cr>:make<cr>
"set completeopt=preview,menu 
set completeopt=menu 

" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1  
nmap tl :Tlist<cr>
"python补全
let g:pydiction_location = '~/.vim/after/complete-dict'
let g:pydiction_menu_height = 20
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
set iskeyword+=.
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
autocmd FileType python set omnifunc=pythoncomplete#Complete


""""""""""" Vim自动补全神器：YouCompleteMe"""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['', '']
let g:ycm_key_list_previous_completion = ['', '']
let g:ycm_key_invoke_completion = '<C-Space>'

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
"配置默认的ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '/home/nblao/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/ycm_extra_conf.py'  
"打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf=0   
"使用ctags生成的tags文件"
let g:ycm_collect_identifiers_from_tag_files = 1
" 这个leader就映射为逗号“，”
let mapleader ="," 
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nmap <F4> :YcmDiags<CR>

""""""""""""end YouCompleteme""""""""""""""""""

"""""""""""" cscope setting""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("cscope")
"  if MySys() == "linux"
"    set csprg=/usr/bin/cscope
"  else
"    set csprg=cscope
"  endif
"  set csto=1
"  set cst
"  set nocsverb
"  " add any database in current directory
"  if filereadable("cscope.out")
"      cs add cscope.out
"  endif
"  set csverb
"endif
"
"nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""UltiSnips settings""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"""""""""""end UltiSnips settings"""""

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']
"colorscheme molokai
