" {{{ plugin - Session.vim 会话记录
"自动载入会话
let g:session_autoload = 1
"自动保存会话
let g:session_autosave = 1
set shellquote=
set shellslash
set shellxquote=
set shellpipe=2>&1\|tee
set shellredir=>%s\ 2>&1
let g:session_directory=g:tempfilesdir
" }}}
