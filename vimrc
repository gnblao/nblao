" 1. put this file in location ~/.vimrc
" 2. install cmake and gcc   (fedroa sudo dnf install cmake gcc-c++ make python3-devel
" 3. custom plugin bundle groups
"   ctags (https://github.com/universal-ctags/ctags.git
"   gtags-ctags GNU-global (sudo dnf install global-ctags for fedroa
"   c/cpp require install cscope clang-format
"   java/c/cpp/scala/python require install GNU-global and https://github.com/yoshizow/global-pygments-plugin
"   scala require pip install websocket-client sexpdata
"   scala require sbt
"   java require install JDK8 or JDK11
"   python require install flake8, pylintl, yapf and autopep8(sudo -H pip install flake8 pylint yapf autopep8)
if !exists('g:bundle_groups')
    " let g:bundle_groups=['base', 'python', 'c', 'cpp', 'golang', 'html', 'javascript', 'markdown', 'java', 'json', 'shell', 'protobuf', 'thrift', 'scala']
    let g:bundle_groups=['base', 'python', 'c', 'cpp', 'markdown', 'json', 'shell', 'protobuf', 'thrift', 'scala', 'golang', 'java']
endif
" 4. is enable cpp_clang_highlight
let s:cpp_clang_highlight = 0
" 5. is enable is_system_clang
let s:is_system_clang = 1
" 6. is enable coc.nvim, a LSP intellisense engine, better than ycm
" this need cland10 above or GLIBC_2.18 above for c++
let s:enable_coc = 1
" 7. is enable builty plugin, this require set terminal font to DroidSansMono Nerd\ Font\ 11
" the font will auto install when vim first running
let s:builty_vim = 1
" 8. run vim, wait for plugins auto install
" 9. well done!


" check os
if !exists("s:os")
    if has("win64") || has("win32") || has("win16")
        let s:os = "Windows"
    else
        let s:os = substitute(system('uname'), '\n', '', '')
    endif
endif


" install font for builty_vim
function! InstallAirLineFont()
    let s:usr_font_path = $HOME . '/.local/share/fonts/custom/DroidSansMonoforPowerlineNerdFontComplete.otf'
    if s:os == "Darwin" "mac
        let s:system_font_path = '/Library/Fonts/DroidSansMonoforPowerlineNerdFontComplete.otf'
    elseif s:os == "Linux"
        let s:system_font_path = '/usr/share/fonts/custom/DroidSansMonoforPowerlineNerdFontComplete.otf'
        "elseif s:os == "Windows"
    endif

    if exists("s:builty_vim") && s:builty_vim == 1
                \ && !filereadable(s:usr_font_path)
        execute '!curl -fLo ' . s:usr_font_path . ' --create-dirs ' . 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid\%20Sans\%20Mono\%20Nerd\%20Font\%20Complete.otf'
        execute '!fc-cache -v'
        "if !filereadable(s:system_font_path) && filereadable(s:usr_font_path)
        "    execute '!sudo mkdir `dirname ' . shellescape(s:system_font_path) . '` && sudo cp ' . shellescape(s:usr_font_path) . ' ' . shellescape(s:system_font_path)
        "endif
    endif
endfunction
if !exists(":InstallAirLineFont")
    command -nargs=0 InstallAirLineFont :call InstallAirLineFont()
endif

if empty(glob('~/.local/share/fonts/custom/DroidSansMonoforPowerlineNerdFontComplete.otf'))
     augroup vim_font_
        autocmd!
        "autocmd VimEnter * call InstallAirLineFont()
    augroup END
endif

" check is enable system clipboard
"if has('clipboard') && !empty($DISPLAY)
"    let s:enable_system_clipboard = 1
"else
"    let s:enable_system_clipboard = 0
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用vim-plug管理vim插件
" auto install plugin manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/bundle/vim-plug/plug.vim'))
    "silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !git clone https://github.com/junegunn/vim-plug.git ~/.vim/bundle/vim-plug && cd ~/.vim/bundle/vim-plug && ln -s ../vim-plug  autoload 
    augroup vim-plug_
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

set rtp+=~/.vim/bundle/vim-plug/
"
call plug#begin('~/.vim/bundle')
if count(g:bundle_groups, 'base')
    Plug 'junegunn/vim-plug'
    Plug 'godlygeek/tabular'          
   
    Plug 'preservim/tagbar'
    "Plug 'majutsushi/tagbar'
    Plug 'liuchengxu/vista.vim'
    
    Plug 'scrooloose/nerdtree'                 
    "Plug 'Auto-Pairs'
    Plug 'tomasr/molokai'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'AndrewRadev/splitjoin.vim'
