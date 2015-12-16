let s:conf_dir = g:personaldir . '/configures'

function! <SID>add_local_plugin(...) 
    if a:0 == 0
        " no args
    else
        " check has init file
        if a:1 =~ 'init-' " has init file
            if a:0 == 1 " has only one arg, the init file
            elseif a:0 == 2 " has two args, the init file and bundle
                let full_path = g:vendordir . '/' . a:2

                exec 'set rtp^='.fnameescape(full_path)
                exec 'set rtp+='.fnameescape(full_path . '/after')
            elseif a:0 == 3 " the init file , bundle and bundle options
                " bundle and options
            endif
            let full_path = s:conf_dir . '/' . a:1
            exe "source" full_path
        else " has no init files
            if a:0 == 1 " has only one arg, the bundle
                let full_path = g:vendordir . '/' . a:1

                exec 'set rtp^='.fnameescape(full_path)
                exec 'set rtp+='.fnameescape(full_path . '/after')
            elseif a:0 == 2 " has two args, the bundle and options
                " bundle and options
            endif
        endif
    endif
endfunction

function! <SID>add_plugin(...) 
    if a:0 == 0
        " no args
    else
        " check has init file
        if a:1 =~ "init-" " has init file
            if a:0 == 1 " has only one arg, the init file
            elseif a:0 == 2 " has two args, the init file and bundle
                call vundle#config#bundle(a:2)
            elseif a:0 == 3 " the init file , bundle and bundle options
                " bundle and options
                call vundle#config#bundle(a:2, a:3)
            endif
            let full_path = s:conf_dir . "/" . a:1
            exe "source" full_path
        else " has no init files
            if a:0 == 1 " has only one arg, the bundle
                call vundle#config#bundle(a:1)
            elseif a:0 == 2 " has two args, the bundle and options
                " bundle and options
                call vundle#config#bundle(a:1, a:2)
            endif
        endif
    endif
endfunction

command -nargs=+ -bar MyAddLocalPlugin call <SID>add_local_plugin(<args>)
command -nargs=+ -bar MyAddPlugin call <SID>add_plugin(<args>)

" =============================================================================
"                          << Vundle 初始化 >>
" =============================================================================
" 这个文件必须最先执行，将vundle初始化
MyAddPlugin 'init-vundle.vim'
MyAddPlugin 'init-exec-path.vim'

" =============================================================================
"                          << 窗口布局类插件 >>
" =============================================================================
" MyAddPlugin 'init-sessions.vim', 'xolox/vim-session'
MyAddPlugin 'xolox/vim-misc'
MyAddPlugin 'init-nerdtree.vim', 'scrooloose/nerdtree'
MyAddPlugin 'init-tagbar.vim', 'majutsushi/tagbar'
" MyAddPlugin 'init-airline.vim', 'bling/vim-airline'
" beated:
MyAddPlugin 'init-powerline.vim', 'Lokaltog/vim-powerline'
MyAddPlugin 'init-full-screen.vim'
MyAddPlugin 'init-quickfix.vim'
MyAddPlugin 'init-theme.vim', 'altercation/vim-colors-solarized'
MyAddPlugin 'init-vimacs.vim', 'andrep/vimacs'
MyAddPlugin 'init-vimtweak.vim'
MyAddPlugin 'init-zoom-win.vim', 'ZoomWin'
" =============================================================================
"                          << 文件及buffer插件 >>
" =============================================================================
MyAddPlugin 'init-vimfiler.vim', 'Shougo/vimfiler.vim'
MyAddLocalPlugin 'init-vimfiler-prompt.vim', 'vimfiler-prompt'
" MyAddPlugin 'romgrk/vimfiler-prompt'
MyAddPlugin 'Shougo/unite.vim'
MyAddPlugin 'Shougo/unite-outline'
MyAddPlugin 'Shougo/unite-session'
MyAddPlugin 'thinca/vim-unite-history'
MyAddPlugin 'Shougo/neomru.vim'
MyAddPlugin 'init-unite.vim'
" MyAddPlugin 'init-ctrlp.vim', 'ctrlpvim/ctrlp.vim'
" beated:
" MyAddPlugin 'init-mru.vim', 'yegappan/mru'
" =============================================================================
"                          << 编辑类插件 >>
" =============================================================================
MyAddPlugin 'init-delimit-mate.vim', 'Raimondi/delimitMate'
MyAddPlugin 'init-rainbow-parens.vim', 'kien/rainbow_parentheses.vim'
MyAddPlugin 'init-surround.vim', 'tpope/vim-surround'
MyAddPlugin 'init-repeat.vim', 'tpope/vim-repeat'
MyAddPlugin 'init-multiple-cursors.vim', 'terryma/vim-multiple-cursors'
MyAddPlugin 'init-easy-align.vim', 'junegunn/vim-easy-align'

