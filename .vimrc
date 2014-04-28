"http://vim.wendal.net/
function! MySys()
  return "mac"
endfunction
"..........................图形话界面..................................................
" Maximized window when start vim
if MySys()=="windows"
    au GUIEnter * simalt ~x
endif
" 设默认为插入模式
"set im
"autocmd! bufwritepost _vimrc source $VIM/_vimrc
" Open the file and goto the last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"source $VIMRUNTIME/mswin.vim
if has("gui_running")
    " If the current buffer has never been saved, it will have no name,
    " call the file browser to save it, otherwise just save it.
    map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
endif

" left scroll
set guioptions-=L
" right scroll
set guioptions+=r
"set guioptions+=a
" show the columns and rows
set ruler
" Not Maximized when start, set the window width
"set columns=90
" wild menu
set wildmenu
"设置在状态行显示的信息如下：
"%F 当前文件名
"%m 当前文件修改状态
"%r 当前文件是否只读
"%Y 当前文件类型
"%{&fileformat} 当前文件格式
"%{&fileencoding} 当前文件编码
"%b 当前光标处字符的 ASCII 码值
"%B 当前光标处字符的十六进制值
"%l 当前光标行号
"%c 当前光标列号
"%V 当前光标虚拟列号 (根据字符所占字节数计算)
"%p 当前行占总行数的百分比
"%% 百分号
"%L 当前文件总行数
set laststatus=2
"set statusline=%F%m%r\ \ %Y\ %{&fileencoding},%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]
set statusline=%F%m%r\ \ %{&fileencoding},%{&fileformat}\ \ \ %c,%l/%L\ %p%%
"..........................gvim缺省设置..................................................
" disable VI's compatible mode..
set nocompatible
"...........................vim相关的四种编码.............................................
" 查看编码的指令
"set fenc
" 需改编码的指令
"set fenc=utf-8
" vim的内部(如buffer)使用编码
"set encoding=utf-8
" 终端编码
"set termencodings
" 如设置,关闭时,vim会按文件的原来编码设置,如这里设置的utf-8
set fileencoding=gb2312
" 编码猜测
set fileencodings=gb2312,utf-8,cp936,gbk,gb18030,big5,latin1
" FileFormat
set ffs=unix,dos
set ff=unix
" set ff=dos
" default guifont fixedsys;
"set gfn=fixedsys
"set gfn=Consolas:h16
set gfn=Menlo:h16
"................................设置Tab键....................
set shiftwidth=4 "设置t缩进的长度
set tabstop=8   "tab等同的空格长度，美观和shifwidth最好一样
set smarttab    "解决tabstop，shiftwidth不同的问题
set expandtab   "将TAB符用4个空格代替
".............................一般设置.................................
" use chinese help
set helplang=cn
" 设置颜色
colorscheme desert 
"colorscheme morning 
" Enable syntax highlight
syntax enable
syntax on
" Show line number
set nu
" show matching bracets
set showmatch
" 将Tab显示为
set listchars=tab:>-,trail:-
set list
" Auto indent设置自动缩进,即每行的缩进值与上一行相等
set ai
" Smart indet
set si
" C-style indeting:当你输入了半条语句然后回车时，缩进会自动增加一个 TABSTOP 值，当你键入了一个右花括号时，会自动减少一个 TABSTOP 值。
set cindent
set cino=(sus " public private friend 顶格写:0,g0,(sus
" 不让长的词被分作两行显示,会在词的空白处断开
set lbr
" textwidth
set tw=0
" smart backspace 默认情况下空格键只能本行移动
set backspace=start,indent,eol
" Wrap lines
set wrap
"set nowrap
" Sets how many lines of history VIM har to remember
set history=100
" Set to auto read when a file is changed from the outside
set autoread
" Have the mouse enabled all the time:
set mouse=a
" Do not redraw, when running macros.. lazyredraw
set lz
" set 7 lines to the curors - when moving vertical..
set so=7
" The commandbar is 2 high
set cmdheight=2
" Change buffer - without saving
set hid
" Set magic on 魔法配置. 改变搜索模式使用的特殊字符.默认就是打开的
set magic
" No sound on errors.
set noerrorbells
set novisualbell
set vb t_vb=
" How many tenths of a second to blink
set mat=4
" Turn backup off
set nobackup
set nowb
set noswapfile
" Ignore case when searching
set ignorecase 
set incsearch "搜索时高亮
" Highlight search things 搜索后高亮
set hlsearch
" Tell us anything is changed
set report=0
" Auto Change directory
set autochdir
" 折叠   zo:打开 zc 关闭 zM:打开全部 zR 关闭全部
set foldlevel=3
" 空白行形成的段落
" set foldmethod=expr
" set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
" proc形成的段落
"set foldmethod=expr
"set foldexpr=GetTclFold()
"set foldmethod=indent
set foldmethod=syntax
"set foldmethod=marker
"set nofoldenable
"..............................................键盘映射...............................................
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Set mapleader
let g:mapleader = ","
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> *    :call VisualSelection('f')<CR>
vnoremap <silent> #    :call VisualSelection('b')<CR>
vnoremap <silent> <CR> :call VisualSelection('gv')<CR>
vnoremap <silent> R    :call VisualSelection('replace')<CR>
if MySys()=="windows"
    " source vimrc
    map <silent> <leader>ss :source $VIM/_vimrc<CR>
    " edit vimrc
    map <silent> <leader>ee :e $VIM/_vimrc<CR>
    " edit hm11.list
    map <silent> <leader>hm :e $VIM/vimfiles/hm11.list<CR>
    " snipMate
    let g:snippets_dir='$VIM/vimfiles/snippets'
    set dictionary+=$VIM/vimfiles/hm11.list
    set dictionary+=$VIM/vimfiles/post.list
else
    " source vimrc
    map <silent> <leader>ss :source ~/.vimrc<CR>
    " edit vimrc
    map <silent> <leader>ee :e ~/.vimrc<CR>
    " edit hm11.list
    map <silent> <leader>hm :e ~/.vim/hm11.list<CR>
    " snipMate
    let g:snippets_dir='~/.vim/snippets'

    set dictionary+=~/.vim/hm11.list
    set dictionary+=~/.vim/post.list
endif
" copy a word
"nnoremap <leader>c bye<CR>
" replace a word
"nnoremap <leader>v bPlde<CR>
"map <F2> :nohlsearch<CR>
nmap <leader>+ : %s/(/ /g<CR>   : %s/)/ /g<CR> : %s/,/ /g<CR>
vmap <leader>+ : s/(/ /g<CR>    : %s/)/ /g<CR> : %s/,/ /g<CR>
"map <leader>#  : s/^/#/g<CR>    : nohl<CR>
"map <leader>*  : s/^\s*#//g<CR> : nohl<CR>
" Insert模式左右上下移动
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-k> <up>
inoremap <c-j> <down>
" normal mode jump between window
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz : m+<cr>`z
nmap <M-k> mz : m-2<cr>`z
vmap <M-j>    : m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k>    : m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

inoremap kj <ESC>;
nnoremap <Leader>w :w<CR>;
" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" close a buffer and not close current window
map <C-F1> :bd<CR>
" switch buffers with Tab
map bp :bp<CR>
map bn :bn<CR>
map cp :cp<CR>
map cn :cn<CR>
map b1 :b1<CR>
map b2 :b2<CR>
map b3 :b3<CR>
map b4 :b4<CR>
map b5 :b5<CR>
map b6 :b6<CR>
map b7 :b7<CR>
map b8 :b8<CR>
map b9 :b9<CR>
" 允许当前pyhon脚本 前提是已经添加pyton环境变量
"map <C-F5> :w <CR> :!python.exe %<CR>
"map <F5> :!python.exe %<CR>
map <silent> <F5>    <leader>vv
map <F6>     :tp<CR>
map <F7>     :tn<CR>
" 自动排版
nnoremap <F8> 1G=G''
inoremap <F8> <ESC>1G=G''i
"map <F8> <ESC>ggVG=
" NERDTree
map <F9> :NERDTreeToggle<CR>
" TagList
map <F10> :TlistToggle<CR>
" 生成tag文件
map <C-F12> :!ctags -R --fields=+li --tcl-kinds=+pcm --fields=+iaS --extra=+q .<CR>
""""""""""""""""""""
"
""""""""""""""""""""

" load session from certain path
command! -nargs=+ LOAD call GetMySession(<f-args>)

" load session from certain path
command! -nargs=+ SAVE call SetMySession(<f-args>)



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => Plugin configuration

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on "根据文件类型引入插件
filetype indent on "根据文件类型改变缩进和排版
" ctags
set tags=tags;
"set tags+=$VIM/vimfiles/cpp_src/tags
"set tags+=$VIM/vimfiles/windows_src/tags
" taglist
let Tlist_Ctags_Cmd                  = 'ctags'
let Tlist_Auto_Highlight_Tag         = 1
let Tlist_Auto_Open                  = 0
let Tlist_Auto_Update                = 1
let Tlist_Close_On_Select            = 0
let Tlist_Compact_Format             = 0
let Tlist_Display_Prototype          = 0
let Tlist_Display_Tag_Scope          = 1
let Tlist_Enable_Fold_Column         = 0
let Tlist_Exit_OnlyWindow            = 1
let Tlist_File_Fold_Auto_Close       = 1
let Tlist_GainFocus_On_ToggleOpen    = 0
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth               = 0
let Tlist_Max_Submenu_Items          = 0
let Tlist_Max_Tag_Length             = 30
let Tlist_Process_File_Always        = 0
let Tlist_Show_Menu                  = 0
let Tlist_Show_One_File              = 1
"let Tlist_Sort_Type                 = "order"
let Tlist_Sort_Type                  = "name"
let Tlist_Use_Horiz_Window           = 0
let Tlist_Use_Right_Window           = 0
let Tlist_WinWidth                   = 40
"let tlist_php_settings = 'php;c:class;i:interfaces;d:constant;f:function'
" NERDTree
let NERDTreeWinSize = 17
" 设置关键字
"set dictionary+=.\vimfiles\c-support\wordlists\c-c++-keywords.list
"set dictionary+=.\vimfiles\c-support\wordlists\stl_index.list
"set dictionary+=.\vimfiles\c-support\wordlists\ k+r.list
" ~/.vim/ftplugin/tcl.vim
" setting for omnicppcomplete
set complete-=k complete+=k
"set nocp
"set completeopt=longest,menu
let OmniCpp_DefaultNamespaces = ["std"]
" 如果不存在已有的补全文件类型，则按语法补全,ctrl-X,ctrl-O；
"if has("autocmd") && exists("+omnifunc")
    "autocmd Filetype *
                "\	if &omnifunc == "" |
                "\		setlocal omnifunc=syntaxcomplete#Complete |
                "\	endif
"endif

""""""""""""""""""""""""""""""
" winManager setting
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F>          : FirstExplorerWindow<cr>
nmap <C-W><C-B>          : BottomExplorerWindow<cr>
nmap <silent> <leader>wm : WMToggle<cr>

" 多文件编辑 minibufexpl.vim
let g:miniBufExplMapCTabSwitchBufs  = 1
let g:miniBufExplMapWindowsNavVim   = 1
let g:miniBufExplMapWindowNavArrows = 1

" Vim Grep
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn .a .o'
let Grep_Cygwin_Find = 1
" EasyGrepOpions
let g:EasyGrepMode                       = 2
let g:EasyGrepCommand                    = 0
let g:EasyGrepRecursive                  = 1
let g:EasyGrepIgnoreCase                 = 1
let g:EasyGrepHidden                     = 0
let g:EasyGrepAllOptionsInExplorer       = 0
let g:EasyGrepWindow                     = 0
let g:EasyGrepReplaceWindowMode          = 0
let g:EasyGrepOpenWindowOnMatch          = 1
let g:EasyGrepEveryMatch                 = 0
let g:EasyGrepJumpToMatch                = 1
let g:EasyGrepInvertWholeWord            = 0
let g:EasyGrepFileAssociationsInExplorer = 0
let g:EasyGrepOptionPrefix               = '<leader>vy'
let g:EasyGrepReplaceAllPerFile          = 0
" pydiction python 自动补全插件
"let g:pydiction_location ='~/vimfiles/tools/pydiction/complete-dict'

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Grep " . ' '. l:pattern
    elseif a:direction == 'replace'
        let str_get = input("Replace as:", "")
        execute "%s" . '/'. l:pattern . '/' . str_get . '/' . "g"
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! GetTclFold()
    if getline(v:lnum) =~ '^\s*proc\s'
        return "0"
        "       if getline(v:lnum-1) =~ '^\s*proc\s'
        "           return "a1"
        "       else
        "           return ">1"
        "       endif
    elseif getline(v:lnum) =~ '\}\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "0"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
                " do nothing
            elseif my_perldata =~ '^\s*sub\s'
                return "s1"
            else
                return "="
            endif
        endwhile
    elseif getline(v:lnum-1) =~ '^\s*proc\s'
        return "a1"
    else
        return "="
    endif
endfunction
function! GetPerlFold()
    if getline(v:lnum) =~ '^\s*sub\s'
        return ">1"
    elseif getline(v:lnum) =~ '\}\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
                " do nothing
            elseif my_perldata =~ '^\s*sub\s'
                return "<1"
            else
                return "="
            endif
        endwhile
    else
        return "="
    endif
endfunction

function! GetMySession(spath, ssname)
    if a:ssname == 0
        let a:sname = ""
    else
        let a:sname = "-".a:ssname
    endif
    execute "source ".a:spath."/session".a:sname.".vim"
    execute "rviminfo ".a:spath."/session".a:sname.".viminfo"
    execute "echo \"Load Success\: ".a:spath."/session".a:sname.".vim\""
endfunction

function! SetMySession(spath, ssname)
    if a:ssname == 0
        let a:sname = ""
    else
        let a:sname = "-".a:ssname
    endif
    execute "cd ".a:spath
    execute "mksession! ".a:spath."/session".a:sname.".vim"
    execute "wviminfo! ".a:spath."/session".a:sname.".viminfo"
    execute "echo \"Save Success\: ".a:spath."/session".a:sname.".vim\""
endfunction
