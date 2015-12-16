function! <SID>my_vimfiler_prompt(...)
    if !exists('b:vimfiler') 
        exec ":VimFiler -auto-cd" . join(a:000)
    endif
    exec ":VimFilerPrompt"
endfunction

command! -nargs=* MyVimFiler call <SID>my_vimfiler_prompt(<q-args>)
