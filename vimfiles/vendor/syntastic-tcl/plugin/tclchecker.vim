"============================================================================
"File:        init-syntastic-tcl.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  James Pickard <james.pickard at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"Notes:       Requires tclchecker v1.1.12 or later with support for -H option.
"             See tclchecker homepage http://tclchecker.berlios.de/.
"
"============================================================================

if exists("g:loaded_syntastic_tcl_tclchecker_checker")
    finish
endif
let g:loaded_syntastic_tcl_tclchecker_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_tcl_tclchecker_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'args_after': '-quiet -W3' })

    let errorformat =
        \ '%f:%l\ \(%s\)\ %m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'tcl',
    \ 'name': 'tclchecker'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:

