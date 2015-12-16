" -----------------------------------------------------------------------------
"  < gtags 工具配置 >
" -----------------------------------------------------------------------------
" gtags = ctags + cscope

let g:Gtags_Auto_Map = 0

function! <SID>guessProjectRoot()
  let l:splitsearchdir = split(getcwd(), "/")

  while len(l:splitsearchdir) > 2
    let l:searchdir = '/'.join(l:splitsearchdir, '/').'/'
    for l:marker in ['GTAGS', 'GRTAGS', 'GPATH', '.rootdir', '.git', '.hg', '.svn', 'bzr', '_darcs', 'build.xml']
      " found it! Return the dir
      if filereadable(l:searchdir.l:marker) || isdirectory(l:searchdir.l:marker)
        return l:searchdir
      endif
    endfor
    let l:splitsearchdir = l:splitsearchdir[0:-2] " Splice the list to get rid of the tail directory
  endwhile

  " Nothing found, fallback to current working dir
  return getcwd()
endfunction

function! <SID>create_ctags_by_gtags()
    let l:cmd = 'gtags --gtagslabel=ctags '

    let l:cwd_back = getcwd()
    let l:cwd = s:guessProjectRoot()
    try
        exe "lcd ".l:cwd
    catch
        echom 'Failed to change directory to:'.l:cwd
    finally
        echon "Generate " | echohl NonText | echon "GTAGS ..." | echohl None | echo
        call system(l:cmd . l:cwd)
        exe "lcd ".l:cwd_back
    endtry

    echohl Function | echo "Generate tags in " . l:cwd . " [Done]" | echohl None
endfunction

command! -nargs=* MyGenCtagsByGtags call <SID>create_ctags_by_gtags()
