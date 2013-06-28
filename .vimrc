"http://vim.wendal.net/
function! MySys()
  return "mac"
endfunction
"..........................ͼ�λ�����..................................................
" Maximized window when start vim
if MySys()=="windows"
    au GUIEnter * simalt ~x
endif
" ��Ĭ��Ϊ����ģʽ
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
"������״̬����ʾ����Ϣ���£�
"%F ��ǰ�ļ���
"%m ��ǰ�ļ��޸�״̬
"%r ��ǰ�ļ��Ƿ�ֻ��
"%Y ��ǰ�ļ�����
"%{&fileformat} ��ǰ�ļ���ʽ
"%{&fileencoding} ��ǰ�ļ�����
"%b ��ǰ��괦�ַ��� ASCII ��ֵ
"%B ��ǰ��괦�ַ���ʮ������ֵ
"%l ��ǰ����к�
"%c ��ǰ����к�
"%V ��ǰ��������к� (�����ַ���ռ�ֽ�������)
"%p ��ǰ��ռ�������İٷֱ�
"%% �ٷֺ�
"%L ��ǰ�ļ�������
set laststatus=2
"set statusline=%F%m%r\ \ %Y\ %{&fileencoding},%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]
set statusline=%F%m%r\ \ %{&fileencoding},%{&fileformat}\ \ \ %c,%l/%L\ %p%%
"..........................gvimȱʡ����..................................................
" disable VI's compatible mode..
set nocompatible
"...........................vim��ص����ֱ���.............................................
" �鿴�����ָ��
"set fenc
" ��ı����ָ��
"set fenc=utf-8
" vim���ڲ�(��buffer)ʹ�ñ���
"set encoding=utf-8
" �ն˱���
"set termencodings
" ������,�ر�ʱ,vim�ᰴ�ļ���ԭ����������,���������õ�utf-8
set fileencoding=gb2312
" ����²�
set fileencodings=gb2312,utf-8,cp936,gbk,gb18030,big5,latin1
" FileFormat
set ffs=unix,dos
set ff=unix
" set ff=dos
" default guifont fixedsys;
"set gfn=fixedsys
"set gfn=Consolas:h16
set gfn=Menlo:h16
"................................����Tab��....................
set shiftwidth=4 "����t�����ĳ���
set tabstop=8   "tab��ͬ�Ŀո񳤶ȣ����ۺ�shifwidth���һ��
set smarttab    "���tabstop��shiftwidth��ͬ������
set expandtab   "��TAB����4���ո����
".............................һ������.................................
" use chinese help
set helplang=cn
" ������ɫ
colorscheme desert 
"colorscheme morning 
" Enable syntax highlight
syntax enable
syntax on
" Show line number
set nu
" show matching bracets
set showmatch
" ��Tab��ʾΪ
set listchars=tab:>-,trail:-
set list
" Auto indent�����Զ�����,��ÿ�е�����ֵ����һ�����
set ai
" Smart indet
set si
" C-style indeting:���������˰������Ȼ��س�ʱ���������Զ�����һ�� TABSTOP ֵ�����������һ���һ�����ʱ�����Զ�����һ�� TABSTOP ֵ��
set cindent
set cino=(sus " public private friend ����д:0,g0,(sus
" ���ó��Ĵʱ�����������ʾ,���ڴʵĿհ״��Ͽ�
set lbr
" textwidth
set tw=0
" smart backspace Ĭ������¿ո��ֻ�ܱ����ƶ�
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
" Set magic on ħ������. �ı�����ģʽʹ�õ������ַ�.Ĭ�Ͼ��Ǵ򿪵�
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
set incsearch "����ʱ����
" Highlight search things ���������
set hlsearch
" Tell us anything is changed
set report=0
" Auto Change directory
set autochdir
" �۵�   zo:�� zc �ر� zM:��ȫ�� zR �ر�ȫ��
set foldlevel=3
" �հ����γɵĶ���
" set foldmethod=expr
" set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
" proc�γɵĶ���
"set foldmethod=expr
"set foldexpr=GetTclFold()
"set foldmethod=indent
set foldmethod=syntax
"set foldmethod=marker
"set nofoldenable
"..............................................����ӳ��...............................................
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
" Insertģʽ���������ƶ�
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
" ����ǰpyhon�ű� ǰ�����Ѿ����pyton��������
"map <C-F5> :w <CR> :!python.exe %<CR>
"map <F5> :!python.exe %<CR>
map <silent> <F5>    <leader>vv
map <F6>     :tp<CR>
map <F7>     :tn<CR>
" �Զ��Ű�
nnoremap <F8> 1G=G''
inoremap <F8> <ESC>1G=G''i
"map <F8> <ESC>ggVG=
" NERDTree
map <F9> :NERDTreeToggle<CR>
" TagList
map <F10> :TlistToggle<CR>
" ����tag�ļ�
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
filetype plugin on "�����ļ�����������
filetype indent on "�����ļ����͸ı��������Ű�
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
" ���ùؼ���
"set dictionary+=.\vimfiles\c-support\wordlists\c-c++-keywords.list
"set dictionary+=.\vimfiles\c-support\wordlists\stl_index.list
"set dictionary+=.\vimfiles\c-support\wordlists\ k+r.list
" ~/.vim/ftplugin/tcl.vim
" setting for omnicppcomplete
set complete-=k complete+=k
"set nocp
"set completeopt=longest,menu
let OmniCpp_DefaultNamespaces = ["std"]
" ������������еĲ�ȫ�ļ����ͣ����﷨��ȫ,ctrl-X,ctrl-O��
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

" ���ļ��༭ minibufexpl.vim
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
" pydiction python �Զ���ȫ���
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
