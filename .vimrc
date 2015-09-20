"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关   
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 关闭 vi 兼容模式
set nocompatible
" 启动的时候不显示那个援助乌干达儿童的提示
set shortmess=atI     
"高亮光标所在行
set cul 
set cuc


" 设置背景主题     
color desert     
"color ron     
"color torte    
" 用浅色高亮当前行
autocmd InsertLeave * set nocul  
" 用浅色高亮当前行 
"autocmd InsertEnter * set cul    


" 输入的命令显示出来，看的清楚些
set showcmd          
"状态行显示的内容 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   
" 启动显示状态行(1),总是显示状态行(2)
set laststatus=2     
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1


" 允许折叠  
"set foldenable     
" 手动折叠 
"set foldmethod=manual    
"set foldcolumn=0
"set foldmethod=indent 
"set foldlevel=3 

"设置缩进
set tabstop=4           " Tab键的宽度
set softtabstop=4       " 统一缩进为4 : 设置按BackSpace的时候可以一次删除掉4个空格
set shiftwidth=4        " 设定 << 和 >> 命令移动时的宽度为 4
set autoindent          " 自动缩进
set cindent
" 智能自动缩进
set smartindent
if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif


" 不要用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab

" 显示行号
set number
" 历史记录数
set history=1000
" 实时搜索
set incsearch
" 搜索时高亮显示被找到的文本
set hlsearch


" 显示中文帮助
set encoding=utf-8
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

" 设定命令行的行数为 1
set cmdheight=1

"自动语法高亮
syntax on
" 打开语法高亮
syntax enable                
" 检测文件类型
filetype on
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

" 保存全局变量
"set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 启用backspace key
set backspace=2 
set t_Co=256
" set whichwrap+=<,>,h,l
set whichwrap=b,s,<,>,[,]
" 显示行号
set number
" 显示列号
set ruler
" 上下可视行数
set scrolloff=6


" 不突出显示当前行
set nocursorline
" 覆盖文件时不备份
set nobackup
" 自动切换当前目录为当前文件所在的目录
set autochdir
" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
"set ignorecase
set smartcase
" 搜索到文件两端时不重新搜索
set nowrapscan
" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set hidden
" 设置diff模式忽略空行
set diffopt+=iwhite
" 解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题
set display=lastline
" 设置当文件被改动时自动载入
set autoread
"共享剪贴板  
"set clipboard+=unnamed 
"自动保存
"set autowrite
"突出显示当前行               
"set cursorlin
"设置魔术e              
"set magic    
"隐藏工具栏               
"set guioption
"隐藏菜单栏           
"set guioptions-=m           
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set noswapfile
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

"根据文件类型设置词典
au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict


"通过事件设置文件类型
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript

"记住上次编辑位置
"autocmd BufReadPost *
"      if line("'\"") > 0 && line("'\"") <= line("$") |
"      exe "normal g`\"" |
"      endif
"


"将tab替换为空格
"nmap tt :%s/\t/    /g<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nmap <silent> <F9> <ESC>:Tlist<RETURN>

"去空行  
"nnoremap <F2> :g/^\s*$/d<CR> 

"列出当前目录文件  
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录  
"map <C-F3> \be  
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

"列出当前目录文件  
map <F7>  :TagbarToggle<CR>
imap <F7>  <ESC> :NERDTreeToggle<CR>
"go的跳转
"go的tags窗口也
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

"C,C++的调试
"map <F8> :call Rungdb()<CR>
"func! Rungdb()
"    exec "w"
"    exec "!g++ % -g -o %<"
"    exec "!gdb ./%<"
"endfunc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"代码格式优化化
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F6> :call FormartSrc()<CR><CR>
"定义FormartSrc()
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("autocmd")
"      autocmd BufReadPost *
"          \ if line("'\"") > 0 && line("'\"") <= line("$") |
"          \   exe "normal g`\"" |
"          \ endif
"endif
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
set completeopt=preview,menu 



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag list (ctags) 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"默认打开Taglist 
let Tlist_Auto_Open=0 
let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags' 
let Tlist_Use_Right_Window = 1  "在右侧窗口中显示taglist窗口
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"其他东东
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置WinManager插件
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
map <silent> <F9> :WMToggle<cr> "将F9绑定至WinManager,即打开WimManager"
au VimEnter * :WMOpen


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用vundle管理vim插件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github

"Bundle 'Valloric/YouCompleteMe'
"Bundle 'Valloric/ListToggle'
"Bundle 'scrooloose/syntastic'

Bundle 'tpope/vim-fugitive'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Yggdroot/indentLine'
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'Auto-Pairs'
Bundle 'python-imports.vim'
"Bundle 'CaptureClipboard'
Bundle 'ctrlp-modified.vim'
Bundle 'last_edit_marker.vim'
Bundle 'synmark.vim'
Bundle 'Python-mode-klen'
Bundle 'SQLComplete.vim'
Bundle 'jslint.vim'
Bundle "pangloss/vim-javascript"
Bundle 'Vim-Script-Updater'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'jsbeautify'
Bundle 'The-NERD-Commenter'
"django
Bundle 'cespare/vim-golang'
Bundle 'dgryski/vim-godef'
Bundle 'majutsushi/tagbar'
Bundle 'django_templates.vim'
Bundle 'Django-Projects'
"Bundle 'FredKSchott/CoVim'
"Bundle 'djangojump'
" ...




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim自动补全神器：YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:ycm_error_symbol = '>>'
"let g:ycm_warning_symbol = '>*'
""配置默认的ycm_extra_conf.py
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'  
""打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_confirm_extra_conf=0   
""使用ctags生成的tags文件"
"let g:ycm_collect_identifiers_from_tag_files = 1
"" 这个leader就映射为逗号“，”
"let mapleader = "," 
"nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nmap <F4> :YcmDiags<CR>
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
"let g:ctrlp_extensions = ['funky']