MyAddPlugin 'init-expand-region.vim', 'terryma/vim-expand-region'

MyAddPlugin 'init-undotree.vim', 'mbbill/undotree'
" beated:
" MyAddPlugin 'sjl/gundo.vim'
MyAddPlugin 'init-nerdcommenter.vim', 'scrooloose/nerdcommenter'
" MyAddPlugin 'init-snipmate.vim', 'msanders/snipmate.vim'
MyAddPlugin 'SirVer/ultisnips'
MyAddPlugin 'honza/vim-snippets'
" =============================================================================
"                          << 搜索类插件 >>
" =============================================================================
MyAddPlugin 'rking/ag.vim'
" Only use its Replace feature.
MyAddPlugin 'EasyGrep'
MyAddPlugin 'init-ctrlsf.vim', 'dyng/ctrlsf.vim'
" =============================================================================
"                          << 跳转类插件 >>
" =============================================================================
MyAddPlugin 'init-easymotion.vim', 'Lokaltog/vim-easymotion'
MyAddPlugin 'kshenoy/vim-signature'
MyAddPlugin 'init-mark.vim', 'Mark--Karkat'
MyAddPlugin 'tmhedberg/matchit'
MyAddPlugin 'init-gtags.vim', 'jsfaint/gen_tags.vim'
MyAddPlugin 'init-unite-gtags.vim', 'hewes/unite-gtags'
" beated:
" MyAddPlugin 'init-gtags.vim', 'aceofall/gtags.vim'

" MyAddPlugin 'init-ccvext.vim', 'ccvext.vim'
" MyAddPlugin 'init-ctags.vim'
" only to c/c++
" MyAddPlugin 'init-ctrlp-funky.vim', 'tacahiroy/ctrlp-funky'
" MyAddPlugin 'init-cscope.vim'
" =============================================================================
"                          << shell插件 >>
" =============================================================================
MyAddPlugin 'Shougo/vimproc.vim'
MyAddPlugin 'Shougo/vimshell.vim'
" =============================================================================
"                          << 语言通用插件 >>
" =============================================================================
MyAddPlugin 'init-ycm.vim', 'Valloric/YouCompleteMe'
" beated:
" clang_complete
" AutoComplPop
" Supertab
" neocomplcache
" MyAddPlugin 'init-neocomplcache.vim', 'Shougo/neocomplcache.vim'
MyAddPlugin 'init-syntastic.vim', 'scrooloose/syntastic'
MyAddPlugin 'init-quick-run.vim', 'thinca/vim-quickrun'
" =============================================================================
"                          << c/c++语言插件 >>
" =============================================================================
" MyAddPlugin 'init-a.vim', 'a.vim'
" MyAddPlugin 'init-c.vim', 'std_c.zip'
" MyAddPlugin 'init-csyntax.vim', 'cSyntaxAfter'
" =============================================================================
"                          << tcl语言插件 >>
" =============================================================================
MyAddLocalPlugin 'init-syntastic-tcl.vim', 'syntastic-tcl'
" =============================================================================
"                          << python语言插件 >>
" =============================================================================
" =============================================================================
"                          << 其他语言插件 >>
" =============================================================================
MyAddPlugin 'init-emmet.vim', 'mattn/emmet-vim'
" MyAddPlugin 'ecomba/vim-ruby-refactoring'
" MyAddPlugin 'sunaku/vim-ruby-minitest'
" MyAddPlugin 'init-html.vim'
" MyAddPlugin 'init-java-complete.vim', 'vim-javacompleteex'
" MyAddPlugin 'init-txtbrowser.vim', 'TxtBrowser'
