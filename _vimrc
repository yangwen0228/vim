" =============================================================================
"                          << 设置全局变量 >>
" =============================================================================
" {{{
    let mapleader = ","
    let g:mapleader = ","
    let g:tempfilesdir = $VIM . "/vimfiles/tempfiles"
    let g:personaldir = $VIM . "/vimfiles/personal"
    let g:utilsdir = $VIM . "/vimfiles/utils"
" }}}


" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"      < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
"  {{{
    let g:iswindows = 0
    let g:islinux = 0
    if(has("win32") || has("win64") || has("win95") || has("win16"))
        let g:iswindows = 1
    else
        let g:islinux = 1
    endif
"  }}} < 判断操作系统是否是 Windows 还是 Linux >

" -----------------------------------------------------------------------------
"      < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
"  {{{
    if has("gui_running")
        let g:isGUI = 1
    else
        let g:isGUI = 0
    endif
"  }}} < 判断是终端还是 Gvim >


" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"      < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
"  {{{
    if (g:iswindows && g:isGUI)
        source $VIMRUNTIME/vimrc_example.vim
        source $VIMRUNTIME/mswin.vim
        behave mswin
        set diffexpr=MyDiff()

        function! MyDiff()
            let opt = '-a --binary '
            if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
            if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
            let arg1 = v:fname_in
            if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
            let arg2 = v:fname_new
            if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
            let arg3 = v:fname_out
            if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
            let eq = ''
            if $VIMRUNTIME =~ ' '
                if &sh =~ '\<cmd'
                    let cmd = '""' . $VIMRUNTIME . '\diff"'
                    let eq = '"'
                else
                    let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
                endif
            else
                let cmd = $VIMRUNTIME . '\diff'
            endif
            silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
        endfunction
    endif
"  }}} < Windows Gvim 默认配置>

" -----------------------------------------------------------------------------
"      < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
"  {{{
    if g:islinux
        if g:isGUI
            " Source a global configuration file if available
            if filereadable("/etc/vim/gvimrc.local")
                source /etc/vim/gvimrc.local
            endif
        else
            " This line should not be removed as it ensures that various options are
            " properly set to work with the Vim-related packages available in Debian.
            runtime! debian.vim

            " Source a global configuration file if available
            if filereadable("/etc/vim/vimrc.local")
                source /etc/vim/vimrc.local
            endif
        endif
    endif
"  }}} < Linux Gvim/Vim 默认配置>

" -----------------------------------------------------------------------------
"      < 编码配置 >
" -----------------------------------------------------------------------------
"  {{{
    " 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
    if (g:iswindows)
        set encoding=utf-8                                    "设置gvim内部编码，默认不更改
        set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
        set fileencodings=utf-8,cp936,ucs-bom,gbk,latin-1     "设置支持打开的文件的编码

        " 文件格式，默认 ffs=dos,unix
        set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
        set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型
    else
        set encoding=utf-8                                    "设置gvim内部编码，默认不更改
        set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
        set fileencodings=utf-8,ucs-bom,gbk,cp936,latin-1     "设置支持打开的文件的编码

        " 文件格式，默认 ffs=dos,unix
        set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
        set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型
    endif

    if (g:iswindows && g:isGUI)
        "解决菜单乱码
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim

        "解决consle输出乱码
        language messages zh_CN.utf-8
    endif
"  }}} < 编码配置 >

" -----------------------------------------------------------------------------
"      < 编写文件时的配置 >
" -----------------------------------------------------------------------------
"  {{{
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
    " Vim5 and later versions support syntax highlighting. Uncommenting the next
    " line enables syntax highlighting by default.
    if has("syntax")
        syntax on
    endif

    set noundofile
    set mouse=a                    " 在任何模式下启用鼠标
    set t_Co=256                   " 在终端启用256色
    set backspace=2                " 设置退格键可用

    set smartindent                                       "启用智能对齐方式
    set expandtab                                         "将Tab键转换为空格
    set tabstop=4                                         "设置Tab键的宽度，可以更改，如：宽度为2
    set shiftwidth=4                                      "换行时自动缩进宽度，可更改（宽度同tabstop）
    set smarttab                                          "指定按一次backspace就删除shiftwidth宽度
    set nofoldenable                                      "启用/不启用折叠 foldenable/nofoldenable
    set foldmethod=indent                                 "indent 折叠方式
    " set foldmethod=marker                                "marker 折叠方式
    set foldexpr=1 " 折叠显示为一行

    " 常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）
    " 与easymotion冲突，关掉了
    " nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

    " 当文件在外部被修改，自动更新该文件
    set autoread

    " 常规模式下输入 cS 清除行尾空格
    nmap cS :%s/\s\+$//g<CR>:noh<CR>

    " 常规模式下输入 cM 清除行尾 ^M 符号
    nmap cM :%s/\r$//g<CR>:noh<CR>

    set ignorecase                                        "搜索模式里忽略大小写
    set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
    " set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

    " 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
    au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
