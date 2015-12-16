function! s:add_path (software)
    let $PATH = g:utilsdir . "\\extra-bins\\" . a:software . "\\bin" . ";" . $PATH
endfunction

if g:iswindows
    for software in ["glo651wb", "ag", "ctags5.8", "cscope"]
        call s:add_path(software)
    endfor
    let $GTAGSCONF = g:utilsdir . "/extra-bins/glo651wb/share/gtags/gtags.conf"

    let $PATH .= ";" . g:utilsdir . "\\extra-dlls\\win32"
    let $PATH .= ";" . g:utilsdir . "\\extra-dlls\\win64"
endif
