setlocal tabstop=2 sts=2 sw=2 expandtab

set foldmethod=indent
set foldenable

let g:indent_guides_color_change_percent=2
IndentGuidesEnable

let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'go', 'php', 'js']
nnoremap <leader>; :Vista coc<cr>
