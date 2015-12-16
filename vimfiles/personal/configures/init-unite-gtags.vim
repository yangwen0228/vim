nnoremap <m-t> :execute 'Unite gtags/def:'.expand('<cword>')<CR>
nnoremap <m-c> :execute 'Unite gtags/context:'.expand('<cword>')<CR>
nnoremap <m-r> :execute 'Unite gtags/ref:'.expand('<cword>')<CR>
nnoremap <m-g> :execute 'Unite gtags/grep:'.expand('<cword>')<CR>
nnoremap <m-f> :execute 'Unite gtags/file'<CR>
