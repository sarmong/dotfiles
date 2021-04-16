let g:gitgutter_map_keys = 0

let g:gitgutter_grep = 'rg'

nmap ]h <Plug>(GitGutterNextHunk)

nmap [h <Plug>(GitGutterPrevHunk)

au BufEnter * :GitGutterLineNrHighlightsEnable