"    Plug 'SirVer/ultisnips'
"    Plug 'Shougo/echodoc.vim'
    "Plug 'easymotion/vim-easymotion'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'rhysd/vim-clang-format'

    Plug 'bujnlc8/vim-translator'
    Plug 'tpope/vim-characterize'

    " file header, like author license etc.
    "Plug 'alpertuna/vim-header'
endif

if exists("s:enable_coc")  && s:enable_coc == 1
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp') || count(g:bundle_groups, 'java')
    " async generate and update ctags/gtags
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'TC500/gutentags_plus'
    "Plug 'skywind3000/gutentags_plus'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " switching between companion source files (e.g. .h and .cpp)
    Plug 'derekwyatt/vim-fswitch'
endif

if count(g:bundle_groups, 'cpp')
    " cpp highlight
    if exists("s:cpp_clang_highlight")  && s:cpp_clang_highlight == 1
        if s:is_system_clang
            Plug 'jeaye/color_coded', {'do': 'dir=`mktemp -d` && cd $dir && cmake -DDOWNLOAD_CLANG=0 ~/.vim/bundle/color_coded/ && make && make install'}
        else
            Plug 'jeaye/color_coded', {'do': 'dir=`mktemp -d` && cd $dir && cmake ~/.vim/bundle/color_coded/ && make && make install'}
        endif
    else
        Plug 'bfrg/vim-cpp-modern'
    endif
endif


if count(g:bundle_groups, 'python')
    " PyLint, Rope, Pydoc, breakpoints from box
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
endif

if count(g:bundle_groups, 'golang')
    "Plug 'fatih/vim-go'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'dgryski/vim-godef'
    Plug 'Blackrush/vim-gocode'
endif

if count(g:bundle_groups, 'html')
    " emmet
    Plug 'mattn/emmet-vim'
    " html hilight
    Plug 'othree/html5.vim'
    " always highlights the enclosing html/xml tags
    Plug 'Valloric/MatchTagAlways'
endif

if count(g:bundle_groups, 'javascript')
    " javascript hilight
    Plug 'pangloss/vim-javascript'
endif


if count(g:bundle_groups, 'markdown')
    " markdown highlight
    Plug 'plasticboy/vim-markdown'
    " markdown preview
    Plug 'iamcco/markdown-preview.vim'
    " markdown mathjax preview
    Plug 'iamcco/mathjax-support-for-mkdp'
endif

if count(g:bundle_groups, 'json')
    " json highlight
    Plug 'elzr/vim-json'
endif


call plug#end()

" -encode set begin-
set modifiable
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"multi-encoding setting
if has("multi_byte")
    " set bomb
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        " Copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " Copied from someone's dotfile, untested
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif
" -encode set end -

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
set cmdheight=2                 " 设定命令行的行数为 1
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

"see help completeopt
set completeopt=preview,menu 
"set completeopt=menu 

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

" auto close preview when complete done
"autocmd CompleteDone * pclose

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " enables automatic C program indenting
    set cindent
    " see :help cinoptions-values
    set cinoptions=:0,p0,t0
    " These keywords start an extra indent in the next line when 'smartindent' or 'cindent' is set
    set cinwords+=if,else,while,do,for,switch,case,try,catch
endif

"ctag gtag cscope  cstags.... 
set cscopetag                  " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope

let s:is_exuberant_ctags=str2nr(system('ctags --version | head -n1 | grep ^Exuberant | wc -l'))
let s:is_universal_ctags=str2nr(system('ctags --version | head -n1 | grep ^Universal | wc -l'))
if s:is_universal_ctags > 1
    let s:is_exuberant_ctags = 0
endif

" for tagbar
if s:is_exuberant_ctags > 0
    map <F9> :TagbarToggle<CR>
    let g:tagbar_map_showproto = "<leader><leader>"
    let g:tagbar_map_togglesort = "<leader>s"
    let g:tagbar_width = 30
    let g:tagbar_autofocus = 1
    let g:tagbar_autoshowtag = 1
    " open tagbar if ext match
    if !&diff
        augroup tagbar_
            autocmd!
            autocmd BufReadPost * if count(['c','cpp','python','java','scala','go'], &ft) | call tagbar#autoopen() | endif
        augroup END
    endif
endif

