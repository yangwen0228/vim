" -----------------------------------------------------------------------------
"  < gtags 工具配置 >
" -----------------------------------------------------------------------------
" gtags = ctags + cscope
set cscopetag " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope


" gtags.vim 设置项
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
