"  < vimacs 插件配置 >
" -----------------------------------------------------------------------------
" 主要模拟emacs的按键
let g:VM_Enabled = 1
noremap <C-x><C-f> <C-o>:MyVimFiler<CR>
noremap <C-x>b :<C-u>Unite -auto-resize -buffer-name=buffers buffer file_mru<cr>
noremap <C-x>k :bd<cr>