" for vista
if s:is_universal_ctags > 0
    nmap <F9> :Vista!!<CR>
    let g:vista_default_executive = 'coc'
    let g:vista_sidebar_width = 40
    "let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
    let g:vista_close_on_fzf_select = 0 
   
    let g:vista#renderer#enable_icon = 0
    " not move to the vista window when it is opened
    let g:vista_stay_on_open = 0
    let vista_update_on_text_changed = 1
    "let g:vista_ctags_cmd = {
    "            \ 'haskell': 'hasktags -x -o - -c',
    "            \ 'cpp': 'ctags --fields=+niaztkS --c-kinds=+px --c++-kinds=+px',
    "            \ }
    augroup vista_
        autocmd!
        autocmd BufReadPost * if count(['c','cpp','python','java','scala','go'], &ft) | Vista!! | endif
        "autocmd BufEnter * if count(['c','cpp','python','java','scala','go'], &ft) | Vista | endif
        autocmd QuitPre * if count(['c','cpp','python','java','scala','go'], &ft) | Vista! | endif
    augroup END
endif


" for debug
let g:gutentags_trace = 0
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_project_root = ['.root', '.git']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:gutentags_ctags_extra_args = ['--fields=+niaztkS']
"let g:gutentags_ctags_extra_args = ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
if s:is_universal_ctags > 0
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
    let g:gutentags_ctags_extra_args = ['--extras=+qf']
endif 

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
" force update tags file
let g:gutentags_define_advanced_commands = 1
nmap <leader>u :GutentagsUpdate! <CR><CR>

" gutentags_plus
" disable default keymap
let g:gutentags_plus_nomap = 1
" auto switch to quickfix window
let g:gutentags_plus_switch = 1
" auto close quickfix if press <CR>
let g:gutentags_plus_auto_close_list = 1
" find this symbol
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" find this definition
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" find functions calling this function
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
"" find this text string
"noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
"" find this egrep pattern
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
"" find this file
"noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
"" find files #including this file
"noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
"" find functions called by this function
"noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
"" find places where this symbol is assigned a value
"noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>


