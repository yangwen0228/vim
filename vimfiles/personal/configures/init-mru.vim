"设置默认保存最近打开文件列表的文件，默认$HOME/.vim_mru_files；
let MRU_File=g:tempfilesdir . '/_mru_files' 

"设置默认记录的打开文件数量，默认100；
let MRU_Max_Entries = 100

"设置默认不包含哪些文件，默认空；
let MRU_Exclude_Files = '^/tmp/.*|^/var/tmp/.*'

"设置默认只包含哪些文件，默认空；
" let MRU_Include_Files = '.c$|.h$'

"设置MRU窗口的高度，默认8；
let MRU_Window_Height = 15

"设置默认在本窗口打开最近文件列表，而不是新的窗口；
let MRU_Use_Current_Window = 1

"设置默认不关闭MRU窗口，默认关闭；
let MRU_Auto_Close = 0

"设置MRU窗口默认显示多少条记录，默认10；
let MRU_Max_Menu_Entries = 20
"设置MRU窗口默认子菜单显示多少条记录，默认10。
"如果有太多的记录显示在MRU窗口时，记录会被分割成子菜单，
"该配置设置子菜单里显示多少条记录；
let MRU_Max_Submenu_Entries = 15