"  }}} < 编写文件时的配置 >

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
"  {{{
    set number                                            "显示行号
    set laststatus=2                                      "启用状态栏信息
    set cmdheight=2                                       "设置命令行的高度为2，默认为1
    set cursorline                                        "突出显示当前行
    set guifont=YaHei_Consolas_Hybrid:h12                 "设置字体:字号（字体名称空格用下划线代替）
    " set guifont=Powerline\ Consolas:h12                 "设置字体:字号（字体名称空格用下划线代替）
    "set nowrap                                            "设置不自动换行
    set wrap                                              "设置自动换行
    set shortmess=atI                                     "去掉欢迎界面

    " 设置 gVim 窗口初始位置及大小
    if g:isGUI
        au GUIEnter * simalt ~x                           "窗口启动时自动最大化
        winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
        set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
    endif

    " 设置代码配色方案
    if g:isGUI
        " colorscheme Tomorrow-Night-Eighties               "Gvim配色方案
        " colorscheme monokai                                 "Gvim配色方案
        colorscheme solarized                                 "Gvim配色方案
    else
        " colorscheme Tomorrow-Night-Eighties               "终端配色方案
        " colorscheme monokai                                 "终端配色方案
        colorscheme solarized                                 "终端配色方案
    endif

    " 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
    if g:isGUI
        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=L
        nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
            \set guioptions-=m <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=r <Bar>
            \set guioptions-=L <Bar>
        \else <Bar>
            \set guioptions+=m <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=r <Bar>
            \set guioptions+=L <Bar>
        \endif<CR>
    endif
"  }}}
" =============================================================================
"                          << 以下为Bundle包管理配置 >>
" =============================================================================
" {{{
    set nocompatible                                      "禁用 Vi 兼容模式
    filetype off                                          "Bundle包管理加载之前，必须禁用文件类型侦测

    source $VIM/vimfiles/personal/select-packages.vim
    nmap <leader>es :e $VIM/vimfiles/personal/select-packages.vim<CR>

    filetype on                                           "启用文件类型侦测
    filetype plugin on                                    "针对不同的文件类型加载对应的插件
    filetype plugin indent on                             "启用缩进
" }}}

" =============================================================================
"                          << 以下为常用自动命令配置 >>
" =============================================================================
" {{{
    " 自动切换目录为当前编辑文件所在目录
    au BufRead,BufNewFile,BufEnter * cd %:p:h
" }}}


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================
" {{{
    " 用kj代替esc
    imap kj <ESC>
    " set writebackup                             "保存文件前建立备份，保存成功后删除该备份
    set nobackup                                "设置无备份文件
    set noswapfile                              "设置无临时文件
    set vb t_vb=                                "关闭提示音
    " 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
    noremap <c-k> <c-w>k
    noremap <c-j> <c-w>j
    noremap <c-h> <c-w>h
    noremap <c-l> <c-w>l

    nnoremap <c-x>o <c-w><c-w>
    nnoremap <c-x>1 <c-w>o
    nnoremap <c-x>2 <c-w>s
    nnoremap <c-x>3 <c-w>v

    " Buffers/Tab操作快捷方式!
    nnoremap <s-h> :bprevious<cr>
    nnoremap <s-l> :bnext<cr>
    nnoremap <s-j> :tabnext<cr>
    nnoremap <s-k> :tabprev<cr>
" }}}

" =============================================================================
"                          << 其它 >>
" =============================================================================
" {{{
    " 注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
    " 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
    " 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键；如要修改"<leader>"键，可以把
    " 下面的设置取消注释，并修改双引号中的键为你想要的，如修改为逗号键。

if g:iswindows
    cd d:/
endif
" }}}
