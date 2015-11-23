" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
" if has("cscope")
    " "设定可以使用 quickfix 窗口来查看 cscope 结果
    " set cscopequickfix=s-,c-,d-,i-,t-,e-
    " "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    " set cscopetag
    " "如果你想反向搜索顺序设置为1
    " set csto=0
    " "在当前目录中添加任何数据库
    " if filereadable("cscope.out")
        " cs add cscope.out
    " "否则添加数据库环境中所指出的
    " elseif $CSCOPE_DB != ""
        " cs add $CSCOPE_DB
    " endif
    " set cscopeverbose
    " "快捷键设置
    " nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    " nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" endif
