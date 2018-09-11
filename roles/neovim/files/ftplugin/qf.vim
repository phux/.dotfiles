let g:qf_loclist_window_bottom = 0
let g:qf_nowrap = 0
let g:qf_mapping_ack_style = 1

let g:qf_statusline = {}
let g:qf_statusline.before = '%<\ '
let g:qf_statusline.after = '\ %f%=%l\/%-6L\ \ \ \ \ '

nnoremap <buffer> <c-n> <Plug>(qf_loc_next)
nnoremap <buffer> <c-p> <Plug>(qf_loc_previous)
