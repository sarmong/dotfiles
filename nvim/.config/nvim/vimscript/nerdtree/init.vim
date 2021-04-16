" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
"
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let NERDTreeShowHidden=1
let NERDTreeWinSize=40

        call NERDTreeAddKeyMap({
               \ 'key': 'foo',
               \ 'callback': 'NERDTreeEchoPathHandler',
               \ 'quickhelpText': 'echo full path of current node',
               \ 'scope': 'DirNode' })

" call NERDTreeAddKeyMap({
" 	\ 'key': 'l',
" 	\ 'callback': 'NERDTreeMapActivateNode',
" 	\ 'quickhelpText': '',
" 	\ 'override': '1'
"   \ })
" call NERDTreeAddKeyMap({
" 	\ 'key': 'h',
" 	\ 'callback': 'NERDTreeMapCloseDir'
"   \ })