""""""""""""""""""""""""""""""""""""""ncoc"""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
if exists("s:enable_coc")  && s:enable_coc == 1
    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> <C-g> <Plug>(coc-definition)
    nmap <silent> <leader>gd <Plug>(coc-definition)
    nmap <silent> <leader>gt <Plug>(coc-type-definition)
    nmap <silent> <leader>gi <Plug>(coc-implementation)
    nmap <silent> <leader>gr <Plug>(coc-references)

    " Apply AutoFix to problem on the current line.
    nmap <leader>gy <Plug>(coc-fix-current)

    " Use K to show documentation in preview window.
    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocActionAsync('doHover')
        endif
    endfunction
    nnoremap <silent> <leader>gh :call <SID>show_documentation()<CR>
    augroup coc_
        autocmd!
        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')
        " autocmd CursorHold * silent call CocActionAsync('doHover')
    augroup END
	" Show all diagnostics.
    nnoremap <silent> <leader>ga  :<C-u>CocList diagnostics<cr>
    " rename the current word in the cursor
    nmap <leader>gn <Plug>(coc-rename)

    " let g:node_client_debug = 1
    let g:coc_global_extensions = []
    "let g:coc_global_extensions += ['coc-ultisnips']
    let g:coc_global_extensions += ['coc-yaml']
    let g:coc_global_extensions += ['coc-highlight']
    let g:coc_global_extensions += ['coc-git']
    let g:coc_global_extensions += ['coc-vimlsp']
    let g:coc_global_extensions += ['coc-tsserver']
    let g:coc_global_extensions += ['coc-sh']
    let g:coc_global_extensions += ['coc-explorer']
    call coc#config('explorer.icon.source', 'nvim-web-devicons')
    if count(g:bundle_groups, 'json')
        let g:coc_global_extensions += ['coc-json']
    endif
    if count(g:bundle_groups, 'java')
        let g:coc_global_extensions += ['coc-java']
    endif
    if count(g:bundle_groups, 'scala')
        let g:coc_global_extensions += ['coc-metals']
    endif
    if count(g:bundle_groups, 'markdown')
        let g:coc_global_extensions += ['coc-markdownlint']
    endif
    if count(g:bundle_groups, 'python')
        let g:coc_global_extensions += ['coc-pyright']
        call coc#config('python.pythonPath', '/usr/bin/python3')
    endif
    if count(g:bundle_groups, 'golang')
        let g:coc_global_extensions += ['coc-go']
    endif
   if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
        let g:coc_global_extensions += ['coc-clangd']
        call coc#config('clangd.semanticHighlighting', 1)
        " call coc#config('clangd.path', '/home/work/dev_env/bin/clangd')
        " call coc#config('clangd.arguments', ["--background-index","-j=4","--index","-suggest-missing-includes=false"])
        " call coc#config('coc.preferences', {
        " \ 'timeout': 1000,
        " \})

        highlight LspCxxHlGroupMemberVariable ctermfg=LightGray  guifg=LightGray
    endif
    let g:SuperTabDefaultCompletionType = 'context'
    "inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endif


""""""""""""""""""""""""""""""""""""""Plug"""""""""""""""""""""""""""""""""""""""""""""""""

" 设置背景主题     
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
" for dracula
"let g:dracula_italic = 0
"colorscheme dracula


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
let g:project_root = "/opt/work/cmap"
func SetTitle() 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("$"), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python3")
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
        call append(line("$"), "    > Author: gnblao") 
        call append(line("$"), "    > Mail: gnbalo") 
        call append(line("$"), "    > Created Time: ".strftime("%c")) 
        call append(line("$"), " ************************************************************************/") 
        call append(line("$"), "")
    endif
    if expand("%:e") == 'cpp'
        call append(line("$"), "#include<iostream>")
        "call append(line("$"), "using namespace std;")
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
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc 
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
""""end根据文件类型插入内容"""""

" vim-cpp-modern
" Enable highlighting of named requirements (C++20 library concepts)
let g:cpp_named_requirements_highlight = 1


"let mapleader = ","
if &filetype != 'go'
    "nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
    "nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
    "nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

elseif &filetype == 'go'
    "for golang
    nnoremap <leader>c <Plug>(go-coverage)
    nnoremap <Leader>s <Plug>(go-implements)
    nnoremap <Leader>i <Plug>(go-info)
    nnoremap <Leader>e <Plug>(go-rename)
    
    nnoremap <Leader>gd <Plug>(go-def)
    nnoremap <Leader>gs <Plug>(go-def-split)
    nnoremap <Leader>gv <Plug>(go-def-vertical)
    nnoremap <Leader>gt <Plug>(go-def-tab)
    " k=wiki
    nnoremap <Leader>kd <Plug>(go-doc)
    nnoremap <Leader>kv <Plug>(go-doc-vertical)
    nnoremap <Leader>kb <Plug>(go-doc-browser)
    
endif

"nmap <F4> :YcmDiags<CR>
" vim-go settings
let g:go_fmt_command = "goimports"

" for python
au FileType python set omnifunc=pythoncomplete#Complete


"""""""""""""""""""""" nerdtree begin """""""""""""""""""""""
""NERDTree
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"let NERDTreeWinSize=40
"设置NERDTree子窗口位置
let NERDTreeWinPos="left"
"设置当打开文件后自动关闭NERDtree窗口
let NERDTreeQuitOnOpen=1

nmap <F4> <Cmd>CocCommand explorer<CR>

"""""""""""""""""""""" nerdtree end """""""""""""""""""""""

"""""""""tagbar begin""""""""""""""""""""""""""""""""""
"当前文件taglist 窗口 
"let g:tagbar_ctags_bin="/usr/bin/gtags"
"let g:tagbar_ctags_options='-e'
map <F7>  :TagbarToggle <CR>
imap <F7>  <ESC> :TagbarToggle <CR>
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
                    exec "%! astyle --style=allman"  
                    "exec "%! astyle --style=google"  
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


let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0
"let g:clang_format#code_style = 'google'
"let g:clang_format#code_style = 'Microsoft'
let g:clang_format#code_style = 'LLVM'
let g:clang_format#style_options = {
            \ "ColumnLimit" : 79,
            \ "AccessModifierOffset" : -4}

"            \ "AlignConsecutiveMacros": "true",
"            \ "AlignConsecutiveAssignments": "true",
"            \ "AlignConsecutiveDeclarations": "true",
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

""""""""""""""""""""""vim-translator""""""""""""
let g:translator_cache=0
let g:translator_cache_path='~/.cache/vim-translator'
let g:translator_channel='youdao'      " youdao|baidu   
let g:translator_outputype='popup'      " popup|echo|
vnoremap <leader>yd :<C-u>Tv<CR>
nnoremap <leader>yd :<C-u>Tc<CR>



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


function! s:AddCharOfCursor()
	let c = col('.')
	let l = line('.')
	let l0 = line("'<")
	let l1 = line("'>")
	let char0 = strpart(getline('.'),c-1,1)
	for k in range(1, l1-l0) "从第2行开始
		let str_before = strpart(getline(l+k),0,c-1)
		let str_after = strpart(getline(l+k),c)
		if char0 =~ '\d'
			let char1 = char0 + k
		else
			let char1 = nr2char(char2nr(char0)+k)
		endif
		call setline(l+k, str_before . char1 . str_after)
	endfor
endfunction

vnoremap <F3> :<C-u>call <SID>AddCharOfCursor()<CR>

"for JSON compilation database
"-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
"bear -- <your-build-command>

" INSERT mode
"let &t_SI = "\<Esc>[2 q" . "\<Esc>]12;yellow\x7"
" REPLACE mode
"let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"
" NORMAL mode
"let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"
