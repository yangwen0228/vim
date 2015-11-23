let s:conf_dir = g:personaldir . "/configures"

function! <SID>conf_source(...) 
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

" 这个文件必须最先执行，将vundle初始化
call <SID>conf_source('init-vundle.vim')

" vundle包加载及配置，注释使插件失效
call <SID>conf_source('init-a.vim', 'a.vim')
call <SID>conf_source('init-ack.vim', 'mileszs/ack.vim')
call <SID>conf_source('init-ctrlp.vim', 'ctrlpvim/ctrlp.vim')
call <SID>conf_source('tmhedberg/matchit')
" call <SID>conf_source('ecomba/vim-ruby-refactoring')
" call <SID>conf_source('sunaku/vim-ruby-minitest')
call <SID>conf_source('init-nerdtree.vim', 'scrooloose/nerdtree')
call <SID>conf_source('init-sessions.vim', 'xolox/vim-session')
call <SID>conf_source('xolox/vim-misc')
call <SID>conf_source('init-easymotion.vim', 'Lokaltog/vim-easymotion')
call <SID>conf_source('Valloric/YouCompleteMe')
" beated:
" clang_complete
" AutoComplPop
" Supertab
" neocomplcache
" call <SID>conf_source('init-neocomplcache.vim', 'Shougo/neocomplcache.vim')



call <SID>conf_source('init-align.vim', 'Align')
call <SID>conf_source('init-auto-pairs.vim', 'jiangmiao/auto-pairs')
call <SID>conf_source('init-bufexplorer.vim', 'bufexplorer.zip')
call <SID>conf_source('init-c.vim', 'std_c.zip')
call <SID>conf_source('init-ccvext.vim', 'ccvext.vim')
call <SID>conf_source('init-cscope.vim')
call <SID>conf_source('init-csyntax.vim', 'cSyntaxAfter')
call <SID>conf_source('init-ctags.vim')
call <SID>conf_source('init-easygrep.vim', 'EasyGrep')
call <SID>conf_source('init-emmet.vim', 'mattn/emmet-vim')
call <SID>conf_source('init-full-screen.vim')
call <SID>conf_source('init-gtags.vim', 'aceofall/gtags.vim')
call <SID>conf_source('init-html.vim')
call <SID>conf_source('init-indent-line.vim', 'Yggdroot/indentLine')
call <SID>conf_source('init-java-complete.vim', 'vim-javacompleteex')
call <SID>conf_source('init-mark.vim', 'Mark--Karkat')

call <SID>conf_source('init-mini-buf.vim')
call <SID>conf_source('init-mru.vim', 'yegappan/mru')

call <SID>conf_source('init-nerdcommenter.vim', 'scrooloose/nerdcommenter')
call <SID>conf_source('init-omnicppcomplete.vim', 'OmniCppComplete')
call <SID>conf_source('init-powerline.vim', 'Lokaltog/vim-powerline')
call <SID>conf_source('init-quickfix.vim')
call <SID>conf_source('init-repeat.vim', 'repeat.vim')
call <SID>conf_source('init-snipmate.vim', 'msanders/snipmate.vim')
call <SID>conf_source('init-src-expl.vim', 'wesleyche/SrcExpl')
call <SID>conf_source('init-surround.vim', 'tpope/vim-surround')
call <SID>conf_source('init-syntastic.vim', 'scrooloose/syntastic')
call <SID>conf_source('init-tagbar.vim', 'majutsushi/tagbar')
call <SID>conf_source('init-taglist.vim', 'taglist.vim')
call <SID>conf_source('init-theme.vim', 'altercation/vim-colors-solarized')
call <SID>conf_source('init-txtbrowser.vim', 'TxtBrowser')
call <SID>conf_source('init-vimacs.vim', 'andrep/vimacs')
call <SID>conf_source('init-vimtweak.vim')
call <SID>conf_source('init-zoom-win.vim', 'ZoomWin')
