" -----------------------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
let g:neocomplcache_disable_auto_complete = 0 "不自动弹出补全列表
let g:neocomplcache_enable_auto_select = 1 "自动选择第一个候选项
" 在弹出补全列表后用 <m-p> 或 <m-n> 进行上下选择效果比较好
inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"
